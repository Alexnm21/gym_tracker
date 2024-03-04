import 'package:gym_tracker/domain/models/exercise.dart';
import 'package:gym_tracker/domain/models/serie.dart';


import 'package:hive/hive.dart';

part 'training.g.dart';

@HiveType(typeId: 3)
class Training {
  @HiveField(0)
  Exercise exercise;
  @HiveField(1)
  List<Serie> series;
  @HiveField(2)
  DateTime date;


  // Constructor
  Training({
    required this.exercise,
    required this.series,
    DateTime? date,
  }) : date = date ?? DateTime.now();
}

