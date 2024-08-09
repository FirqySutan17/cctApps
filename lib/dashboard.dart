import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DailyRemainder {
  final String title;
  final String collection;
  final String overDue;
  final String badDebt;

  DailyRemainder(
      {required this.title,
      required this.collection,
      required this.overDue,
      required this.badDebt});

  factory DailyRemainder.fromJSON(Map<String, dynamic> json) {
    return DailyRemainder(
        title: json['YMD'],
        collection: json['COLL'],
        overDue: json['OD'],
        badDebt: json['BD']);
  }
}

class MonthlyRemainder {
  final String title;
  final String collection;
  final String overDue;
  final String badDebt;

  MonthlyRemainder(
      {required this.title,
      required this.collection,
      required this.overDue,
      required this.badDebt});

  factory MonthlyRemainder.fromJSON(Map<String, dynamic> json) {
    return MonthlyRemainder(
        title: json['YYMM'],
        collection: json['COLL'],
        overDue: json['OD'],
        badDebt: json['BD']);
  }
}

class UserRanking {
  final String employeeID;
  final String target;
  final String cashIn;
  final String percentage;

  UserRanking(
      {required this.employeeID,
      required this.target,
      required this.cashIn,
      required this.percentage});

  factory UserRanking.fromJSON(Map<String, dynamic> json) {
    return UserRanking(
        employeeID: json['EMPNO'] + ' - ' + json['EMPLOYEE_NAME'],
        cashIn: json['CASH_IN'],
        target: json['TARGET'],
        percentage: json['PERCENTAGE']);
  }
}

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? _fullName = '';
  String? _tokenAPI = '';

  String urlAPIInternal = 'http://103.209.6.32:8080/cct-api/api';
  // String urlAPI = 'http://103.209.6.32:8080/cct-api/api';
  String urlAPI = 'http://10.137.26.67:8080/cct-api/api';
  bool _isLoading = false;

  DailyRemainder? _dailyRemainder =
      DailyRemainder(title: '', collection: '', overDue: '', badDebt: '');
  MonthlyRemainder? _monthlyRemainder =
      MonthlyRemainder(title: '', collection: '', overDue: '', badDebt: '');

  List<UserRanking> _runningTOP = [];
  List<UserRanking> _runningBOTTOM = [];
  List<UserRanking> _stopTOP = [];
  List<UserRanking> _stopBOTTOM = [];

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

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          print(jsonResponse['data']);
          _dailyRemainder = DailyRemainder.fromJSON(jsonResponse['data']);
          print(_dailyRemainder);
        });
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

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          _monthlyRemainder = MonthlyRemainder.fromJSON(jsonResponse['data']);
        });
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

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        List<dynamic> runningTOP = jsonResponse["data"]["RUNNING"]["TOP"];
        List<dynamic> runningBOTTOM = jsonResponse["data"]["RUNNING"]["BOTTOM"];
        List<dynamic> stopTOP = jsonResponse["data"]["STOP"]["TOP"];
        List<dynamic> stopBOTTOM = jsonResponse["data"]["STOP"]["BOTTOM"];
        setState(() {
          _runningTOP = runningTOP
              .map((itemJson) => UserRanking.fromJSON(itemJson))
              .toList();

          _runningBOTTOM = runningBOTTOM
              .map((itemJson) => UserRanking.fromJSON(itemJson))
              .toList();

          _stopTOP = stopTOP
              .map((itemJson) => UserRanking.fromJSON(itemJson))
              .toList();

          _stopBOTTOM = stopBOTTOM
              .map((itemJson) => UserRanking.fromJSON(itemJson))
              .toList();

          _isLoading = false;
        });
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : content(context),
    );
  }

  Widget rankingName(String name) {
    return Container(
      alignment: Alignment.center,
      width: 170.0,
      height: 55.0,
      color: Color(0xffffa63b),
      margin: EdgeInsets.all(1.0),
      padding: const EdgeInsets.all(10.0),
      child: Text(
        name,
        style: TextStyle(
          color: Color(0xffffffff),
          fontFamily: 'CjFont',
          fontSize: 11,
        ),
      ),
    );
  }

  Widget rankingColl(
      String target, String cashIn, String percentage, bool isHeader) {
    Color backgroundColor = isHeader ? Color(0xff006dcd) : Color(0xffedecec);
    Color textColor = isHeader ? Colors.white : Colors.black;
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          width: 120.0,
          height: 55.0,
          color: backgroundColor,
          margin: EdgeInsets.all(1.0),
          child: Text(
            target,
            style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'CjFont',
                fontSize: 12),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 120.0,
          height: 55.0,
          color: backgroundColor,
          margin: EdgeInsets.all(1.0),
          child: Text(
            cashIn,
            style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'CjFont',
                fontSize: 12),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 120.0,
          height: 55.0,
          color: backgroundColor,
          margin: EdgeInsets.all(1.0),
          child: Text(
            percentage,
            style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'CjFont',
                fontSize: 12),
          ),
        ),
      ],
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
                          Text(_dailyRemainder!.title,
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
                                    Text(_dailyRemainder!.collection,
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
                                    Text(_dailyRemainder!.overDue,
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
                                    Text(_dailyRemainder!.badDebt,
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
                          Text(_monthlyRemainder!.title,
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
                                    Text(_monthlyRemainder!.collection,
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
                                    Text(_monthlyRemainder!.overDue,
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
                                    Text(_monthlyRemainder!.badDebt,
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
                            rankingName(_runningTOP[0].employeeID),
                            rankingName(_runningTOP[1].employeeID),
                            rankingName(_runningTOP[2].employeeID),
                            rankingName(_runningTOP[3].employeeID),
                            rankingName(_runningTOP[4].employeeID),
                          ],
                        ),
                        Flexible(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                rankingColl('TARGET', 'CASH IN', '%', true),
                                rankingColl(
                                    _runningTOP[0].target,
                                    _runningTOP[0].cashIn,
                                    _runningTOP[0].percentage + "%",
                                    false),
                                rankingColl(
                                    _runningTOP[1].target,
                                    _runningTOP[1].cashIn,
                                    _runningTOP[1].percentage + "%",
                                    false),
                                rankingColl(
                                    _runningTOP[2].target,
                                    _runningTOP[2].cashIn,
                                    _runningTOP[2].percentage + "%",
                                    false),
                                rankingColl(
                                    _runningTOP[3].target,
                                    _runningTOP[3].cashIn,
                                    _runningTOP[3].percentage + "%",
                                    false),
                                rankingColl(
                                    _runningTOP[4].target,
                                    _runningTOP[4].cashIn,
                                    _runningTOP[4].percentage + "%",
                                    false),
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
                          ],
                        ),
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
                            rankingName(_runningBOTTOM[0].employeeID),
                            rankingName(_runningBOTTOM[1].employeeID),
                            rankingName(_runningBOTTOM[2].employeeID),
                            rankingName(_runningBOTTOM[3].employeeID),
                            rankingName(_runningBOTTOM[4].employeeID),
                          ],
                        ),
                        Flexible(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                rankingColl('TARGET', 'CASH IN', '%', true),
                                rankingColl(
                                    _runningBOTTOM[0].target,
                                    _runningBOTTOM[0].cashIn,
                                    _runningBOTTOM[0].percentage + "%",
                                    false),
                                rankingColl(
                                    _runningBOTTOM[1].target,
                                    _runningBOTTOM[1].cashIn,
                                    _runningBOTTOM[1].percentage + "%",
                                    false),
                                rankingColl(
                                    _runningBOTTOM[2].target,
                                    _runningBOTTOM[2].cashIn,
                                    _runningBOTTOM[2].percentage + "%",
                                    false),
                                rankingColl(
                                    _runningBOTTOM[3].target,
                                    _runningBOTTOM[3].cashIn,
                                    _runningBOTTOM[3].percentage + "%",
                                    false),
                                rankingColl(
                                    _runningBOTTOM[4].target,
                                    _runningBOTTOM[4].cashIn,
                                    _runningBOTTOM[4].percentage + "%",
                                    false),
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
                            rankingName(_stopTOP[0].employeeID),
                            rankingName(_stopTOP[1].employeeID),
                            rankingName(_stopTOP[2].employeeID),
                            rankingName(_stopTOP[3].employeeID),
                            rankingName(_stopTOP[4].employeeID),
                          ],
                        ),
                        Flexible(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                rankingColl('TARGET', 'CASH IN', '%', true),
                                rankingColl(
                                    _stopTOP[0].target,
                                    _stopTOP[0].cashIn,
                                    _stopTOP[0].percentage + "%",
                                    false),
                                rankingColl(
                                    _stopTOP[1].target,
                                    _stopTOP[1].cashIn,
                                    _stopTOP[1].percentage + "%",
                                    false),
                                rankingColl(
                                    _stopTOP[2].target,
                                    _stopTOP[2].cashIn,
                                    _stopTOP[2].percentage + "%",
                                    false),
                                rankingColl(
                                    _stopTOP[3].target,
                                    _stopTOP[3].cashIn,
                                    _stopTOP[3].percentage + "%",
                                    false),
                                rankingColl(
                                    _stopTOP[4].target,
                                    _stopTOP[4].cashIn,
                                    _stopTOP[4].percentage + "%",
                                    false),
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
                            rankingName(_stopBOTTOM[0].employeeID),
                            rankingName(_stopBOTTOM[1].employeeID),
                            rankingName(_stopBOTTOM[2].employeeID),
                            rankingName(_stopBOTTOM[3].employeeID),
                            rankingName(_stopBOTTOM[4].employeeID),
                          ],
                        ),
                        Flexible(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                rankingColl('TARGET', 'CASH IN', '%', true),
                                rankingColl(
                                    _stopBOTTOM[0].target,
                                    _stopBOTTOM[0].cashIn,
                                    _stopBOTTOM[0].percentage + "%",
                                    false),
                                rankingColl(
                                    _stopBOTTOM[1].target,
                                    _stopBOTTOM[1].cashIn,
                                    _stopBOTTOM[1].percentage + "%",
                                    false),
                                rankingColl(
                                    _stopBOTTOM[2].target,
                                    _stopBOTTOM[2].cashIn,
                                    _stopBOTTOM[2].percentage + "%",
                                    false),
                                rankingColl(
                                    _stopBOTTOM[3].target,
                                    _stopBOTTOM[3].cashIn,
                                    _stopBOTTOM[3].percentage + "%",
                                    false),
                                rankingColl(
                                    _stopBOTTOM[4].target,
                                    _stopBOTTOM[4].cashIn,
                                    _stopBOTTOM[4].percentage + "%",
                                    false),
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
