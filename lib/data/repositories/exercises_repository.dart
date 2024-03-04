import 'package:gym_tracker/config/database.dart';
import 'package:gym_tracker/domain/models/models.dart';

class ExercisesRepository {

  Future<List<Exercise>> getExercises() async {
    if(exerciseBox.isEmpty){
      return [];
    }

    return exerciseBox.values.toList();
  }

  

  Future<void> addExercise(Exercise exercise) async {
    await exerciseBox.add(exercise);
  }

  Future<void> deleteExercise(int index) async {
    await exerciseBox.deleteAt(index);
  }

  Future<void> updateExercise(int index, String newName, ExerciseCategory category) async {
  final exerciseCategory = exerciseBox.getAt(index);

  if (exerciseCategory != null) {
    exerciseCategory.name = newName;
    exerciseCategory.category = category;
    await exerciseBox.putAt(index, exerciseCategory);
  }
}
}