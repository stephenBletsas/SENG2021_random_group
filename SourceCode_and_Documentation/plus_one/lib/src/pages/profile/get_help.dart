import 'package:flutter/material.dart';
import 'package:plus_one/src/styling/color_palettes.dart';
import 'package:plus_one/src/styling/custom_text_styles.dart';

//  flutter_webview_plugin: ^0.3.11

class GetHelpPage extends StatefulWidget {
  @override
  _GetHelpPageState createState() => _GetHelpPageState();
}

class _GetHelpPageState extends State<GetHelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: seafoamGreen,
        appBar: AppBar(
          backgroundColor: sixtyPercOrange,
          title: Center(child: Text('PlusOne', style: buildLogoTextStyle(40))),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            Icon(
              Icons.call,
              color: Colors.transparent,
            ),
            Icon(
              Icons.call,
              color: Colors.transparent,
            )
          ],
        ),
        body: Center(
            child: Column(
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(0, 200, 0, 200),
                child: Text(
                  "Plus One",
                  style: buildLogoTextStyle(60),
                )),
            SizedBox(height: 0),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                  "Feel free to contact our team at jalal.faris@hotmail.com for any queries.",
                  textAlign: TextAlign.center,
                  style: buildRobotoTextStyle(16, Colors.black)),
            )
          ],
        )));
  }
}
