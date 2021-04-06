import 'package:plus_one/src/pages/authentication/login_page.dart';
import 'package:flutter/material.dart';

// TODO: figure out how to skip loading page when navigating backwards.

class LoadingPage extends StatefulWidget {
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Image.asset('assets/images/prototype_icons/PlusOneLogo.png'),
        ));
  }

  void init() async {
    // Wait 3 seconds
    await new Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
