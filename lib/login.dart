import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uts/constant.dart';
import 'package:flutter_uts/home.dart';
import 'package:flutter_uts/misc/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = new TextEditingController();
  final _passController = new TextEditingController();

  bool _isObscure = true;
  bool? check1 = false;
  late bool newuser;
  late SharedPreferences logindata;

  final String email = 'fardan@gmail.com';
  final String password = '1234';

  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.of(context).push(_createRoute());
    }
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Home(
        email: email,
        pass: password,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  loginData() async {
    final dataLogin = await SharedPreferences.getInstance();
    dataLogin.setString('emailUser', _emailController.text.toString());
    dataLogin.setString('passUser', _passController.text.toString());

    String? emailUser = dataLogin.getString('emailUser');
    String? passUser = dataLogin.getString('passUser');

    if (_emailController.value.text.toString().isEmpty ||
        _passController.value.text.toString().isEmpty) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Email & Password Tidak boleh kosong",
      );
      print('email atau password tidak boleh kosong');
    } else {
      final response = await http.post(
          Uri.parse('http://rismayana.diary-project.com/login.php'),
          body: jsonEncode({
            "username": _emailController.value.text.toString(),
            "password": _passController.value.text.toString()
          }));
      int statCode = response.statusCode;
      if (statCode == 400) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'Gagal Login',
          text: 'Username atau Password tidak sesuai',
        );
        print('gagal login');
      } else if (statCode == 200) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          title: 'Berhasil Login',
          text: '${emailUser}',
          onConfirmBtnTap: () {
            dataLogin.setBool('login', false);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MainPage(
                        email: _emailController.value.text.toString(),
                        pass: _passController.value.text.toString())));
          },
        );
        print('berhasil login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kblue,
          automaticallyImplyLeading: false,
          title: Padding(
            child: Text('Login',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w700)),
            padding: EdgeInsets.only(top: 50, bottom: 10),
          ),
          centerTitle: true,
          toolbarHeight: 110,
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 35, right: 35, bottom: 35, top: 5),
                decoration: BoxDecoration(
                    color: kblue,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(55))),
                child: Image.asset('assets/images/login.png'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 45, left: 45, right: 45),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: false,
                        controller: _emailController,
                        cursorColor: kblue,
                        style: TextStyle(color: kblue),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(width: 2, color: kblue)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: kblue, width: 2.5)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: kblue)),
                            labelText: 'Email',
                            labelStyle: TextStyle(color: kblue),
                            hintText: 'Masukan Email',
                            hintStyle: TextStyle(color: kblue)),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        autofocus: false,
                        obscureText: _isObscure,
                        controller: _passController,
                        style: TextStyle(color: kblue),
                        cursorColor: kblue,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(width: 2, color: kblue)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: kblue, width: 2.5)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: kblue)),
                            labelText: 'Password',
                            labelStyle: TextStyle(color: kblue),
                            hintText: 'Masukan Password',
                            hintStyle: TextStyle(color: kblue),
                            suffixIcon: IconButton(
                                color: kblue,
                                icon: Icon(_isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                })),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: check1,
                            onChanged: (bool? value) {
                              setState(() {
                                check1 = value;
                              });
                            },
                          ),
                          Text('Ingat saya')
                        ],
                      ),
                      SizedBox(height: 25),
                      ElevatedButton(
                          onPressed: () {
                            loginData();
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              backgroundColor: kblue,
                              padding: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 100, right: 100)),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Belum punya akun ? ',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Daftar Disini',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: kblue),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
              )
            ],
          ),
        ));
  }
}
