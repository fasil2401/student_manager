// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DBModelAdapter extends TypeAdapter<DBModel> {
  @override
  final int typeId = 1;

  @override
  DBModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DBModel(
      id: fields[0] as int?,
      path: fields[1] as dynamic,
      name: fields[2] as String,
      age: fields[3] as String,
      std: fields[4] as String,
      place: fields[5] as String,
      isDeleted: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, DBModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.std)
      ..writeByte(5)
      ..write(obj.place)
      ..writeByte(6)
      ..write(obj.isDeleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DBModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
