import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? _fullName = '';
  String? _tokenAPI = '';

  String urlAPIExternal = 'http://103.209.6.32:8080/cct-api/api';
  String urlAPI = 'http://10.137.26.67:8080/cct-api/api';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initProcess();
  }

  Future<void> _initProcess() async {
    setState(() {
      _isLoading = true;
    });

    await getLoginSession();
    if (_tokenAPI != null) {
      await dailyRemainderLoad();
      await monthlyRemainderLoad();
      await monthlyRankingLoad();
    }
  }

  Future<void> getLoginSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Ambil nilai dari SharedPreferences
    String? fullName = prefs.getString('full_name');
    String? token = prefs.getString('token');
    // Update state dengan nilai yang diambil
    setState(() {
      _fullName = fullName;
      _tokenAPI = token;
    });
  }

  Future<void> dailyRemainderLoad() async {
    String url = urlAPI + '/dashboard/daily-remainder';
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $_tokenAPI'},
      );

      print(response.body);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print("RESPONSE API DAILY REMAINDER : $jsonResponse");
      }
    } on http.ClientException catch (e) {
      // Handle socket exception - connection timeout
      print('SocketException: ${e.message}');
      print('URL:\n${e.uri}');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> monthlyRemainderLoad() async {
    String url = urlAPI + '/dashboard/monthly-remainder';
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $_tokenAPI'},
      );

      print(response.body);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print("RESPONSE API MONTHLY REMAINDER : $jsonResponse");
      }
    } on http.ClientException catch (e) {
      // Handle socket exception - connection timeout
      print('SocketException: ${e.message}');
      print('URL:\n${e.uri}');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> monthlyRankingLoad() async {
    String url = urlAPI + '/dashboard/monthly-ranking';
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $_tokenAPI'},
      );

      print(response.body);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print("RESPONSE API MONTHLY RANKING : $jsonResponse");
      }
    } on http.ClientException catch (e) {
      // Handle socket exception - connection timeout
      print('SocketException: ${e.message}');
      print('URL:\n${e.uri}');
    } catch (e) {
      print('Error: $e');
    }
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
                        Text("DASHBOARD",
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
            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 30.0, right: 15.0, left: 15.0),
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Welcome,",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Cjfont',
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
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
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    // height: 200,
                    decoration: BoxDecoration(
                      color: Color(0xff007dc3),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.elliptical(15, 15),
                        topLeft: Radius.elliptical(15, 15),
                        bottomRight: Radius.elliptical(15, 15),
                        bottomLeft: Radius.elliptical(15, 15),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, bottom: 10.0, right: 5.0, left: 5.0),
                      child: Column(
                        children: [
                          Text("DAILY JULY 2024",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Cjfont',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                width: 310,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Color(0xffff9304),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.elliptical(5, 5),
                                    topLeft: Radius.elliptical(5, 5),
                                    bottomRight: Radius.elliptical(5, 5),
                                    bottomLeft: Radius.elliptical(5, 5),
                                  ),
                                ),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 15.0,
                                    left: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("COLLECTION",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Cjfont',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text("126.594",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: 'Cjfont',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                width: 310,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Color(0xffffa741),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.elliptical(5, 5),
                                    topLeft: Radius.elliptical(5, 5),
                                    bottomRight: Radius.elliptical(5, 5),
                                    bottomLeft: Radius.elliptical(5, 5),
                                  ),
                                ),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 15.0,
                                    left: 15.0),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("OVERDUE",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Cjfont',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text("70.262",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: 'Cjfont',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                width: 310,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Color(0xfffb9b28),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.elliptical(5, 5),
                                    topLeft: Radius.elliptical(5, 5),
                                    bottomRight: Radius.elliptical(5, 5),
                                    bottomLeft: Radius.elliptical(5, 5),
                                  ),
                                ),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 15.0,
                                    left: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("BAD DEBT",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Cjfont',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text("556.307",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: 'Cjfont',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    // height: 200,
                    decoration: BoxDecoration(
                      color: Color(0xff007dc3),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.elliptical(15, 15),
                        topLeft: Radius.elliptical(15, 15),
                        bottomRight: Radius.elliptical(15, 15),
                        bottomLeft: Radius.elliptical(15, 15),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, bottom: 10.0, right: 5.0, left: 5.0),
                      child: Column(
                        children: [
                          Text("MONTHLY JULY 2024",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Cjfont',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                width: 310,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Color(0xffff9304),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.elliptical(5, 5),
                                    topLeft: Radius.elliptical(5, 5),
                                    bottomRight: Radius.elliptical(5, 5),
                                    bottomLeft: Radius.elliptical(5, 5),
                                  ),
                                ),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 15.0,
                                    left: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("COLLECTION",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Cjfont',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text("126.594",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: 'Cjfont',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                width: 310,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Color(0xffffa741),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.elliptical(5, 5),
                                    topLeft: Radius.elliptical(5, 5),
                                    bottomRight: Radius.elliptical(5, 5),
                                    bottomLeft: Radius.elliptical(5, 5),
                                  ),
                                ),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 15.0,
                                    left: 15.0),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("OVERDUE",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Cjfont',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text("70.262",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: 'Cjfont',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                width: 310,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Color(0xfffb9b28),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.elliptical(5, 5),
                                    topLeft: Radius.elliptical(5, 5),
                                    bottomRight: Radius.elliptical(5, 5),
                                    bottomLeft: Radius.elliptical(5, 5),
                                  ),
                                ),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 15.0,
                                    left: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("BAD DEBT",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Cjfont',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text("556.307",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: 'Cjfont',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, right: 15.0, left: 15.0),
                      child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("RUNNING - JULY 2024",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text("TOP 5",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic)),
                            ]),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xff006dcd),
                                margin: EdgeInsets.all(1.0),
                                child: Text(
                                  "NAME",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'CjFont',
                                      fontSize: 12),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xffffa63b),
                                margin: EdgeInsets.all(1.0),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 10.0,
                                    left: 10.0),
                                child: Text(
                                  "01220024 - RAHMAT SENTUH",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontFamily: 'CjFont',
                                      fontSize: 11),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xffffa63b),
                                margin: EdgeInsets.all(1.0),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 10.0,
                                    left: 10.0),
                                child: Text(
                                  "01120051 - SUGITO MARTONO",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontFamily: 'CjFont',
                                      fontSize: 11),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xffffa63b),
                                margin: EdgeInsets.all(1.0),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 10.0,
                                    left: 10.0),
                                child: Text(
                                  "05230002 - RIFKY MUSLIM GHOZALI",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontFamily: 'CjFont',
                                      fontSize: 11),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xffffa63b),
                                margin: EdgeInsets.all(1.0),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 10.0,
                                    left: 10.0),
                                child: Text(
                                  "02210604 - EKO YUDO PRAKOSO",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontFamily: 'CjFont',
                                      fontSize: 11),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xffffa63b),
                                margin: EdgeInsets.all(1.0),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 10.0,
                                    left: 10.0),
                                child: Text(
                                  "02150375 - AGUS PRIYONO",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontFamily: 'CjFont',
                                      fontSize: 11),
                                ),
                              ),
                            ]),
                        Flexible(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xff006dcd),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "TARGET",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xff006dcd),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "CASH IN",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xff006dcd),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "%",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "809",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "599",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "73.96%",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "4.548",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "3.354",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "73.74%",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "32.387",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "19.542",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "60.34%",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "3.949",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "2.072",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "52.46%",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "12.567",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "6.197",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "49.31%",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, right: 15.0, left: 15.0),
                      child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("RUNNING - JULY 2024",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text("BOTTOM 5",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic)),
                            ]),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xff006dcd),
                                margin: EdgeInsets.all(1.0),
                                child: Text(
                                  "NAME",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'CjFont',
                                      fontSize: 12),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xffffa63b),
                                margin: EdgeInsets.all(1.0),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 10.0,
                                    left: 10.0),
                                child: Text(
                                  "01220024 - RAHMAT SENTUH",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontFamily: 'CjFont',
                                      fontSize: 11),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xffffa63b),
                                margin: EdgeInsets.all(1.0),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 10.0,
                                    left: 10.0),
                                child: Text(
                                  "01120051 - SUGITO MARTONO",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontFamily: 'CjFont',
                                      fontSize: 11),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xffffa63b),
                                margin: EdgeInsets.all(1.0),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 10.0,
                                    left: 10.0),
                                child: Text(
                                  "05230002 - RIFKY MUSLIM GHOZALI",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontFamily: 'CjFont',
                                      fontSize: 11),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xffffa63b),
                                margin: EdgeInsets.all(1.0),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 10.0,
                                    left: 10.0),
                                child: Text(
                                  "02210604 - EKO YUDO PRAKOSO",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontFamily: 'CjFont',
                                      fontSize: 11),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xffffa63b),
                                margin: EdgeInsets.all(1.0),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 10.0,
                                    left: 10.0),
                                child: Text(
                                  "02150375 - AGUS PRIYONO",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontFamily: 'CjFont',
                                      fontSize: 11),
                                ),
                              ),
                            ]),
                        Flexible(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xff006dcd),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "TARGET",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xff006dcd),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "CASH IN",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xff006dcd),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "%",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "809",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "599",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "73.96%",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "4.548",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "3.354",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "73.74%",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "32.387",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "19.542",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "60.34%",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "3.949",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "2.072",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "52.46%",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "12.567",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "6.197",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "49.31%",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, right: 15.0, left: 15.0),
                      child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("STOP - JULY 2024",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text("TOP 5",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic)),
                            ]),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xff006dcd),
                                margin: EdgeInsets.all(1.0),
                                child: Text(
                                  "NAME",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'CjFont',
                                      fontSize: 12),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xffffa63b),
                                margin: EdgeInsets.all(1.0),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 10.0,
                                    left: 10.0),
                                child: Text(
                                  "01220024 - RAHMAT SENTUH",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontFamily: 'CjFont',
                                      fontSize: 11),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xffffa63b),
                                margin: EdgeInsets.all(1.0),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 10.0,
                                    left: 10.0),
                                child: Text(
                                  "01120051 - SUGITO MARTONO",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontFamily: 'CjFont',
                                      fontSize: 11),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xffffa63b),
                                margin: EdgeInsets.all(1.0),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 10.0,
                                    left: 10.0),
                                child: Text(
                                  "05230002 - RIFKY MUSLIM GHOZALI",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontFamily: 'CjFont',
                                      fontSize: 11),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xffffa63b),
                                margin: EdgeInsets.all(1.0),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 10.0,
                                    left: 10.0),
                                child: Text(
                                  "02210604 - EKO YUDO PRAKOSO",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontFamily: 'CjFont',
                                      fontSize: 11),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xffffa63b),
                                margin: EdgeInsets.all(1.0),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 10.0,
                                    left: 10.0),
                                child: Text(
                                  "02150375 - AGUS PRIYONO",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontFamily: 'CjFont',
                                      fontSize: 11),
                                ),
                              ),
                            ]),
                        Flexible(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xff006dcd),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "TARGET",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xff006dcd),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "CASH IN",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xff006dcd),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "%",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "809",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "599",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "73.96%",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "4.548",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "3.354",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "73.74%",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "32.387",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "19.542",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "60.34%",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "3.949",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "2.072",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "52.46%",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "12.567",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "6.197",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "49.31%",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, right: 15.0, left: 15.0),
                      child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("STOP - JULY 2024",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text("BOTTOM 5",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Cjfont',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic)),
                            ]),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xff006dcd),
                                margin: EdgeInsets.all(1.0),
                                child: Text(
                                  "NAME",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'CjFont',
                                      fontSize: 12),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xffffa63b),
                                margin: EdgeInsets.all(1.0),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 10.0,
                                    left: 10.0),
                                child: Text(
                                  "01220024 - RAHMAT SENTUH",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontFamily: 'CjFont',
                                      fontSize: 11),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xffffa63b),
                                margin: EdgeInsets.all(1.0),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 10.0,
                                    left: 10.0),
                                child: Text(
                                  "01120051 - SUGITO MARTONO",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontFamily: 'CjFont',
                                      fontSize: 11),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xffffa63b),
                                margin: EdgeInsets.all(1.0),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 10.0,
                                    left: 10.0),
                                child: Text(
                                  "05230002 - RIFKY MUSLIM GHOZALI",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontFamily: 'CjFont',
                                      fontSize: 11),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xffffa63b),
                                margin: EdgeInsets.all(1.0),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 10.0,
                                    left: 10.0),
                                child: Text(
                                  "02210604 - EKO YUDO PRAKOSO",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontFamily: 'CjFont',
                                      fontSize: 11),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 170.0,
                                height: 55.0,
                                color: Color(0xffffa63b),
                                margin: EdgeInsets.all(1.0),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 10.0,
                                    left: 10.0),
                                child: Text(
                                  "02150375 - AGUS PRIYONO",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontFamily: 'CjFont',
                                      fontSize: 11),
                                ),
                              ),
                            ]),
                        Flexible(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xff006dcd),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "TARGET",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xff006dcd),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "CASH IN",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xff006dcd),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "%",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "809",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "599",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "73.96%",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "4.548",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "3.354",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "73.74%",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "32.387",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "19.542",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "60.34%",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "3.949",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "2.072",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "52.46%",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "12.567",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "6.197",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 120.0,
                                      height: 55.0,
                                      color: Color(0xffedecec),
                                      margin: EdgeInsets.all(1.0),
                                      child: Text(
                                        "49.31%",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'CjFont',
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
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
