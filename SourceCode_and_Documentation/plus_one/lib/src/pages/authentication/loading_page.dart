import 'package:plus_one/src/pages/authentication/login_page.dart';
import 'package:plus_one/src/pages/authentication/verify_email_page.dart';
import 'package:plus_one/src/pages/home_nav_bar.dart';
import 'package:plus_one/src/utils/auth_service.dart';
import 'package:plus_one/src/singleton/client_store.dart';
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
    var auth = AuthService().getAuthInstance();

    // TODO: consider using auth.authStateChanges().listen((user) to check if
    // user is logged out mid-session.
    if (auth.currentUser != null) {
      ClientStore().setFirebaseId(auth.currentUser.uid);
      if (!auth.currentUser.emailVerified) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => VerifyEmailPage()));
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeNavBarPage()),
          (Route<dynamic> route) => false,
        );
      }
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }
}
