import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_tracker/config/app_theme.dart';
import 'package:gym_tracker/config/utils.dart';
import 'package:gym_tracker/controllers/category_controller.dart';
import 'package:gym_tracker/controllers/training_controller.dart';
import 'package:gym_tracker/models/models.dart';
import 'package:gym_tracker/screens/training_details_screen.dart';
import 'package:gym_tracker/widgets/widgets.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    TrainingController trainingCtrl = Get.find();
    CategoryController categoryCtrl = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Elige el ejercicio'),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                categoryCtrl.showAddExerciseDialog(context: context);
              },)
        ],
      ),
      body: Column(
        children: [
          const CategoryFilter(),
          Obx(()=> _ExerciseList(exercises: trainingCtrl.exercises.toList()))
        ],
      )
    );
  }
}




class _ExerciseList extends StatelessWidget {
  const _ExerciseList({required this.exercises});

  final List<Exercise> exercises;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: exercises.length,
      itemBuilder: (BuildContext context, int index) {
        return _ExerciseCard(exercise: exercises[index]);
      },
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  const _ExerciseCard({required this.exercise});

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.off(()=> TrainingDetailsScreen(exercise: exercise));
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 50,
        decoration: BoxDecoration(
          gradient: createGradientFromColor(Color(exercise.category.color)), 
          borderRadius: BorderRadius.circular(30)
        ),
        
        child: Center(child: Text(exercise.name, style: AppTheme.h6Bold.copyWith(color: Colors.white, shadows: textShadow()),),),
      ),
    );
  }
}