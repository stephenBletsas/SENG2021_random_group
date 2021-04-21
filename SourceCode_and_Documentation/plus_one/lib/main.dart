import 'package:flutter/material.dart';
import 'package:plus_one/src/pages/create_path_screen_dt.dart';
import 'package:plus_one/src/providers/weather.dart';
import 'package:provider/provider.dart';

import './src/providers/events.dart';
import './src/providers/paths.dart';
import './src/pages/authentication/loading_page.dart';
import 'package:plus_one/src/singleton/client_store.dart';
import './src/pages/view_path_screen.dart';
import './src/pages/edit_path_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ClientStore();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: EventsList(),
        ),
        ChangeNotifierProvider.value(
          value: Paths(),
        ),
        ChangeNotifierProvider.value(value: Weather())
      ],
      child: MaterialApp(
        title: "PlusOne",
        home: LoadingPage(),
        routes: {
          ViewPathScreen.routeName: (ctx) => ViewPathScreen(),
          EditPathScreen.routeName: (ctx) => EditPathScreen(),
          CreatePath.routeName: (ctx) => CreatePath(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
