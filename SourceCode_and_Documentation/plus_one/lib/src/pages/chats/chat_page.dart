import 'dart:async';
import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plus_one/src/styling/color_palettes.dart';
import 'package:plus_one/src/styling/custom_text_styles.dart';
import 'package:plus_one/src/singleton/client_store.dart';
import 'package:plus_one/src/utils/chat_messages.dart';
import 'package:flutter/material.dart';

// the following are only for firestore collections
const USERS = 'Users';
const CONTACTS = 'Contacts';
const CHATROOMS = 'ChatRooms';
const MESSAGE_HISTORY = 'MessageHistory';

enum MessageType { text, postCard }

final themeColor = seafoamGreen;
final primaryColor = Color(0xff203152);
final greyColor = Color(0xffaeaeae);
final greyColor2 = Color(0xffE8E8E8);
const defaultAvatarBackground = Color(0xffc9e4de);

class ChatPage extends StatefulWidget {
  ChatPage(
      {@required this.peerFirebaseId,
      @required this.peerName,
      @required this.peerMiniProfilePhotoURL});

  final String peerFirebaseId;
  final String peerName;
  final String peerMiniProfilePhotoURL;

  @override
  State createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  // Firebase ID of sending user
  String firebaseId;

  // Info of peer(i.e. User on other end of chats)
  String peerFirebaseId;
  int peerAvatarId;
  String peerMiniProfilePhotoURL;
  bool isFriend;

  // Chat messages and Pagination related
  String chatId;
  final ScrollController listScrollController = ScrollController();
  int _limit = 20;
  final int _limitIncrement = 20;

  // TextEditingController to handle send message TextField
  final TextEditingController textEditingController = TextEditingController();

  // FocusNode to figure out if keyboard is open or not
  final FocusNode focusNode = FocusNode();

  _scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        print("reach the bottom");
        _limit += _limitIncrement;
      });
    }
    if (listScrollController.offset <=
            listScrollController.position.minScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        print("reach the top");
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Set listeners to handle pagination
    listScrollController.addListener(_scrollListener);

    // Get required IDs
    firebaseId = ClientStore().getFirebaseId();
    peerFirebaseId = widget.peerFirebaseId;
    peerMiniProfilePhotoURL = widget.peerMiniProfilePhotoURL;
    chatId = getChatId(firebaseId, peerFirebaseId);
  }

  void onPressedSend(String content, MessageType type) {
    // type: 0 = text - Refer flip_flop_consts
    if (content.trim() != '') {
      textEditingController.clear();

      switch (type) {
        case MessageType.text:
          TextMessage message =
              TextMessage(idFrom: firebaseId, content: content);
          sendMessage(message, peerFirebaseId);
          break;
        default:
      }

      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  // Function that handles the rendering of each individual message
  Widget buildItem(DocumentSnapshot document) {
    if (document.data()['idFrom'] == firebaseId) {
      // User messages are right aligned
      switch (MessageType.values[document.data()['type']]) {
        case MessageType.text:
          return buildTextMessage(document.data()['content'], primaryColor,
              greyColor2, MainAxisAlignment.end);
          break;

        case MessageType.postCard:
          return Row();
          break;
      }
    } else if (document.data()['idFrom'] == peerFirebaseId) {
      // Peer messages are left aligned
      switch (MessageType.values[document.data()['type']]) {
        case MessageType.text:
          return buildTextMessage(document.data()['content'], Colors.black,
              seafoamGreen, MainAxisAlignment.start);
          break;

        case MessageType.postCard:
          return Row();
          break;
      }
    } else if (document.data()['idFrom'] == "flipflopserver") {
      // Server messages are center aligned
      return buildServerMessage(document.data()['content']);
    }
    return Container();
  }

  Future<bool> onBackPress() {
    DocumentReference senderContactDocReference = FirebaseFirestore.instance
        .collection(USERS)
        .doc(firebaseId)
        .collection(CONTACTS)
        .doc(peerFirebaseId);

    senderContactDocReference.set({"unreadCount": 0}, SetOptions(merge: true));
    Navigator.pop(context);
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: sixtyPercOrange,
            title: Row(children: [
              CircleAvatar(
                child: Text("H"),
                // child: ClipRRect(
                //   borderRadius: BorderRadius.circular(220.0),
                //   child: CachedNetworkImage(
                //     placeholder: (context, url) => CircularProgressIndicator(),
                //     imageUrl:
                //         "https://www.pngkey.com/png/full/73-730477_first-name-profile-image-placeholder-png.png",
                //     fit: BoxFit.cover,
                //   ),
              ),
              Text("    "),
              Text(
                widget.peerName,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              )
            ])),
        body: Container(
            child: WillPopScope(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      buildMessageList(),
                      buildInput(),
                    ],
                  ),
                ],
              ),
              onWillPop: onBackPress,
            ),
            // Chat background color
            color: Colors.transparent));
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Edit text
          Flexible(
            child: Container(
              padding: EdgeInsets.only(left: 16.0),
              child: TextField(
                onSubmitted: (value) {
                  onPressedSend(textEditingController.text, MessageType.text);
                },
                style: buildRobotoTextStyle(15.0, Colors.black),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                    hintText: 'Type your message...',
                    hintStyle: buildRobotoTextStyle(15.0, greyColor)),
                focusNode: focusNode,
              ),
            ),
          ),

          // Send message icon button - wrapped in material
          // because IconButton requires some sort of Material ancestor for
          // Splash on pressed to occur
          Material(
            child: IconButton(
              icon: Icon(Icons.send),
              onPressed: () =>
                  onPressedSend(textEditingController.text, MessageType.text),
              color: seafoamGreen,
              splashRadius: 20.0,
            ),
            color: Colors.white,
          ),
        ],
      ),
      height: 50.0,
      decoration: BoxDecoration(color: Colors.white),
    );
  }

  Widget buildMessageList() {
    return Flexible(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(CHATROOMS)
            .doc(chatId)
            .collection(MESSAGE_HISTORY)
            .orderBy('timestamp', descending: true)
            .limit(_limit)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(seafoamGreen)));
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) =>
                  buildItem(snapshot.data.docs[index]),
              itemCount: snapshot.data.docs.length,
              reverse: true,
              controller: listScrollController,
            );
          }
        },
      ),
    );
  }

  Widget buildTextMessage(String text, Color textColor, Color fillColor,
      MainAxisAlignment mainAxisAlignment) {
    return Row(
      children: [
        Container(
          child: Text(
            text,
            style: buildRobotoTextStyle(15.0, textColor),
          ),
          padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          constraints: BoxConstraints(maxWidth: 200.0),
          decoration: BoxDecoration(
              color: fillColor, borderRadius: BorderRadius.circular(15.0)),
          margin: EdgeInsets.only(bottom: 6.0, right: 10.0, left: 10.0),
        )
      ],
      mainAxisAlignment: mainAxisAlignment,
    );
  }
}

buildServerMessage(String content) {
  return Row();
}

// Handle tapping other user's avatar
void navToPeerProfile(BuildContext context, String peerFirebaseId) {}

// Function that determines the chatID of a ChatRoom between 2 users
// based on their firebaseIDs
String getChatId(String firebaseId, String peerFirebaseId) {
  // x.compareTo(y) returns a negative int if x < y
  if (firebaseId.compareTo(peerFirebaseId) < 0) {
    return '$firebaseId-$peerFirebaseId';
  } else {
    return '$peerFirebaseId-$firebaseId';
  }
}
