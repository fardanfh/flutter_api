import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter_uts/misc/usermodel.dart';
import 'package:http/http.dart' as http;

class UserViewModel {
  Future getUsers() async {
    try {
      http.Response resp = await http.get(
          Uri.parse(
              'http://rismayana.diary-project.com/bio.php?prodi=Teknik Informatika'),
          headers: {"Accept": "application/json"});
      if (resp.statusCode == 200) {
        print('ok');
        final data = userModelFromJson(resp.body);
        return data;
      } else {
        print("error status " + resp.statusCode.toString());
        return null;
      }
    } catch (e) {
      print("error catch $e");
      return null;
    }
  }
}
