import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:plus_one/src/utils/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ClientStoreBase {
  @protected
  User user;
  @protected
  String firebaseId;

  getUser() => user;


  setUser(User user) {
    this.user = user;
    setFirestoreUser();
  }
 
  void setFirestoreUser() async {
    // print(user.toJson());
    // await FirebaseFirestore.instance
    //     .collection("Users")
    //     .doc(getFirebaseId())
    //     .set(user.toJson(), SetOptions(merge: true));
  }

  void setFirebaseId(String firebaseId) {
    this.firebaseId = firebaseId;
  }

  String getFirebaseId() {
    return this.firebaseId;
  }

  bool firebaseIdExists() {
    return !(firebaseId == null);
  }
}
