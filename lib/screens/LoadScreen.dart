import 'package:flutter/material.dart';
import 'package:millesime_scanner/services/api.dart';
import 'package:millesime_scanner/globals.dart' as globals;

import '../style.dart' as Style;

class LoadScreen extends StatefulWidget {
  @override
  _LoadScreenState createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  @override
  void initState() {
    super.initState();
    getRooms();
  }

  void getRooms() async {
    try {
      globals.rooms = await Api().getRooms();
      Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext ctx) => AlertDialog(
                content: Text(
                    "Ocurrió un error al tratar de conectarse con el servidor"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          padding: EdgeInsets.all(50.0),
          color: Style.primaryColor,
          child: Center(
            child: Image.asset('assets/img/logo.png'),
          ),
        ),
      ),
    );
  }
}
