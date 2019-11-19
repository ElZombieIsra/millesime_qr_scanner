import 'package:json_annotation/json_annotation.dart';

part 'Room.g.dart';

@JsonSerializable()
class Room {
  int id;
  String room;
  int slots;
  @JsonKey(nullable: true)
  String menu;
  @JsonKey(nullable: true)
  String clave;
  @JsonKey(name: 'stand_id', nullable: true)
  int standId;

  Room({
    this.id,
    this.room,
    this.slots,
    this.menu,
    this.clave,
    this.standId,
  });

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
  Map<String, dynamic> toJson() => _$RoomToJson(this);
}
