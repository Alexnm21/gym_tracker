import 'package:gym_tracker/models/models.dart';
import 'package:hive/hive.dart';

part 'exercise.g.dart';

@HiveType(typeId: 2)
class Exercise {
  @HiveField(0)
  String name;
  @HiveField(1)
  ExerciseCategory category;

  // Constructor
  Exercise({
    required this.name,
    required this.category,
  });
}
