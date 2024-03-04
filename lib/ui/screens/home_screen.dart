import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_tracker/config/app_theme.dart';
import 'package:gym_tracker/domain/controllers/training_controller.dart';
import 'package:gym_tracker/ui/screens/training_details_screen.dart';
import 'package:gym_tracker/ui/screens/training_screen.dart';
import 'package:gym_tracker/data/repositories/trainings_repository.dart';
import 'package:gym_tracker/ui/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TrainingController trainingCtrl = Get.find();
  @override
    void initState() {
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('GymTracker'),
        actions: [
          IconButton(onPressed: (){Get.to(()=> const TrainingScreen());}, icon: const Icon(Icons.add))
        ],
      ),
      
      drawer: const CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Text('${getWeekDay(DateTime.now())} ${DateTime.now().day}', style: AppTheme.h4Bold,),
            const DatePicker(),
            Obx((){
              if (trainingCtrl.loading.value) return const CircularProgressIndicator();
              if (trainingCtrl.trainings.toList().isEmpty) {
                return Padding(
                padding: const EdgeInsets.only(top: 200),
                child: GradientButton(onPressed: (){Get.to(()=> const TrainingScreen());}, text: 'Añadir entrenamiento', gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.hover])),
              );
              }
              return Expanded(
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: trainingCtrl.trainings.toList().length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(TrainingDetailsScreen(exercise: trainingCtrl.trainings[index].exercise, previousTraining: trainingCtrl.trainings[index]));
                      },
                      child: DeleteDismissible(
                        deleteConfimText: '¿Estás seguro que quieres eliminar el entrenamiento de ${trainingCtrl.trainings[index].exercise.name}?',
                        onConfirm: () {
                          TrainingsRepository().deleteTraining(index);
                          trainingCtrl.trainings.removeAt(index);
                          trainingCtrl.loadTrainings();
                          setState(() {});
                        },
                        child: TrainingContainer(training: trainingCtrl.trainings.toList()[index])
                      )   
                      );
                },
                ),
              );
            } 
            ),
            ]
        ),
      ),
    );
  }
}