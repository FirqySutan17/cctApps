import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? _fullName = '';
  TextEditingController name =
      TextEditingController(text: 'Firqy Sutanwaliyah Ikhsan');
  TextEditingController npk = TextEditingController(text: '01220023');
  TextEditingController email = TextEditingController(text: 'firqy@cj.co.id');
  TextEditingController site = TextEditingController(text: 'CJFNC JAKARTA');
  TextEditingController dept = TextEditingController(text: 'IT SST');

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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        // decoration: BoxDecoration(
        //     image: DecorationImage(image: AssetImage('assets/images/bg-blue.jpg'), fit: BoxFit.cover),
        // ),
        body: content(context),
      ),
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
                    top: 20.0, bottom: 0.0, right: 15.0, left: 15.0),
                child: Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("PROFILE",
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
                    height: 30,
                  ),
                  Image.asset('assets/images/avatar.png',
                      width: 190.0, height: 190.0),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: npk,
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'EMPLOYEE ID',
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Cjfont',
                          fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Color(0xffeeeeee),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: name,
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'NAME',
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Cjfont',
                          fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Color(0xffeeeeee),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: email,
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'EMAIL',
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Cjfont',
                          fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Color(0xffeeeeee),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: site,
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'SITE',
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Cjfont',
                          fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Color(0xffeeeeee),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // TextField(
                  //   controller: dept,
                  //   readOnly: true,
                  //   decoration: const InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     labelText: 'DEPARTMENT',
                  //     labelStyle: TextStyle(
                  //       color: Colors.black,
                  //       fontFamily: 'Cjfont',
                  //     ),
                  //     filled: true,
                  //     fillColor: Color(0xffeeeeee),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20,
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
