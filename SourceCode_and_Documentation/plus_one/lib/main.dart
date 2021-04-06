import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plus_one/src/pages/loading_page.dart';
import 'package:provider/provider.dart';

import './src/providers/events.dart';
import './src/providers/paths.dart';
import './src/pages/homescreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: EventsList(),
        ),
        ChangeNotifierProvider.value(
          value: Paths(),
        ),
      ],
      child: MaterialApp(
        title: "PlusOne",
        theme: ThemeData(
          primarySwatch: Colors.grey,
          accentColor: Colors.orange,
        ),
        home: HomeScreen(),
      ),
    );
  }
}