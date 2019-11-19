import 'package:flutter/material.dart';

import 'screens/HomeScreen.dart';
import 'screens/LoadScreen.dart';

// Give a route and link it to your screen class
Map<String, WidgetBuilder> routes = {
  "/": (BuildContext context) => LoadScreen(),
  "/home": (BuildContext context) => HomeScreen(),
};
