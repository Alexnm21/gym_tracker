import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_tracker/domain/models/models.dart';
import 'package:gym_tracker/data/repositories/exercises_repository.dart';

class CategoryController extends GetxController {
  List<ExerciseCategory> categories = [];
  List<Exercise> exercises = [];

  List<Exercise> getExercisesByCategory(ExerciseCategory? category){
    if(category == null) return exercises;

    List<Exercise> newList = exercises.where((element) => element.category.name == category.name).toList();

    return newList;
  }

  void showAddExerciseDialog({Exercise? exercise, int index=0, required BuildContext context}) {
    String name = exercise != null ? exercise.name : '';
    ExerciseCategory selectedCategory = exercise != null ? exercise.category : categories[0];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text( exercise == null ? 'Nuevo Ejercicio' : exercise.name),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: name,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  onChanged:(value) {
                    name = value;
                  },
                ),
                DropdownButtonFormField(
                  value: categories[0],
                  items: categories.map((category) {
                    return DropdownMenuItem<ExerciseCategory>(
                      value: category,    
                      child: Text(category.name),
                    );
                  }).toList(), 
                  onChanged:(value) {
                      if(value != null) {
                        selectedCategory = value;
                      }
                  },)
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                
                if(exercise!= null){ // ACTUALIZAR EJERCICIO
                  ExercisesRepository().updateExercise(index, name, selectedCategory);
                    exercises[index].name = name;
                } else { // AÑADIR UNO NUEVO
                  Exercise newExercise = Exercise(name: name, category: selectedCategory);
                  ExercisesRepository().addExercise(newExercise);
                    exercises.add(newExercise);
                }
                
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}