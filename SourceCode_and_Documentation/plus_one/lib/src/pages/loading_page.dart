import 'package:plus_one/src/pages/personal_details_page.dart';
import 'package:plus_one/src/pages/styling/color_palettes.dart';
import 'package:flutter/material.dart';
import 'package:plus_one/src/pages/styling/custom_text_styles.dart';

// TODO: figure out how to skip loading page when navigating backwards.

class LoadingPage extends StatefulWidget {
  LoadingPageState createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: persianGreen,
        body: Center(
          child: Text('PlusOne', style: buildLogoTextStyle(50)),
        ));
  }

  void init() async {
    // Wait 3 seconds
    await new Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => PersonalDetailsPage()));
  }
}
