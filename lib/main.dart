import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_uts/splash.dart';
import 'package:flutter_uts/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isView;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();

  isView = preferences.getInt('onBoard');

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => const Splash(),
      '/welcome': (context) => const Welcome(),
    },
  ));
}
