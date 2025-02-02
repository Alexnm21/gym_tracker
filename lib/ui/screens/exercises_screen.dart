import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_tracker/domain/controllers/category_controller.dart';
import 'package:gym_tracker/domain/models/models.dart';
import 'package:gym_tracker/data/repositories/categories_repository.dart';
import 'package:gym_tracker/data/repositories/exercises_repository.dart';
import 'package:gym_tracker/ui/widgets/widgets.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {

  List<ExerciseCategory> categories = [];
  bool loading = true;
  CategoryController categoryCtrl = Get.find();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    categories = await CategoriesRepository().getCategories();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicios'),
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

          if (categoryCtrl.exercises.isEmpty) const Center(child: Text('Añade aquí tus ejercicios.'))
          else Expanded(
            child: ListView.builder(
              itemCount: categoryCtrl.exercises.length,
              itemBuilder: (BuildContext context, int index) {
                return DeleteDismissible(
                  deleteConfimText: '¿Estás seguro de eliminar este ejercicio? Si lo haces perderás todo su historial.',
                  onConfirm: (direction) {
                    ExercisesRepository().deleteExercise(index);
                    setState(() {
                      categoryCtrl.exercises.removeAt(index);
                    });
                  },
                  child: GestureDetector(
                    onTap: () {
                      categoryCtrl.showAddExerciseDialog(context:context, exercise: categoryCtrl.exercises[index], index: index);
                    },
                    child: ExerciseContainer(exercise: categoryCtrl.exercises[index])
                    )
                  );
            },
                  ),
          )
        ],
      )    
    );
  }
}