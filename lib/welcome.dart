import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_uts/home.dart';
import 'package:flutter_uts/main.dart';
import 'package:flutter_uts/onboard/onboard.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      title: 'Onboarding',
      home: Onboard(),
    );
  }
}
