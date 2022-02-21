import 'package:hive_flutter/adapters.dart';
part 'dbmodel.g.dart';


@HiveType(typeId: 1)
class DBModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final dynamic path;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String age;
  @HiveField(4)
  // final String type;
  // @HiveField(5)
  final String std;
  @HiveField(5)
  final String place;
  @HiveField(6)
  final bool isDeleted;

  DBModel(
      {this.id,
      required this.path,
      required this.name,
      required this.age,
      // required this.type,
      required this.std,
      required this.place,
      this.isDeleted = false});
}
