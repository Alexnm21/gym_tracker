import 'package:hive/hive.dart';

part 'person.g.dart'; // Generated Hive TypeAdapter

@HiveType(typeId: 0)
class Person extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late int age;
}