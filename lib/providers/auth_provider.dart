import 'package:bwa_shamo/models/user_model.dart';
import 'package:bwa_shamo/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  late UserModel
      _user; //late bertugas untuk sebuah kasus dimana penggunanya sudah mengetahui bahwa nilai dalam suatu variabel tidak akan bernilai null namun belum diinisialisasi

  // mengatur getter pada UserModel
  UserModel get user => _user;

// mengatur setter UserModel
  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      UserModel user = await AuthService().register(
        name: name,
        username: username,
        email: email,
        password: password,
      );
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );
      _user = user;
      return true;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }

  Future<bool> updateProfile({
    required String name,
    required String username,
    required String email,
    required String token,
  }) async {
    try {
      UserModel user = await AuthService().updateProfile(
        name: name,
        username: username,
        email: email,
        token: token,
      );
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
