// import 'package:cached_network_image/cached_network_image.dart';
import 'package:plus_one/src/singleton/client_store.dart';
import 'package:plus_one/src/pages/chats/chat_page.dart';
import 'package:plus_one/src/utils/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:plus_one/src/styling/custom_text_styles.dart';

List<QueryDocumentSnapshot> listContact = new List.from([]);
String firebaseID = ClientStore().getFirebaseId();

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getContacts(),
    );
  }

  Widget getContacts() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(firebaseID)
            .collection('Contacts')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.pink[400])));
          } else {
            listContact.addAll(snapshot.data.docs);
            return ListView.builder(
                itemBuilder: (context, index) =>
                    buildChatTile(context, snapshot.data.docs[index]),
                itemCount: snapshot.data.docs.length);
          }
        });
  }

  Widget buildChatTile(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      leading: CircleAvatar(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(220.0),
          child: Text("Hello"),
          // child: CachedNetworkImage(
          //   placeholder: (context, url) => CircularProgressIndicator(),
          //   imageUrl:
          //       "https://www.pngkey.com/png/full/73-730477_first-name-profile-image-placeholder-png.png",
          //   fit: BoxFit.cover,
          // ),
        ),
      ),
      title: Text(document.data()['name'],
          overflow: TextOverflow.ellipsis,
          style: document.data()['unreadCount'] == 0
              ? buildRobotoTextStyle(16, Colors.black)
              : buildBoldRobotoText(16, Colors.black)),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(document.data()['lastMessage'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: document.data()['unreadCount'] == 0
                    ? buildRobotoTextStyle(14, Colors.black)
                    : buildBoldRobotoText(14, Colors.black)),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
                DateFormat('dd/MM hh:mm')
                    .format(document.data()['timestamp'].toDate()),
                textAlign: TextAlign.right,
                style: document.data()['unreadCount'] == 0
                    ? buildRobotoTextStyle(16, Colors.black)
                    : buildBoldRobotoText(16, Colors.black)),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                  peerFirebaseId: document.id,
                  peerName: document.data()['name'],
                  peerMiniProfilePhotoURL:
                      document.data()['miniProfilePhotoURL']),
            ));
      },
      onLongPress: () {}, //Can add more feature into this if needed
    );
  }
}
