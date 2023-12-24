import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_tracker/config/app_theme.dart';
import 'package:gym_tracker/config/database.dart';
import 'package:gym_tracker/controllers/category_controller.dart';
import 'package:gym_tracker/controllers/training_controller.dart';
import 'package:gym_tracker/models/models.dart';
import 'package:gym_tracker/screens/screens.dart';
import 'package:gym_tracker/services/categories_service.dart';
import 'package:gym_tracker/services/exercises_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(ExerciseCategoryAdapter());
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(TrainingAdapter());
  Hive.registerAdapter(SerieAdapter());
  categoryBox = await Hive.openBox<ExerciseCategory>('categoryBox');
  exerciseBox = await Hive.openBox<Exercise>('exerciseBox');
  trainingBox = await Hive.openBox<Training>('trainingBox');

  CategoryController categoryCtrl = Get.put(CategoryController());
  TrainingController trainingCtrl = Get.put(TrainingController());

  categoryCtrl.categories = await CategoriesService().getCategories();
  categoryCtrl.exercises = await ExercisesService().getExercises();

  trainingCtrl.exercises.value = categoryCtrl.exercises;
  trainingCtrl.loadTrainings();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Gym Track',
      home: const HomeScreen(),
      theme: AppTheme.customThemeData,
    );
  }
}