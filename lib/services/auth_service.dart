import 'dart:convert';
import 'dart:io';

import 'package:bwa_shamo/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  var client = HttpClient();
  String baseUrl =
      'https://shamo-bwa.herokuapp.com/api'; //mengambil url dari API

  Future<UserModel> register({
    //Future digunakan untuk mengambil data secara paralel sehingga akan mempercepat waktu pengambilan data
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    //Asynchronus

    var url = Uri.parse('$baseUrl/register');
    var headers = {
      'Content-Type': 'application/json'
    }; //content-type akan mengambi data token Json yang diberikan
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    // ignore: avoid_print
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)[
          'data']; //['data'] merupakan nama dari api yang disediakan (lihat format get data API)
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];
      return user;
    } else {
      throw Exception('Gagal register!');
    }
  }

  Future<UserModel> login({
    //Future digunakan untuk mengambil data secara paralel sehingga akan mempercepat waktu pengambilan data

    required String email,
    required String password,
  }) async {
    //Asynchronus

    var url = Uri.parse('$baseUrl/login');
    var headers = {
      'Content-Type': 'application/json'
    }; //content-type akan mengambi data token Json yang diberikan
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    // ignore: avoid_print
    print(response.body);

    if (response.statusCode == 200 &&
        jsonDecode(response.body)['data']['user']['roles'] == 'user') {
      var data = jsonDecode(response.body)[
          'data']; //['data'] merupakan nama dari api yang disediakan (lihat format get data API)
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];
      return user;
    } else {
      throw Exception('Gagal login!');
    }
  }

  Future<UserModel> updateProfile({
    required String name,
    required String username,
    required String email,
    required String token,
  }) async {
    var url = Uri.parse('$baseUrl/user');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode(
      {
        'name': name,
        'username': username,
        'email': email,
      },
    );

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data);
      user.token = token;
      return user;
    } else {
      throw Exception('Update Profile gagal');
    }
  }
}
