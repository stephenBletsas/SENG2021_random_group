// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    name: json['name'] as String,
    gender: json['gender'] as int,
    dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
    avatarID: json['avatarID'] as int,
    profilePhotoURL: json['profilePhotoURL'] as String,
    miniProfilePhotoURL: json['miniProfilePhotoURL'] as String,
    onboarded: json['onboarded'] as bool,
  );
}

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('dob', instance.dob?.toIso8601String());
  writeNotNull('gender', instance.gender);
  writeNotNull('avatarID', instance.avatarID);
  writeNotNull('profilePhotoURL', instance.profilePhotoURL);
  writeNotNull('miniProfilePhotoURL', instance.miniProfilePhotoURL);
  writeNotNull('onboarded', instance.onboarded);
  return val;
}
