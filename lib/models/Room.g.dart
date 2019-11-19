// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) {
  return Room(
    id: json['id'] as int,
    room: json['room'] as String,
    slots: json['slots'] as int,
    menu: json['menu'] as String,
    clave: json['clave'] as String,
    standId: json['stand_id'] as int,
  );
}

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'id': instance.id,
      'room': instance.room,
      'slots': instance.slots,
      'menu': instance.menu,
      'clave': instance.clave,
      'stand_id': instance.standId,
    };
