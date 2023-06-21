import 'package:flutter/material.dart';
import 'package:flutter_uts/home.dart';
import 'package:flutter_uts/constant.dart';
import 'package:flutter_uts/login.dart';
import 'package:flutter_uts/onboard/onboard_model.dart';
import 'package:flutter_uts/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  storeOnBoardInfo() async {
    int isView = 0;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('onBoard', isView);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentIndex % 2 == 0 ? kwhite : kblue,
      appBar: AppBar(
        backgroundColor: currentIndex % 2 == 0 ? kwhite : kblue,
        elevation: 0,
        actions: [
          Padding(
              padding: EdgeInsets.all(8),
              child: TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.all(5),
                      backgroundColor: currentIndex % 2 == 0 ? kblue : kwhite,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  onPressed: () async {
                    await storeOnBoardInfo();
                    Navigator.of(context).push(_createRoute());
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                          fontSize: 15.0,
                          color: currentIndex % 2 == 0 ? kwhite : kblue),
                    ),
                  ))),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: PageView.builder(
          itemCount: screens.length,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (BuildContext context, int index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(screens[index].img),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 10.0,
                  child: ListView.builder(
                    itemCount: screens.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 3.0),
                            width: currentIndex == index ? 35.0 : 10.0,
                            height: 10,
                            decoration: BoxDecoration(
                                color:
                                    currentIndex == index ? kbrown : kbrown300,
                                borderRadius: BorderRadius.circular(10.0)),
                          )
                        ],
                      );
                    },
                  ),
                ),
                Text(
                  screens[index].text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: index % 2 == 0 ? kblack : kwhite,
                  ),
                ),
                Text(
                  screens[index].desc,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins-Regular',
                    fontSize: 18.0,
                    color: index % 2 == 0 ? kblack : kwhite,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await storeOnBoardInfo();
                    if (index == screens.length - 1) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    }

                    _pageController.nextPage(
                        duration: Duration(microseconds: 300),
                        curve: Curves.bounceIn);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: index % 2 == 0 ? kblue : kwhite,
                        borderRadius: BorderRadius.circular(25.0)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                              fontSize: 18.00,
                              color: index % 2 == 0 ? kwhite : kblue,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.arrow_forward_sharp,
                          color: index % 2 == 0 ? kwhite : kblue,
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Login(),
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

  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
      img: 'assets/images/img-1.png',
      text: "Belajar Dengan Metode Learning by Doing",
      desc:
          "Sebuah metode belajar yang terbuktiampuh dalam meningkatkan produktifitas belajar, Learning by Doing",
      bg: Colors.white,
      button: Color(0xFF4756DF),
    ),
    OnboardModel(
      img: 'assets/images/img-2.png',
      text: "Dapatkan Kemudahan Akses Kapanpun dan Dimanapun",
      desc:
          "Tidak peduli dimanapun kamu, semua kursus yang telah kamu ikuti bias kamu akses sepenuhnya",
      bg: Color(0xFF4756DF),
      button: Colors.white,
    ),
    OnboardModel(
      img: 'assets/images/img-3.png',
      text: "Gunakan Fitur Kolaborasi Untuk Pengalaman Lebih",
      desc:
          "Tersedia fitur Kolaborasi dengan tujuan untuk mengasah skill lebih dalam karena bias belajar bersama",
      bg: Colors.white,
      button: Color(0xFF4756DF),
    ),
  ];
}
