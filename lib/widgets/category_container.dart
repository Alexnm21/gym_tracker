import 'package:flutter/material.dart';
import 'package:gym_tracker/config/app_theme.dart';
import 'package:gym_tracker/models/models.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer({super.key, required this.category});

  final ExerciseCategory category;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal:30),
      decoration: BoxDecoration(
        color: category.getColor(),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Text(category.name, style: AppTheme.h3Bold.copyWith(color: Colors.white),),
    );
  }
}