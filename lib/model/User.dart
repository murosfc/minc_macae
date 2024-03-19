import 'package:firebase_auth/firebase_auth.dart';

import 'package:minc_macae/enum/user_role.dart';

class LocalUser {
  String? uid;
  String? providerId;
  String? phoneNumber;
  String? displayName;
  String? email;
  String? photoURL;
  List<UserRole>? userRole;

  LocalUser({
    this.uid,
    this.providerId,
    this.phoneNumber,
    this.displayName,
    this.email,
    this.photoURL,
    this.userRole,
  });

  setUserFromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    providerId = json['providerId'];
    phoneNumber = json['phoneNumber'];
    displayName = json['displayName'];
    email = json['email'];
    photoURL = json['photoUrl'];
    userRole = json['userRole']?.map<UserRole>((role) => UserRole.values[role]).toList() ?? [UserRole.admin];
  }

  setUser(User user) {
    uid = user.uid;
    phoneNumber = user.phoneNumber;
    displayName = user.displayName;
    email = user.email;
    photoURL = user.photoURL;    
  }

  Map<String, dynamic> toJson() {
    return {
      'user': {
        'uid': uid,
        'providerId': providerId,
        'phoneNumber': phoneNumber,
        'displayName': displayName,
        'email': email,
        'photoUrl': photoURL,
        'userRole': userRole?.map<int>((role) => role.index).toList(),
      }
    };
  }
}
