import 'package:flutter/material.dart';
import 'package:plus_one/src/styling/color_palettes.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:plus_one/src/styling/custom_text_styles.dart';

//  flutter_webview_plugin: ^0.3.11

void main() => runApp(MaterialApp(
    home: TOSPage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.blue)));

class TOSPage extends StatefulWidget {
  @override
  _TOSPageState createState() => _TOSPageState();
}

class _TOSPageState extends State {
  TextEditingController controller = TextEditingController();
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  var url = "https://www.websitepolicies.com/policies/view/B3opZJqH";

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: url,
      withZoom: true,
      hidden: true,
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
    );
  }
}
