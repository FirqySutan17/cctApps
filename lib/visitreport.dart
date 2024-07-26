import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class VisitReport extends StatelessWidget {
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
              // margin: EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 20.0, right: 15.0, left: 15.0),
                child: Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("VISIT REPORT",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Cjfont',
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xffff9304),
                          ),
                          child: TextButton(
                            // style: TextButton.styleFrom(backgroundColor: Color(0xff007dc3)),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/menu');
                            },
                            child: Text(
                              "MENU",
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
            // Container(
            //   child: Padding(
            //     padding: const EdgeInsets.only(
            //         bottom: 30.0, right: 15.0, left: 15.0),
            //     child: Container(
            //       child: Column(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: [
            //             // Text("Welcome,",
            //             //     textAlign: TextAlign.left,
            //             //     style: TextStyle(
            //             //         fontSize: 18,
            //             //         fontFamily: 'Cjfont',
            //             //         color: Colors.white,
            //             //         fontWeight: FontWeight.bold)),
            //             Text("FIRQY SUTANWALIYAH IKHSAN",
            //                 textAlign: TextAlign.left,
            //                 style: TextStyle(
            //                     fontSize: 16,
            //                     fontFamily: 'Cjfont',
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.bold)),
            //             Text("IT SST",
            //                 textAlign: TextAlign.left,
            //                 style: TextStyle(
            //                     fontSize: 16,
            //                     fontFamily: 'Cjfont',
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.bold)),
            //           ]),
            //     ),
            //   ),
            // ),
            Container(
              width: double.infinity,
              // height: 300,
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
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffff9304),
                    ),
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 20.0, left: 20.0),
                    child: TextButton(
                        // style: TextButton.styleFrom(backgroundColor: Color(0xff007dc3)),
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/dashboard');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("FILTER",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Cjfont',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            Image.asset('assets/images/icon-filter.png',
                                width: 27, height: 27)
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/visit-report');
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          top: 15.0, bottom: 15.0, right: 10.0, left: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.elliptical(10, 10),
                          topLeft: Radius.elliptical(10, 10),
                          bottomRight: Radius.elliptical(10, 10),
                          bottomLeft: Radius.elliptical(10, 10),
                        ),
                        border: Border(
                          top: BorderSide(
                            color: Color(0xffedecec),
                            width: 2,
                          ),
                          left: BorderSide(color: Color(0xffedecec), width: 2),
                          right: BorderSide(color: Color(0xffedecec), width: 2),
                          bottom:
                              BorderSide(color: Color(0xffedecec), width: 2),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("25-07-2024",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("#VISIT202407250002",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Cjfont',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                Text("CJFEED SEMARANG",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("1086872 - SUPER GLOBAL UNGGAS",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("RIFKY MUSLIM GHOZALI",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Image.asset('assets/images/icon-right.png',
                                    width: 27, height: 27)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/visit-report');
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          top: 15.0, bottom: 15.0, right: 10.0, left: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.elliptical(10, 10),
                          topLeft: Radius.elliptical(10, 10),
                          bottomRight: Radius.elliptical(10, 10),
                          bottomLeft: Radius.elliptical(10, 10),
                        ),
                        border: Border(
                          top: BorderSide(
                            color: Color(0xffedecec),
                            width: 2,
                          ),
                          left: BorderSide(color: Color(0xffedecec), width: 2),
                          right: BorderSide(color: Color(0xffedecec), width: 2),
                          bottom:
                              BorderSide(color: Color(0xffedecec), width: 2),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("25-07-2024",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("#VISIT202407250002",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Cjfont',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                Text("CJFEED SEMARANG",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("1086872 - SUPER GLOBAL UNGGAS",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("RIFKY MUSLIM GHOZALI",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Image.asset('assets/images/icon-right.png',
                                    width: 27, height: 27)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/visit-report');
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          top: 15.0, bottom: 15.0, right: 10.0, left: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.elliptical(10, 10),
                          topLeft: Radius.elliptical(10, 10),
                          bottomRight: Radius.elliptical(10, 10),
                          bottomLeft: Radius.elliptical(10, 10),
                        ),
                        border: Border(
                          top: BorderSide(
                            color: Color(0xffedecec),
                            width: 2,
                          ),
                          left: BorderSide(color: Color(0xffedecec), width: 2),
                          right: BorderSide(color: Color(0xffedecec), width: 2),
                          bottom:
                              BorderSide(color: Color(0xffedecec), width: 2),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("25-07-2024",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("#VISIT202407250002",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Cjfont',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                Text("CJFEED SEMARANG",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("1086872 - SUPER GLOBAL UNGGAS",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("RIFKY MUSLIM GHOZALI",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Image.asset('assets/images/icon-right.png',
                                    width: 27, height: 27)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/visit-report');
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          top: 15.0, bottom: 15.0, right: 10.0, left: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.elliptical(10, 10),
                          topLeft: Radius.elliptical(10, 10),
                          bottomRight: Radius.elliptical(10, 10),
                          bottomLeft: Radius.elliptical(10, 10),
                        ),
                        border: Border(
                          top: BorderSide(
                            color: Color(0xffedecec),
                            width: 2,
                          ),
                          left: BorderSide(color: Color(0xffedecec), width: 2),
                          right: BorderSide(color: Color(0xffedecec), width: 2),
                          bottom:
                              BorderSide(color: Color(0xffedecec), width: 2),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("25-07-2024",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("#VISIT202407250002",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Cjfont',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                Text("CJFEED SEMARANG",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("1086872 - SUPER GLOBAL UNGGAS",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("RIFKY MUSLIM GHOZALI",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Image.asset('assets/images/icon-right.png',
                                    width: 27, height: 27)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/visit-report');
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          top: 15.0, bottom: 15.0, right: 10.0, left: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.elliptical(10, 10),
                          topLeft: Radius.elliptical(10, 10),
                          bottomRight: Radius.elliptical(10, 10),
                          bottomLeft: Radius.elliptical(10, 10),
                        ),
                        border: Border(
                          top: BorderSide(
                            color: Color(0xffedecec),
                            width: 2,
                          ),
                          left: BorderSide(color: Color(0xffedecec), width: 2),
                          right: BorderSide(color: Color(0xffedecec), width: 2),
                          bottom:
                              BorderSide(color: Color(0xffedecec), width: 2),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("25-07-2024",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("#VISIT202407250002",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Cjfont',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                Text("CJFEED SEMARANG",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("1086872 - SUPER GLOBAL UNGGAS",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("RIFKY MUSLIM GHOZALI",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Image.asset('assets/images/icon-right.png',
                                    width: 27, height: 27)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/visit-report');
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          top: 15.0, bottom: 15.0, right: 10.0, left: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.elliptical(10, 10),
                          topLeft: Radius.elliptical(10, 10),
                          bottomRight: Radius.elliptical(10, 10),
                          bottomLeft: Radius.elliptical(10, 10),
                        ),
                        border: Border(
                          top: BorderSide(
                            color: Color(0xffedecec),
                            width: 2,
                          ),
                          left: BorderSide(color: Color(0xffedecec), width: 2),
                          right: BorderSide(color: Color(0xffedecec), width: 2),
                          bottom:
                              BorderSide(color: Color(0xffedecec), width: 2),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("25-07-2024",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("#VISIT202407250002",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Cjfont',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                Text("CJFEED SEMARANG",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("1086872 - SUPER GLOBAL UNGGAS",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("RIFKY MUSLIM GHOZALI",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Image.asset('assets/images/icon-right.png',
                                    width: 27, height: 27)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
