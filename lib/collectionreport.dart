import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class OverdueReport extends StatelessWidget {
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
                        Text("OVERDUE REPORT",
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
                                width: 30, height: 30)
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/overdue-report');
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
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("25-07-2024",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text(
                                    "[1055584] PAPANDAYAN ANUGERAH SEJAHTERA. PT",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Cjfont',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("3210 - [ID] Serang",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("GC : Drh. BAGUS SETIABUDI",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("SALES : RIFKY MUSLIM GHOZALI",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("OVERDUE :",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("123.456",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                    'assets/images/icon-right.png',
                                    width: 30,
                                    height: 30)),
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
                          .pushReplacementNamed('/overdue-report');
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
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("25-07-2024",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text(
                                    "[1055584] PAPANDAYAN ANUGERAH SEJAHTERA. PT",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Cjfont',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("3210 - [ID] Serang",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("GC : Drh. BAGUS SETIABUDI",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("SALES : RIFKY MUSLIM GHOZALI",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("OVERDUE :",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("123.456",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                    'assets/images/icon-right.png',
                                    width: 30,
                                    height: 30)),
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
                          .pushReplacementNamed('/overdue-report');
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
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("25-07-2024",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text(
                                    "[1055584] PAPANDAYAN ANUGERAH SEJAHTERA. PT",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Cjfont',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("3210 - [ID] Serang",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("GC : Drh. BAGUS SETIABUDI",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("SALES : RIFKY MUSLIM GHOZALI",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("OVERDUE :",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("123.456",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                    'assets/images/icon-right.png',
                                    width: 30,
                                    height: 30)),
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
                          .pushReplacementNamed('/overdue-report');
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
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("25-07-2024",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text(
                                    "[1055584] PAPANDAYAN ANUGERAH SEJAHTERA. PT",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Cjfont',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("3210 - [ID] Serang",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("GC : Drh. BAGUS SETIABUDI",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("SALES : RIFKY MUSLIM GHOZALI",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("OVERDUE :",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("123.456",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                    'assets/images/icon-right.png',
                                    width: 30,
                                    height: 30)),
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
                          .pushReplacementNamed('/overdue-report');
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
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("25-07-2024",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text(
                                    "[1055584] PAPANDAYAN ANUGERAH SEJAHTERA. PT",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Cjfont',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("3210 - [ID] Serang",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("GC : Drh. BAGUS SETIABUDI",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("SALES : RIFKY MUSLIM GHOZALI",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("OVERDUE :",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("123.456",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                    'assets/images/icon-right.png',
                                    width: 30,
                                    height: 30)),
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
                          .pushReplacementNamed('/overdue-report');
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
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("25-07-2024",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text(
                                    "[1055584] PAPANDAYAN ANUGERAH SEJAHTERA. PT",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Cjfont',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("3210 - [ID] Serang",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("GC : Drh. BAGUS SETIABUDI",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("SALES : RIFKY MUSLIM GHOZALI",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("OVERDUE :",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                    )),
                                Text("123.456",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                    'assets/images/icon-right.png',
                                    width: 30,
                                    height: 30)),
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
