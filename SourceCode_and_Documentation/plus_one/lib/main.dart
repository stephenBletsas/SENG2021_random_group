import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// <<<<<<< homescreen
import 'package:provider/provider.dart';

import './src/providers/events.dart';
import './src/providers/paths.dart';

import './src/pages/authentication/loading_page.dart';
// =======
// import 'package:plus_one/src/pages/authentication/loading_page.dart';
// >>>>>>> main

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
// <<<<<<< homescreen
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
        home: LoadingPage(),
        debugShowCheckedModeBanner: false,
      ),
// =======
//     // apparently this only works on android ? https://tinyurl.com/dylpcq85
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     return MaterialApp(
//       home: LoadingPage(),
//       debugShowCheckedModeBanner: false,
// >>>>>>> main
    );
  }
}
