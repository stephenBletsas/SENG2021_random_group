import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plus_one/src/singleton/client_store.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plus_one/src/utils/user_profile.dart' as userProfile;


class AuthService {
  final firebase.FirebaseAuth _auth = firebase.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  getAuthInstance() {
    return this._auth;
  }

  static fetchUserFromFirestore(String firebaseID) async {
    FirebaseFirestore _fireStoreDataBase = FirebaseFirestore.instance;

    ClientStore().setFirebaseId(firebaseID);

    await _fireStoreDataBase
        .collection('Users')
        .doc(firebaseID)
        .get()
        .then((document) {
      ClientStore().setUser(userProfile.User(
          name: document.data()['name'],
          dob: DateTime.parse(document.data()['dob']),
          gender: document.data()['gender'],
          avatarID: document.data()['avatarID'],
          profilePhotoURL: document.data()['profilePhotoURL'],
          miniProfilePhotoURL: document.data()['miniProfilePhotoURL'],
          onboarded: true));
    }).catchError((e) {
      ClientStore().setUser(userProfile.User(onboarded: false));
    });
  }

  Future<firebase.User> logInWithEmailAndPassword(
      String email, String password) async {
    firebase.UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    firebase.User user = result.user;
    ClientStore().setFirebaseId(user.uid);
    await fetchUserFromFirestore(user.uid);

    return user;
  }

  Future<String> verifyEmail() async {
    final firebase.User user = _auth.currentUser;
    try {
      await user.sendEmailVerification();
      user.reload();

      return user.uid;
    } catch (e) {
      print("An error occured while trying to send email verification");
      print(e.message);
    }
  }

  bool isEmailVerified() {
    firebase.User user = _auth.currentUser;
    user.reload();
    if (user.emailVerified) {
      return true;
    }
    return false;
  }

  Future<firebase.User> signUpWithEmailAndPassword(
      String email, String password) async {
    firebase.UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    print("user?" + result.user.toString());

    firebase.User user = result.user;

    ClientStore().setFirebaseId(user.uid);
    return user;
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<firebase.User> fetchUserGoogle() async {
    // TODO: fix the issue related to SHA fingerprint and support email
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final firebase.AuthCredential credential =
        firebase.GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final firebase.UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final firebase.User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final firebase.User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signUpWithGoogle succeeded: $user');

      return user;
    }

    return null;
  }

  Future<firebase.User> signInWithGoogle() async {
    firebase.User user = await fetchUserGoogle();
    await fetchUserFromFirestore(user.uid);
    return user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
