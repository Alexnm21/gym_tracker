import 'package:flutter/material.dart';
import 'package:gym_tracker/config/app_theme.dart';
import 'package:gym_tracker/domain/models/models.dart';

class ExerciseContainer extends StatelessWidget {
  const ExerciseContainer({super.key, required this.exercise});

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      //height: 50,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      decoration: BoxDecoration(
        color: exercise.category.getColor(),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Text('${exercise.name}, ${exercise.category.name}', style: AppTheme.h3Bold.copyWith(color: Colors.white),),
    );
  }
}