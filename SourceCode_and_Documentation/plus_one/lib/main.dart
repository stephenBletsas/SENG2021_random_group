import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plus_one/src/pages/authentication/loading_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // apparently this only works on android ? https://tinyurl.com/dylpcq85
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      home: LoadingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
