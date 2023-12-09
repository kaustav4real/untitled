// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserLocalInfoAdapter extends TypeAdapter<UserLocalInfo> {
  @override
  final int typeId = 1;

  @override
  UserLocalInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserLocalInfo(
      userEmail: fields[0] as String,
      session: fields[2] as String,
      userName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserLocalInfo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userEmail)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.session);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLocalInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
