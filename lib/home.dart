import 'package:flutter/material.dart';
import 'package:flutter_uts/constant.dart';
import 'package:flutter_uts/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  final String email, pass;

  const Home({
    Key? key,
    required this.email,
    required this.pass,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SharedPreferences logindata;
  late String? emails, passwords;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      emails = logindata.getString('userEmail');
      passwords = logindata.getString('passUser');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kblue,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kblue,
        title: Padding(
          child: Text('Profile',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w700)),
          padding: EdgeInsets.only(top: 50, bottom: 20),
        ),
        centerTitle: true,
        toolbarHeight: 100,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fardan Faturrahman',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            'Bandung Barat',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                                wordSpacing: 1,
                                letterSpacing: 0.5),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 25, left: 25, bottom: 0, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Programming Enthusiast',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.3,
                      wordSpacing: 1),
                ),
                Text(
                  'Make a Masterpiece from a Code',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.3,
                      wordSpacing: 1),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25, left: 25, bottom: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.android_rounded,
                        color: kblue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Android Dev',
                        style: TextStyle(color: kblue),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 14,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.design_services,
                        color: kblue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'UI/UX Designer',
                        style: TextStyle(color: kblue),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 25, left: 25),
                    child: Text(
                      'Biodata',
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20, left: 25, bottom: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.black45,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Nama',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black45),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Fardan Faturrahman H',
                                style: TextStyle(
                                    fontSize: 18.5,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.1),
                              )
                            ],
                          )
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 5, left: 25, bottom: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.credit_card,
                                color: Colors.black45,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'NIM',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black45),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'D112011030',
                                style: TextStyle(
                                    fontSize: 18.5,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.1),
                              )
                            ],
                          )
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 5, left: 25, bottom: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.school,
                                color: Colors.black45,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Perguruan Tinggi',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black45),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Politeknik TEDC Bandung',
                                style: TextStyle(
                                    fontSize: 18.5,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.1),
                              )
                            ],
                          )
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 5, left: 25, bottom: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.design_services,
                                color: Colors.black45,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Program Studi',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black45),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Teknik Informatika',
                                style: TextStyle(
                                    fontSize: 18.5,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.1),
                              )
                            ],
                          )
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 5, left: 25, bottom: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.date_range,
                                color: Colors.black45,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Tanggal Lahir',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black45),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '08/08/2002',
                                style: TextStyle(
                                    fontSize: 18.5,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.1),
                              )
                            ],
                          )
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 5, left: 25, bottom: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 50,
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              ElevatedButton.icon(
                                  onPressed: () {
                                    logindata.setBool('login', true);
                                    Navigator.pushReplacement(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => Login()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      padding: EdgeInsets.only(
                                          top: 10,
                                          right: 20,
                                          bottom: 10,
                                          left: 20),
                                      backgroundColor: Colors.redAccent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25))),
                                  icon: Icon(Icons.exit_to_app),
                                  label: Text(
                                    'LOGOUT',
                                    style: TextStyle(fontSize: 18),
                                  ))
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
