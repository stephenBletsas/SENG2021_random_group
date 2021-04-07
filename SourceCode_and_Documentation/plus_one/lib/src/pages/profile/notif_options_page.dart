import 'package:flutter/material.dart';
import 'package:plus_one/src/styling/custom_text_styles.dart';
import 'package:plus_one/src/styling/color_palettes.dart';
import 'package:plus_one/src/pages/authentication/login_page.dart';
import 'package:plus_one/src/pages/profile/tos_page.dart';

class NotifOptionsPage extends StatefulWidget {
  @override
  _NotifOptionsState createState() => _NotifOptionsState();
}

class _NotifOptionsState extends State<NotifOptionsPage> {
  final textStyleState = TextStyle(fontSize: 11.0, color: Colors.white);

  final textStyleTop = TextStyle(
      fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white);

  final textStyle2 = TextStyle(color: Colors.white);

  bool isPushOn = true;
  bool isTextOn = true;
  bool isEmailRemOn = true;
  bool isPromoEmailOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: sixtyPercOrange,
        title: Center(
            child: Text(
          'PlusOne',
          style: TextStyle(
              color: unselectedGray, fontWeight: FontWeight.bold, fontSize: 25),
        )),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: unselectedGray,
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
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
            child: Text(
              "Notification Preferences",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
          FlatButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              // TODO
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => InfoPersonnel()),
              // );
            },
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Push Notifications",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Switch(
                    value: isPushOn,
                    onChanged: (value) {
                      setState(() {
                        isPushOn = value;
                      });
                    },
                    activeTrackColor: lightGray,
                    activeColor: persianGreen,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.black12,
            ),
            width: 50,
            height: 1,
          ),
          FlatButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              // TODO
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => InfoPersonnel()),
              // );
            },
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Text Messages",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Switch(
                    value: isTextOn,
                    onChanged: (value) {
                      setState(() {
                        isTextOn = value;
                      });
                    },
                    activeTrackColor: lightGray,
                    activeColor: persianGreen,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.black12,
            ),
            width: 50,
            height: 1,
          ),
          FlatButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {},
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Email Reminders",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Switch(
                    value: isEmailRemOn,
                    onChanged: (value) {
                      setState(() {
                        isEmailRemOn = value;
                      });
                    },
                    activeTrackColor: lightGray,
                    activeColor: persianGreen,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.black12,
            ),
            width: 50,
            height: 1,
          ),
          FlatButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              // TODO
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => AddProperty()),
              // );
            },
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Promotional Email",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Switch(
                    value: isPromoEmailOn,
                    onChanged: (value) {
                      setState(() {
                        isPromoEmailOn = value;
                      });
                    },
                    activeTrackColor: lightGray,
                    activeColor: persianGreen,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.black12,
            ),
            width: 50,
            height: 1,
          ),
        ],
      ),
    );
  }
}
