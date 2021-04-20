import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plus_one/src/utils/auth_service.dart';
import 'package:plus_one/src/singleton/client_store_base.dart';
import 'package:firebase_core/firebase_core.dart';


class ClientStore extends ClientStoreBase {
  static final ClientStore _instance = ClientStore._internal();

  factory ClientStore() => _instance;

  ClientStore._internal() {
    Firebase.initializeApp();
  }



  // Since async functions cannot be awaited in the default constructor above,
  // we call this init separately before calling .
  Future init() async {
    // TODO: make sure this completes before we reference auth instance.
    await Firebase.initializeApp();
    
    var auth = AuthService().getAuthInstance();
    if (auth.currentUser != null) {
      ClientStore().setFirebaseId(auth.currentUser.uid);
      await AuthService.fetchUserFromFirestore(auth.currentUser.uid);
    }

  }
}
