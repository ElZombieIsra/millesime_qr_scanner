import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:millesime_scanner/services/api.dart';

import '../globals.dart' as globals;
import 'package:millesime_scanner/style.dart' as Style;
import 'package:qrscan/qrscan.dart' as scanner;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String code;
  var data;
  @override
  Widget build(BuildContext context) {
    List<Widget> body = <Widget>[
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text("Comedor"),
          DropdownButton(
            hint: Text("Seleccione el comedor"),
            underline: Container(),
            onChanged: (_) => setState(() {
              globals.room = _;
              data = null;
            }),
            value: globals.room,
            items: globals.rooms
                .map((room) => DropdownMenuItem(
                      child: Text(room.room),
                      value: room,
                    ))
                .toList(),
          )
        ],
      ),
      Container(
        child: RaisedButton(
          onPressed: () async {
            try {
              code = await scanner.scan();
              data = await Api().scanCode(code);
              setState(() {
                print(data);
                data = data;
              });
            } catch (e) {
              print(e);
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text("Error"),
                  content: Text(e.message),
                ),
              );
            }
          },
          child: Text("Escanear"),
        ),
      ),
      Container(
        height: 10.0,
      ),
    ];
    if (data != null) {
      DateFormat format = DateFormat('h:mm a');
      DateTime scheduleDate = DateTime.parse("2019-11-29 ${data['schedule']}");
      DateTime scheduleDateEnd =
          DateTime.parse("2019-11-29 ${data['schedule_fin']}");
      body.addAll(<Widget>[
        ListTile(
          title: Text("Nombre: ${data['guest']['name'] ?? ""}"),
        ),
        ListTile(
          title: Text("Correo: ${data['guest']['email'] ?? ''}"),
        ),
        Divider(
          color: Style.primaryColor,
          thickness: 1.0,
        ),
        ListTile(
          title: Text('Comedor: ${data['room'] ?? ''}'),
        ),
        ListTile(
          title: Text("Mesa: ${data['table'] ?? ''}"),
        ),
        ListTile(
          title: Text(
              "Horario: ${format.format(scheduleDate)} - ${format.format(scheduleDateEnd)}"),
        ),
        data["check"] != null
            ? ListTile(
                title: Text(
                    "Entrada: ${format.format(DateTime.parse(data['check']['check_in']))}"),
                subtitle: data['check']['check_out'] != null
                    ? Text(
                        "Salida: ${format.format(DateTime.parse(data['check']['check_out']))}")
                    : null,
              )
            : Container(),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: _getIcon(data),
          ),
        ),
        Center(
          child: Text(_getInfoMessage(data)),
        )
      ]);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(globals.title),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        children: body,
      ),
    );
  }

  Icon _getIcon(data) {
    Icon valid = Icon(
      Icons.check_circle,
      color: Colors.green,
      size: 100.0,
    );
    Icon invalid = Icon(
      Icons.error,
      color: Colors.red,
      size: 100.0,
    );
    if (data['guest']['room'] != globals.room.id) {
      return invalid;
    }
    return valid;
  }

  String _getInfoMessage(data) {
    if (data['guest']['room'] != globals.room.id)
      return 'El invitado está registrado en otra sala';
    return 'Invitado registrado';
  }
}
