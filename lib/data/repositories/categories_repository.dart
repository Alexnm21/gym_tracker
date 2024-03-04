import 'package:gym_tracker/config/database.dart';
import 'package:gym_tracker/domain/models/models.dart';

class CategoriesRepository {

  Future<List<ExerciseCategory>> getCategories() async {
    if(categoryBox.isEmpty){
      return [];
    }

    return categoryBox.values.toList();
  }

  Future<void> addCategory(ExerciseCategory category) async {
    await categoryBox.add(category);
  }

  Future<void> deleteCategory(int index) async {
    await categoryBox.deleteAt(index);
  }

  Future<void> updateExerciseCategory(int index, String newName, int newColor) async {
  final exerciseCategory = categoryBox.getAt(index);

  if (exerciseCategory != null) {
    exerciseCategory.name = newName;
    exerciseCategory.color = newColor;
    await categoryBox.putAt(index, exerciseCategory);
  }
}
}