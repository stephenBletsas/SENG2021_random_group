import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plus_one/src/pages/profile/personal_details_page.dart';
import 'package:plus_one/src/singleton/client_store.dart';
import 'package:plus_one/src/styling/custom_text_styles.dart';
import 'package:plus_one/src/styling/color_palettes.dart';
import 'package:plus_one/src/pages/authentication/login_page.dart';
import 'package:plus_one/src/pages/profile/tos_page.dart';
import 'package:plus_one/src/pages/profile/how_it_works.dart';
import 'package:plus_one/src/pages/profile/get_help.dart';
import 'package:plus_one/src/pages/profile/notif_options_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plus_one/src/utils/auth_service.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  final textStyleState = GoogleFonts.raleway(
      textStyle: TextStyle(
    fontSize: 11.0,
    color: Colors.white,
  ));

  final textStyleTop = GoogleFonts.raleway(
      fontWeight: FontWeight.bold,
      textStyle: TextStyle(
        fontSize: 22.0,
        color: Colors.white,
      ));

  final textStyle2 = GoogleFonts.raleway(
      textStyle: TextStyle(
    color: Colors.white,
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 90.0,
                    height: 90.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/prototype_icons/profile-colour.jpg"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildName(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "5 Future Events | 14 Past Events",
                        style: TextStyle(fontSize: 11, color: unselectedGray),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          ClipRRect(
            child: Container(
              margin: const EdgeInsets.only(bottom: 5.0),
              decoration: BoxDecoration(
                color: Colors.black12,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 5.0,
                  ),
                ],
              ),
              width: 50,
              height: 1,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
            child: Text(
              "Account Settings",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
          FlatButton(
            splashColor: Colors.grey,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PersonalDetailsPage()),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Personal Information",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.person_outline,
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
            splashColor: Colors.grey,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotifOptionsPage()),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Notifications",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.notifications_none,
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
          Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 5),
            child: Text(
              "Support",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
          FlatButton(
            splashColor: Colors.grey,
            onPressed: () {
              // TODO
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "About PlusOne",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.public,
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
            splashColor: Colors.grey,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GetHelpPage()),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Get Help",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.help_outline_rounded,
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
          Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 5),
            child: Text(
              "Legal",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
          FlatButton(
            splashColor: Colors.grey,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TOSPage()),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Terms of Service",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(Icons.history_edu_rounded),
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
            splashColor: Colors.grey,
            onPressed: () {
              AuthService().signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (Route<dynamic> route) => false,
              );
            },
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.exit_to_app,
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

  Widget _buildName() {
    print(ClientStore().getFirebaseId());
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(ClientStore().getFirebaseId())
            .snapshots(),
        builder: (builder, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white)));
          } else {
            String name = snapshot.data['name'];
            print(name);
            return Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: unselectedGray),
                      );
          }
        });
  }

  




}
