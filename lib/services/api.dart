import 'dart:async';

import 'package:flutter/foundation.dart' as Foundation;
import 'package:millesime_scanner/models/Room.dart';
import 'package:millesime_scanner/globals.dart' as globals;

import 'network.dart';

class Api {
  NetworkService _netUtil = NetworkService();

  static const PC_LOCALHOST_URL = "http://10.0.2.2";
  static const LOCAL_URL = "http://192.168.100.30/millesime";
  // static const BASE_URL =
  // Foundation.kReleaseMode ? PC_LOCALHOST_URL : LOCAL_URL;
  static const BASE_URL = LOCAL_URL;

  Future<List<Room>> getRooms() async {
    String url = "$BASE_URL/getRooms";
    try {
      var res = await _netUtil.get(url);
      if (res.length == 0) {
        throw Exception("Ocurrio un error al contactar el servidor");
      }
      List<Room> rooms = res.map<Room>((room) => Room.fromJson(room)).toList();
      return rooms;
    } catch (e) {
      print(e);
      throw Exception("Ocurrió un error al obtener los comedores");
    }
  }

  Future<dynamic> scanCode(String code) async {
    code = code.substring(3);
    if (globals.room == null) {
      throw Exception('Seleccione el comedor');
    }
    String url = "$BASE_URL/comedorJson?code=$code&room=${globals.room.id}";
    try {
      var res = await _netUtil.get(url);
      if (res.length == 0) {
        throw Exception('Código incorrecto');
      } else if (res['errors'] != null) {
        List errors = res["errors"].values.toList();
        throw Exception(errors[0]);
      }
      return res;
    } catch (e) {
      throw Exception(e.message);
    }
  }
}
