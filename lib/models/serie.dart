import 'package:hive/hive.dart';
part 'serie.g.dart'; // Generated Hive TypeAdapter

@HiveType(typeId: 4)
class Serie {
  @HiveField(0)
  double weight;
  @HiveField(1)
  int reps;

  Serie({
    required this.weight,
    required this.reps,
  });
}