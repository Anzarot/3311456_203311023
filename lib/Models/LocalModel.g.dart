// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LocalModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalUserAdapter extends TypeAdapter<LocalUser> {
  @override
  final int typeId = 0;

  @override
  LocalUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalUser()
      ..Ad = fields[0] as String
      ..Yas = fields[1] as int
      ..Cinsiyet = fields[2] as String
      ..Emekli = fields[3] as bool;
  }

  @override
  void write(BinaryWriter writer, LocalUser obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.Ad)
      ..writeByte(1)
      ..write(obj.Yas)
      ..writeByte(2)
      ..write(obj.Cinsiyet)
      ..writeByte(3)
      ..write(obj.Emekli);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
