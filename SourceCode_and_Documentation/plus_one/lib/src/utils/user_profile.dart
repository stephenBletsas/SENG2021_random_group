import 'package:plus_one/src/singleton/client_store.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';
// TO GENERATE ACCOMPANYING FILE, RUN:
// flutter pub run build_runner build

@JsonSerializable(includeIfNull: false)
class User {
  User(
      {this.name,
      this.gender,
      this.dob,
      this.avatarID,
      this.profilePhotoURL,
      this.miniProfilePhotoURL,
      this.onboarded});

  String name;
  DateTime dob;
  int gender;
  int avatarID;
  String profilePhotoURL;
  String miniProfilePhotoURL;
  bool onboarded;

  getName() => this.name;
  getGender() => this.gender;
  getDob() => this.dob;
  getAvatarID() => this.avatarID;
  getProfilePhotoURL() => this.profilePhotoURL;
  getMiniProfilePhotoURL() => this.miniProfilePhotoURL;
  getOnboarded() => this.onboarded;

  setOnboarded(bool onboarded) {
    this.onboarded = onboarded;
  }

  setName(String name) {
    this.name = name;
    ClientStore().setFirestoreUser();
  }

  setGender(int gender) {
    this.gender = gender;
    ClientStore().setFirestoreUser();
  }

  setDob(DateTime dob) {
    this.dob = dob;
    ClientStore().setFirestoreUser();
  }

  setAvatarID(int avatarID) {
    this.avatarID = avatarID;
    ClientStore().setFirestoreUser();
  }

  setProfilePhotoURL(String profilePhotoURL) {
    this.profilePhotoURL = profilePhotoURL;
    ClientStore().setFirestoreUser();
  }

  setMiniProfilePhotoURL(String miniProfilePhotoURL) {
    this.miniProfilePhotoURL = miniProfilePhotoURL;
    ClientStore().setFirestoreUser();
  }

  Map<dynamic, dynamic> toJson() => _$UserToJson(this);
}

String getGenderString(int code) {
  switch (code) {
    case 0:
      return "male";
    case 1:
      return "female";
    case 2:
      return "all";
  }
}
