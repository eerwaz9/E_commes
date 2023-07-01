import 'package:flutter/material.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User.getNewEmpty();

  User get user => _user;

  User get usera=>_user;
  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
  void serObjectUser(User user){
    _user=user;
    notifyListeners();
  }
}
