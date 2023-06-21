import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uts/constant.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter_uts/misc/userviewmodel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  final String email, pass;
  const MainPage({
    Key? key,
    required this.email,
    required this.pass,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late SharedPreferences logindata;
  late String? emails, passwords;

  List dataUser = [];

  void getDataUsers() {
    UserViewModel().getUsers().then((value) {
      setState(() {
        dataUser = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUsers();
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kblue,
        automaticallyImplyLeading: false,
        titleTextStyle: TextStyle(fontFamily: 'Poppins'),
        title: Padding(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Halo, Selamat datang',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w700)),
                    Text(
                      'User',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      'https://www.creativefabrica.com/wp-content/uploads/2023/01/30/Bearded-Man-Avatar-Icon-Graphics-59392089-1.jpg'),
                )
              ],
            ),
          ),
          padding: EdgeInsets.only(top: 80, bottom: 15),
        ),
        centerTitle: false,
        toolbarHeight: 120,
      ),
      body: Column(children: [
        Container(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 30, top: 35),
          decoration: BoxDecoration(
              color: kblue,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
          child: Container(
            child: CupertinoSearchTextField(
              padding: EdgeInsets.all(15),
              placeholder: 'Search',
              placeholderStyle: TextStyle(
                  color: Colors.white, fontSize: 18, fontFamily: 'Poppins'),
              backgroundColor: Colors.white12,
              itemColor: Colors.white,
              itemSize: 27,
              borderRadius: BorderRadius.circular(15),
              style: TextStyle(
                  color: Colors.white, fontSize: 18, fontFamily: 'Poppins'),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Data of User',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'View all',
                style: TextStyle(
                    fontSize: 13, fontFamily: 'Poppins', color: kblue),
              ),
            ],
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: false,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            dataUser == null
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: dataUser.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        borderOnForeground: false,
                        margin: EdgeInsets.only(bottom: 13, left: 5, right: 5),
                        color: Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        elevation: 0.7,
                        child: ListTile(
                          textColor: Colors.white,
                          leading: CircleAvatar(
                            foregroundColor: Colors.transparent,
                            radius: 25,
                            backgroundImage: NetworkImage(
                                'https://www.creativefabrica.com/wp-content/uploads/2023/01/30/Bearded-Man-Avatar-Icon-Graphics-59392089-1.jpg'),
                          ),
                          onTap: () {
                            AlertDialog alert = AlertDialog(
                              alignment: Alignment.center,
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop('dialog');
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      padding: EdgeInsets.only(
                                          top: 10,
                                          right: 30,
                                          bottom: 10,
                                          left: 30),
                                      backgroundColor: kblue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  child: Text(
                                    'OK',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                )
                              ],
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(
                                            'https://www.creativefabrica.com/wp-content/uploads/2023/01/30/Bearded-Man-Avatar-Icon-Graphics-59392089-1.jpg'),
                                      ),
                                      Text(dataUser[index].nama,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600)),
                                      Text(dataUser[index].nim,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.black38,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(Icons.email),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(dataUser[index].prodi.toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(Icons.location_on),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(dataUser[index].alamat,
                                                overflow: TextOverflow.visible,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Poppins',
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.blur_circular),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(dataUser[index].asalSekolah,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.corporate_fare),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(dataUser[index].tempatLahir,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400)),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            );
                            showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          },
                          trailing: Icon(Icons.more_vert),
                          title: Text(dataUser[index].nama,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600)),
                          subtitle: Text(dataUser[index].nim,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w600)),
                        ),
                      );
                    },
                  ),
          ]),
        ))
      ]),
    );
  }
}
