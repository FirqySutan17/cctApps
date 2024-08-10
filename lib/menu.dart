import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String? _fullName = '';

  @override
  void initState() {
    super.initState();
    getLoginSession();
  }

  Future<void> getLoginSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Ambil nilai dari SharedPreferences
    String? fullName = prefs.getString('full_name');
    // Update state dengan nilai yang diambil
    setState(() {
      _fullName = fullName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      // decoration: BoxDecoration(
      //     image: DecorationImage(image: AssetImage('assets/images/bg-blue.jpg'), fit: BoxFit.cover),
      // ),
      body: content(context),
    );
  }

  Widget content(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/bg-blue.jpg'), fit: BoxFit.cover),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 20.0, right: 15.0, left: 15.0),
                child: Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("MENU",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Cjfont',
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Container(
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xffff9304),
                          ),
                          child: TextButton(
                            // style: TextButton.styleFrom(backgroundColor: Color(0xff007dc3)),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/dashboard');
                            },
                            child: Text(
                              "DASHBOARD",
                              style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 30.0, right: 15.0, left: 15.0),
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Text("Welcome,",
                        //     textAlign: TextAlign.left,
                        //     style: TextStyle(
                        //         fontSize: 18,
                        //         fontFamily: 'Cjfont',
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.bold)),
                        Text(_fullName ?? 'ANONYMOUS',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Cjfont',
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Text("IT SST",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Cjfont',
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ]),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.elliptical(35, 35),
                  topLeft: Radius.elliptical(35, 35),
                ),
              ),
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/visit-entry');
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 5),
                            // width: double.infinity / 2,
                            // height: 300,
                            padding: const EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                                right: 10.0,
                                left: 10.0),
                            decoration: BoxDecoration(
                              color: Color(0xff007dc3),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.elliptical(10, 10),
                                topLeft: Radius.elliptical(10, 10),
                                bottomRight: Radius.elliptical(10, 10),
                                bottomLeft: Radius.elliptical(10, 10),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text("VISIT",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Cjfont',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Text("ENTRY",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Cjfont',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Image.asset(
                                    'assets/images/icon-visit-entry.png',
                                    width: 100,
                                    height: 100)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/visit-report');
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 5),
                            // width: double.infinity / 2,
                            // height: 300,
                            padding: const EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                                right: 10.0,
                                left: 10.0),
                            decoration: BoxDecoration(
                              color: Color(0xff007dc3),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.elliptical(10, 10),
                                topLeft: Radius.elliptical(10, 10),
                                bottomRight: Radius.elliptical(10, 10),
                                bottomLeft: Radius.elliptical(10, 10),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text("VISIT",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Cjfont',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Text("REPORT",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Cjfont',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Image.asset(
                                    'assets/images/icon-visit-report.png',
                                    width: 100,
                                    height: 100)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('/collection-report');
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 5),
                            // width: 160,
                            // height: 300,
                            padding: const EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                                right: 10.0,
                                left: 10.0),
                            decoration: BoxDecoration(
                              color: Color(0xff007dc3),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.elliptical(10, 10),
                                topLeft: Radius.elliptical(10, 10),
                                bottomRight: Radius.elliptical(10, 10),
                                bottomLeft: Radius.elliptical(10, 10),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text("COLLECTION",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Cjfont',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Text("REPORT",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Cjfont',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Image.asset(
                                    'assets/images/icon-collection-report.png',
                                    width: 100,
                                    height: 100)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/overdue-report');
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 5),
                            // width: 160,
                            // height: 300,
                            padding: const EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                                right: 10.0,
                                left: 10.0),
                            decoration: BoxDecoration(
                              color: Color(0xff007dc3),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.elliptical(10, 10),
                                topLeft: Radius.elliptical(10, 10),
                                bottomRight: Radius.elliptical(10, 10),
                                bottomLeft: Radius.elliptical(10, 10),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text("OVERDUE",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Cjfont',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Text("REPORT",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Cjfont',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Image.asset(
                                    'assets/images/icon-overdue-report.png',
                                    width: 100,
                                    height: 100)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff007dc3),
                    ),
                    child: TextButton(
                      // style: TextButton.styleFrom(backgroundColor: Color(0xff007dc3)),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/dashboard');
                      },
                      child: Text("VIEW PROFILE",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Cjfont',
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 195, 29, 0),
                    ),
                    child: TextButton(
                      // style: TextButton.styleFrom(backgroundColor: Color(0xff007dc3)),
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      child: Text("LOGOUT",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Cjfont',
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(
                    height: 16.8,
                  ),
                  Container(
                    // height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset('assets/images/banner-cct-new.jpg'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
