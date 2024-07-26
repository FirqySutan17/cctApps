import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'dashboard.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // decoration: BoxDecoration(
      //     image: DecorationImage(image: AssetImage('assets/images/bg-white.jpg'), fit: BoxFit.cover),
      // ),
      // appBar: AppBar(
      //     // toolbarHeight: 20,
      //     // // backgroundColor: Color(0xff006dcd),
      //     // backgroundColor: Color(0xff006dcd),
      //     elevation: 0
      // ),
      body: content(),
    );
  }

  Widget content() {
    double heightForStack = (MediaQuery.of(context).size.height - 410);
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg-blue.jpg'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.elliptical(15, 15),
                  bottomLeft: Radius.elliptical(15, 15),
                  topRight: Radius.elliptical(15, 15),
                  topLeft: Radius.elliptical(15, 15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Container(
                  child: Center(
                      child: new Image.asset('assets/images/cct-logo.png',
                          width: 125.0, height: 125.0)),
                ),
              ),
            ),
            Container(
              height: heightForStack,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("LOGIN",
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Cjfont',
                              fontWeight: FontWeight.bold)),
                      Text("welcome to cct mobile apps",
                          style: TextStyle(fontSize: 12, fontFamily: 'Cjfont')),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1.5, color: Colors.grey),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Employee ID",
                            labelText: "Employee ID",
                            alignLabelWithHint: false,
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1.5, color: Colors.grey),
                        ),
                        child: TextField(
                          obscureText: passwordVisible,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            labelText: "Password",
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(
                                  () {
                                    passwordVisible = !passwordVisible;
                                  },
                                );
                              },
                            ),
                            alignLabelWithHint: false,
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff007dc3),
                          boxShadow: [
                            BoxShadow(
                              // color: Colors.greenAccent[200],
                              offset: const Offset(
                                1.0,
                                1.0,
                              ),
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                            ), //BoxShadow
                            BoxShadow(
                              color: Colors.white,
                              offset: const Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ), //BoxShadow
                          ],
                        ),
                        child: TextButton(
                          // style: TextButton.styleFrom(backgroundColor: Color(0xff007dc3)),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed('/dashboard');
                          },
                          child: Text(
                            "SIGN IN",
                            style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset('assets/images/banner-cct-new.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
