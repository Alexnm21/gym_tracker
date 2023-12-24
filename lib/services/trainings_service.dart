import 'package:gym_tracker/config/database.dart';
import 'package:gym_tracker/config/utils.dart';
import 'package:gym_tracker/models/models.dart';
import 'package:gym_tracker/models/training.dart';

class TrainingsService {

  Future<List<Training>> getTrainings() async {
    if(trainingBox.isEmpty){
      return [];
    }

    return trainingBox.values.toList();
  }

  Future<List<Training>> getTrainingsByDate(DateTime date) async {
    if(trainingBox.isEmpty){
      return [];
    }

    return trainingBox.values.where((training) => isSameDay(date, training.date)).toList();
  }

  Future<List<Training>> getTrainingsByExercise(Exercise exercise) async {
    if(trainingBox.isEmpty){
      return [];
    }

    return trainingBox.values.where((training) => training.exercise.name == exercise.name).toList();
  }

  Future<void> addTraining(Training training) async {
    await trainingBox.add(training);
  }

  Future<void> addOrUpdateTraining(Training training) async {
    List<Training> trainings = await getTrainingsByDate(training.date);

    for(int index = 0; index < trainings.length; index++) {
      if(trainings[index].exercise.name == training.exercise.name){
        await deleteTraining(index);
      }
    }
    
    await trainingBox.add(training);
 
  }

  Future<void> deleteTraining(int index) async {
    await trainingBox.deleteAt(index);
  }

}