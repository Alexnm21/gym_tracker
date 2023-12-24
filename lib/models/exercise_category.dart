import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'exercise_category.g.dart';

@HiveType(typeId: 1)
class ExerciseCategory {
  @HiveField(0)
  String name;
  @HiveField(1)
  int color;

  // Constructor
  ExerciseCategory({
    required this.name,
    required this.color,
  });

  Color getColor(){
    return Color(color);
  }
}
