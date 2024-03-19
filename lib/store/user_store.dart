import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minc_macae/model/user.dart';
import 'package:path_provider/path_provider.dart';


class UserStore with ChangeNotifier{
  final _auth = FirebaseAuth.instance;
  static final UserStore _instance = UserStore._internal();
  final LocalUser _storedUser = LocalUser();

  factory UserStore.getInstance() {
    return _instance;
  }

  UserStore._internal();

  getStoredUser() {
    return _storedUser;
  }

  setStoredUser(Map<String, dynamic> json) {
    _storedUser.setUserFromJson(json);
    notifyListeners();
    persistUser();
  }

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/userData.json';
    final file = File(path);
    if (!(await file.exists())) {
      await file.create();
    }
    return file;
  }

  bool isUserLogged() {
    if (_auth.currentUser != null) {
      loadLoggedUser();
      return true;
    }
    return false;
  }

  loadLoggedUser() async {   
    final configFiles = await _localFile;
    final contents = await configFiles.readAsString();    
    if (contents.isNotEmpty) {
      final Map<String, dynamic> configJson = json.decode(contents);
      _storedUser.setUserFromJson(configJson['user']);      
      _storedUser.setUser(_auth.currentUser!);
      notifyListeners();
    }
  }

  persistUser() async {
    String jsonUser = jsonEncode(_storedUser.toJson());    
    await _localFile.then((file) {
      file.writeAsString(jsonUser);
    });
  }
}
