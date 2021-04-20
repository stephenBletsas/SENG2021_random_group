import 'package:plus_one/src/styling/custom_text_styles.dart';
import 'package:plus_one/src/pages/chats/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:plus_one/src/styling/color_palettes.dart';

List<ChatData> listContact = [ ChatData(name : 'Hermione Granger', imagePath : "assets/images/prototype_icons/profile-colour.jpg" ,lastMessage:"Hi John there is..."),
 ChatData(name : 'Harry Potter', imagePath : "assets/images/prototype_icons/profile-colour.jpg" ,lastMessage:"Yo we should check..."),
 ChatData(name : 'Ron Weasly', imagePath : "assets/images/prototype_icons/profile-colour.jpg" ,lastMessage:"Haha yeah!")];

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
          backgroundColor: Colors.transparent,
          body: getContacts()
        );
  }

  Widget getContacts() {
    return ListView.builder(
                itemBuilder: (context, index) =>
                    buildChatTile(context, listContact[index]),
                itemCount: 1);
          }

  Widget buildChatTile(BuildContext context, ChatData document) {
    return Slidable(
      actionExtentRatio: 0.15,
      delegate: SlidableDrawerDelegate(),
      child: ListTile(
        leading: GestureDetector(
          onTap: null,
          child:Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/prototype_icons/profile-colour.jpg"),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(100)),
                      ),
        ),
        title: Text(document.name,
            overflow: TextOverflow.ellipsis,
            style: buildRobotoTextStyle(16, Colors.black)),
        subtitle: Row(
          children: [
            Expanded(
              child: Text(document.lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: buildRobotoTextStyle(14, Colors.black),
            )),
          ],
        ),
        onTap: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => ChatPage(
          //           name: document.name,
          //           imagePath:
          //               document.imagePath,
          //     ));
        },
        onLongPress: () {}, //Can add more feature into this if needed
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          icon: Icons.report,
          color: Colors.red,
          caption: "Report",
          onTap: () => {},
        )
      ],
    );
  }

}


class ChatData {
  String name;
  String imagePath;
  String lastMessage;

  ChatData(
      {this.name,
      this.imagePath,
      this.lastMessage});
}