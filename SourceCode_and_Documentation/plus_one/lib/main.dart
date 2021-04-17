import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './src/providers/events.dart';
import './src/providers/paths.dart';
import './src/pages/authentication/loading_page.dart';
import './src/pages/view_path_screen.dart';
import './src/pages/edit_path_screen.dart';

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
        home: LoadingPage(),
        routes: {
          ViewPathScreen.routeName: (ctx) => ViewPathScreen(),
          EditPathScreen.routeName: (ctx) => EditPathScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
