import 'package:get/get.dart';
import 'package:gym_tracker/domain/models/models.dart';
import 'package:gym_tracker/data/repositories/trainings_repository.dart';

class TrainingController extends GetxController {

  Rx<Training?> selectedTraining = Rx<Training?>(null);
  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<ExerciseCategory?> selectedCategory = Rx<ExerciseCategory?>(null);

  RxList<Exercise> exercises = RxList<Exercise>.empty();
  RxList<Training> trainings = RxList<Training>.empty();

  Rx<double> weight = 0.0.obs;
  Rx<int> reps = 0.obs;

  Rx<bool> loading = false.obs;
  Rx<int> currentScreen = 0.obs;

  Future<void> loadTrainings() async{
    loading.value = true;
    trainings.clear();
    var list = await TrainingsRepository().getTrainingsByDate(selectedDay.value);
    trainings.addAll(list);
    loading.value = false;
  }

  nextDay(){
    selectedDay.value = selectedDay.value.add(const Duration(days: 1));
    loadTrainings();
  }

  previousDay(){
    selectedDay.value = selectedDay.value.subtract(const Duration(days: 1));
    loadTrainings();
  }

}