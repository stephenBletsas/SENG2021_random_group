import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:plus_one/src/utils/timestamp_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_messages.g.dart';

// the following are only for firestore collections
const USERS = 'Users';
const CONTACTS = 'Contacts';
const CHATROOMS = 'ChatRooms';
const MESSAGE_HISTORY = 'MessageHistory';

enum MessageType { text, postCard }

class Message {
  @TimestampConverter()
  DateTime timestamp;
  int type;
  String idFrom;
  String content;

  Message(
      {@required this.type, @required this.idFrom, @required this.content}) {
    timestamp = DateTime.now();
  }
}

@JsonSerializable()
class TextMessage extends Message {
  TextMessage({@required String idFrom, @required String content})
      : super(type: MessageType.text.index, idFrom: idFrom, content: content);

  Map<String, dynamic> toJson() => _$TextMessageToJson(this);
}

@JsonSerializable()
class PostCardMessage extends Message {
  String question;
  String hiddenAnswer;
  String reply;

  PostCardMessage(
      {@required String idFrom,
      @required this.question,
      @required this.hiddenAnswer,
      @required this.reply})
      : super(
            type: MessageType.postCard.index,
            idFrom: idFrom,
            content: hiddenAnswer);

  Map<String, dynamic> toJson() => _$PostCardMessageToJson(this);
}

void sendMessage(Message message, String peerFirebaseId) {
  // Creating currTime var to keep timestamps consistent
  Timestamp currTime = Timestamp.fromDate(message.timestamp);

  String firebaseId = message.idFrom;

  DocumentReference chatRoomDocReference = FirebaseFirestore.instance
      .collection(CHATROOMS)
      .doc(getChatId(firebaseId, peerFirebaseId))
      .collection(MESSAGE_HISTORY)
      .doc("chat-" +
          currTime.millisecondsSinceEpoch.toString() +
          '-' +
          firebaseId);

  FirebaseFirestore.instance.runTransaction((transaction) async {
    switch (MessageType.values[message.type]) {
      case MessageType.text:
        TextMessage textMessage = message as TextMessage;
        await _setLastMessage(transaction, textMessage.content, currTime,
            firebaseId, peerFirebaseId);
        transaction.set(
          chatRoomDocReference,
          textMessage.toJson(),
        );
        break;

      case MessageType.postCard:
        PostCardMessage postCardMessage = message as PostCardMessage;
        await _setLastMessage(transaction, postCardMessage.question, currTime,
            firebaseId, peerFirebaseId);
        transaction.set(
          chatRoomDocReference,
          postCardMessage.toJson(),
        );
        break;
      default:
    }
  });
}

// Function responsible for setting last message in sender's and peer's
// Contact document (Also creates contact if it doesn't exist)
Future<void> _setLastMessage(Transaction transaction, String content,
    Timestamp currTime, String firebaseId, String peerFirebaseId) async {
  // Reference to record(Document) of peer in sender's CONTACTS collection
  DocumentReference senderContactDocReference = FirebaseFirestore.instance
      .collection(USERS)
      .doc(firebaseId)
      .collection(CONTACTS)
      .doc(peerFirebaseId);

  // Reference to record(Document) of sender in peer's CONTACTS collection
  DocumentReference peerContactDocReference = FirebaseFirestore.instance
      .collection(USERS)
      .doc(peerFirebaseId)
      .collection(CONTACTS)
      .doc(firebaseId);

  // Check if sender and peer are each other's contacts
  bool contactExists =
      await senderContactDocReference.get().then((value) => value.exists) &&
          await peerContactDocReference.get().then((value) => value.exists);

  // If sender and peer are not each other's contacts, get their data
  // from the USERS collection and create their respective contacts with
  // minimal contact details
  if (!contactExists) {
    DocumentSnapshot senderUserDoc = await FirebaseFirestore.instance
        .collection(USERS)
        .doc(firebaseId)
        .get();

    DocumentSnapshot peerUserDoc = await FirebaseFirestore.instance
        .collection(USERS)
        .doc(peerFirebaseId)
        .get();

    transaction.set(
        senderContactDocReference,
        {
          "name": peerUserDoc.get("name"),
          "avatarID": peerUserDoc.get("avatarID"),
          "miniProfilePhotoURL": peerUserDoc.get("miniProfilePhotoURL"),
          "isFriend": false
        },
        SetOptions(merge: true));

    transaction.set(
        peerContactDocReference,
        {
          "name": senderUserDoc.get("name"),
          "avatarID": senderUserDoc.get("avatarID"),
          "isFriend": false
        },
        SetOptions(merge: true));
  }

  // Update lastMessage and its timestamp in each other's contact
  // details
  transaction.set(
      senderContactDocReference,
      {
        "lastMessage": content,
        "timestamp": currTime,
      },
      SetOptions(merge: true));
  // Sending a message to peer results in 1 more unread message
  // from the sender on the peer's end
  transaction.set(
      peerContactDocReference,
      {
        "lastMessage": content,
        "timestamp": currTime,
        "unreadCount": FieldValue.increment(1),
      },
      SetOptions(merge: true));
}

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
