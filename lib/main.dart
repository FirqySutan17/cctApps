import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'dashboard.dart';
import 'menu.dart';
import 'visitreport.dart';
import 'overduereport.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/splash',
    routes: {
      '/splash': (context) => SplashScreen(),
      '/login': (context) => Login(),
      '/dashboard': (context) => Dashboard(),
      '/menu': (context) => Menu(),
      '/visit-report': (context) => VisitReport(),
      '/overdue-report': (context) => OverdueReport(),
    },
  ));
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/login');
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: Image.asset('assets/images/cj-logo.png',
                    width: 200, height: 200),
              ),
              Container(
                child: Text('FEED & CARE',
                    style: TextStyle(fontFamily: 'Cjfont', fontSize: 30)),
              ),
              Container(
                child: Text('INDONESIA',
                    style: TextStyle(fontFamily: 'Cjfont', fontSize: 30)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CCT System'),
      ),
      body: Container(
          // Add your splash screen UI components here
          ),
    );
  }
}
