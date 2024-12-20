import 'dart:async';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cct/repositories/apirepositories.dart';

class DailyRemainder {
  final String title;
  final String collection;
  final String overDue;
  final String badDebt;
  final String marginCOLL;
  final String marginOD;
  final String marginBD;

  DailyRemainder({
    required this.title,
    required this.collection,
    required this.overDue,
    required this.badDebt,
    required this.marginCOLL,
    required this.marginOD,
    required this.marginBD,
  });

  factory DailyRemainder.fromJSON(Map<String, dynamic> json) {
    return DailyRemainder(
      title: json['YMD'],
      collection: json['COLL'].toString(),
      overDue: json['OD'].toString(),
      badDebt: json['BD'].toString(),
      marginCOLL: json['COLL_MARGIN'].toString(),
      marginOD: json['OD_MARGIN'].toString(),
      marginBD: json['BD_MARGIN'].toString(),
    );
  }
}

class MonthlyRemainder {
  final String title;
  final String collection;
  final String overDue;
  final String badDebt;
  final String marginCOLL;
  final String marginOD;
  final String marginBD;

  MonthlyRemainder({
    required this.title,
    required this.collection,
    required this.overDue,
    required this.badDebt,
    required this.marginCOLL,
    required this.marginOD,
    required this.marginBD,
  });

  factory MonthlyRemainder.fromJSON(Map<String, dynamic> json) {
    return MonthlyRemainder(
      title: json['YYMM'],
      collection: json['COLL'].toString(),
      overDue: json['OD'].toString(),
      badDebt: json['BD'].toString(),
      marginCOLL: json['COLL_MARGIN'].toString(),
      marginOD: json['OD_MARGIN'].toString(),
      marginBD: json['BD_MARGIN'].toString(),
    );
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
        employeeID: json['EMPLOYEE_NAME'].toString(),
        cashIn: json['CASH_IN'].toString(),
        target: json['TARGET'].toString(),
        percentage: json['PERCENTAGE'].toString());
  }
}

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? _fullName = '';
  String? _companyName = '';
  String? _tokenAPI = '';
  String? periodeCollection = '';

  String urlAPI = 'http://10.137.26.67:8080/cct-api/api';
  bool _isLoading = false;
  bool isIncludeData = false;

  DailyRemainder? _dailyRemainder = DailyRemainder(
    title: '',
    collection: '',
    overDue: '',
    badDebt: '',
    marginCOLL: '',
    marginOD: '',
    marginBD: '',
  );
  MonthlyRemainder? _monthlyRemainder = MonthlyRemainder(
    title: '',
    collection: '',
    overDue: '',
    badDebt: '',
    marginCOLL: '',
    marginOD: '',
    marginBD: '',
  );

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
      String validAPI = await Apirepositories().checkAPIUrl();
      setState(() {
        urlAPI = validAPI;
      });
      await dailyRemainderLoad();
      await monthlyRemainderLoad();
      await monthlyRankingLoad();
    }
  }

  Future<void> refreshData() async {
    setState(() {
      _isLoading = true;
    });

    await dailyRemainderLoad();
    await monthlyRemainderLoad();
    await monthlyRankingLoad();
  }

  Future<void> getLoginSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Ambil nilai dari SharedPreferences
    String? fullName = prefs.getString('full_name');
    String? token = prefs.getString('token');
    String? companyName = prefs.getString('plant_name');
    // Update state dengan nilai yang diambil
    setState(() {
      _fullName = fullName;
      _tokenAPI = token;
      _companyName = companyName;
    });
  }

  Future<void> dailyRemainderLoad() async {
    String url = urlAPI +
        '/dashboard/daily-remainder?include=' +
        isIncludeData.toString();
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $_tokenAPI'},
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          _dailyRemainder = DailyRemainder.fromJSON(jsonResponse['data']);
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
    String url = urlAPI +
        '/dashboard/monthly-remainder?include=' +
        isIncludeData.toString();
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
    String url = urlAPI +
        '/dashboard/monthly-ranking?include=' +
        isIncludeData.toString();
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
          periodeCollection = jsonResponse["data"]["PERIODE"].toString();
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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        // decoration: BoxDecoration(
        //     image: DecorationImage(image: AssetImage('assets/images/bg-blue.jpg'), fit: BoxFit.cover),
        // ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : content(context),
      ),
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

  Widget rankingContainer(
      String textData, Color backgroundColor, Color textColor) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 30,
      color: backgroundColor,
      margin: EdgeInsets.all(1.0),
      child: Text(
        textData,
        style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'CjFont',
            fontSize: 12),
      ),
    );
  }

  Widget rankingColumn(String name, String target, String cashIn,
      String percentage, bool isHeader) {
    Color backgroundColor = isHeader ? Color(0xff006dcd) : Color(0xffedecec);
    Color backgroundColorName =
        isHeader ? Color(0xff006dcd) : Color(0xffffa63b);
    Color textColor = isHeader ? Colors.white : Colors.black;
    return Column(
      children: [
        rankingContainer(name, backgroundColorName, Colors.white),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: rankingContainer(target, backgroundColor, textColor),
            ),
            Expanded(
              child: rankingContainer(cashIn, backgroundColor, textColor),
            ),
            Expanded(
              child: rankingContainer(percentage, backgroundColor, textColor),
            ),
          ],
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
                        Text(_fullName ?? 'ANONYMOUS',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Cjfont',
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Text(_companyName ?? 'N/A',
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
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
                bottom: 5,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: 207,
                        child: CheckboxListTile(
                          title: Text(
                            "incl. internal",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Cjfont',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: isIncludeData,
                          onChanged: (newValue) {
                            setState(() {
                              isIncludeData = newValue ?? false;
                            });
                            refreshData();
                          },
                          controlAffinity: ListTileControlAffinity
                              .leading, //  <-- leading Checkbox
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "* in million",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Cjfont',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
                          Text("DAILY COLLECTION",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Cjfont',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Text(
                            _dailyRemainder!.title.toUpperCase(),
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Cjfont',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "* compare with previous day",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Cjfont',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                                    Text("[ ${_dailyRemainder!.marginCOLL} ]",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Cjfont',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text(_dailyRemainder!.collection,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 22,
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
                                    Text("[ ${_dailyRemainder!.marginOD} ]",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Cjfont',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text(_dailyRemainder!.overDue,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 22,
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
                                    Text("[ ${_dailyRemainder!.marginBD} ]",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Cjfont',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text(_dailyRemainder!.badDebt,
                                        style: TextStyle(
                                            fontSize: 22,
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
                          Text("MONTHLY COLLECTION",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Cjfont',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Text(_monthlyRemainder!.title.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Cjfont',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "* compare with previous month",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Cjfont',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                                    Text("[ ${_monthlyRemainder!.marginCOLL} ]",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Cjfont',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text(_monthlyRemainder!.collection,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 22,
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
                                    Text("[ ${_monthlyRemainder!.marginOD} ]",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Cjfont',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text(_monthlyRemainder!.overDue,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 22,
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
                                    Text("[ ${_monthlyRemainder!.marginBD} ]",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Cjfont',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text(_monthlyRemainder!.badDebt,
                                        style: TextStyle(
                                            fontSize: 22,
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
                              Text(
                                "TOP 5 COLLECTION",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Cjfont',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                "for RUNNING CUSTOMER",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Cjfont',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                periodeCollection.toString().toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Cjfont',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        rankingColumn('NAME', 'TARGET', 'CASH IN', '%', true),
                        rankingColumn(
                          _runningTOP[0].employeeID,
                          _runningTOP[0].target,
                          _runningTOP[0].cashIn,
                          _runningTOP[0].percentage,
                          false,
                        ),
                        rankingColumn(
                          _runningTOP[1].employeeID,
                          _runningTOP[1].target,
                          _runningTOP[1].cashIn,
                          _runningTOP[1].percentage,
                          false,
                        ),
                        rankingColumn(
                          _runningTOP[2].employeeID,
                          _runningTOP[2].target,
                          _runningTOP[2].cashIn,
                          _runningTOP[2].percentage,
                          false,
                        ),
                        rankingColumn(
                          _runningTOP[3].employeeID,
                          _runningTOP[3].target,
                          _runningTOP[3].cashIn,
                          _runningTOP[3].percentage,
                          false,
                        ),
                        rankingColumn(
                          _runningTOP[4].employeeID,
                          _runningTOP[4].target,
                          _runningTOP[4].cashIn,
                          _runningTOP[4].percentage,
                          false,
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
                            Text(
                              "BOTTOM 5 COLLECTION",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Cjfont',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              "for RUNNING CUSTOMER",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Cjfont',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              periodeCollection.toString().toUpperCase(),
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Cjfont',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        rankingColumn('NAME', 'TARGET', 'CASH IN', '%', true),
                        rankingColumn(
                          _runningBOTTOM[0].employeeID,
                          _runningBOTTOM[0].target,
                          _runningBOTTOM[0].cashIn,
                          _runningBOTTOM[0].percentage,
                          false,
                        ),
                        rankingColumn(
                          _runningBOTTOM[1].employeeID,
                          _runningBOTTOM[1].target,
                          _runningBOTTOM[1].cashIn,
                          _runningBOTTOM[1].percentage,
                          false,
                        ),
                        rankingColumn(
                          _runningBOTTOM[2].employeeID,
                          _runningBOTTOM[2].target,
                          _runningBOTTOM[2].cashIn,
                          _runningBOTTOM[2].percentage,
                          false,
                        ),
                        rankingColumn(
                          _runningBOTTOM[3].employeeID,
                          _runningBOTTOM[3].target,
                          _runningBOTTOM[3].cashIn,
                          _runningBOTTOM[3].percentage,
                          false,
                        ),
                        rankingColumn(
                          _runningBOTTOM[4].employeeID,
                          _runningBOTTOM[4].target,
                          _runningBOTTOM[4].cashIn,
                          _runningBOTTOM[4].percentage,
                          false,
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
                              Text(
                                "TOP 5 COLLECTION",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Cjfont',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                "for STOP CUSTOMER",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Cjfont',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                periodeCollection.toString().toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Cjfont',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        rankingColumn('NAME', 'TARGET', 'CASH IN', '%', true),
                        rankingColumn(
                          _stopTOP[0].employeeID,
                          _stopTOP[0].target,
                          _stopTOP[0].cashIn,
                          _stopTOP[0].percentage,
                          false,
                        ),
                        rankingColumn(
                          _stopTOP[1].employeeID,
                          _stopTOP[1].target,
                          _stopTOP[1].cashIn,
                          _stopTOP[1].percentage,
                          false,
                        ),
                        rankingColumn(
                          _stopTOP[2].employeeID,
                          _stopTOP[2].target,
                          _stopTOP[2].cashIn,
                          _stopTOP[2].percentage,
                          false,
                        ),
                        rankingColumn(
                          _stopTOP[3].employeeID,
                          _stopTOP[3].target,
                          _stopTOP[3].cashIn,
                          _stopTOP[3].percentage,
                          false,
                        ),
                        rankingColumn(
                          _stopTOP[4].employeeID,
                          _stopTOP[4].target,
                          _stopTOP[4].cashIn,
                          _stopTOP[4].percentage,
                          false,
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
                            Text(
                              "BOTTOM 5 COLLECTION",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Cjfont',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              "for STOP CUSTOMER",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Cjfont',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              periodeCollection.toString().toUpperCase(),
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Cjfont',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        rankingColumn('NAME', 'TARGET', 'CASH IN', '%', true),
                        rankingColumn(
                          _stopBOTTOM[0].employeeID,
                          _stopBOTTOM[0].target,
                          _stopBOTTOM[0].cashIn,
                          _stopBOTTOM[0].percentage,
                          false,
                        ),
                        rankingColumn(
                          _stopBOTTOM[1].employeeID,
                          _stopBOTTOM[1].target,
                          _stopBOTTOM[1].cashIn,
                          _stopBOTTOM[1].percentage,
                          false,
                        ),
                        rankingColumn(
                          _stopBOTTOM[2].employeeID,
                          _stopBOTTOM[2].target,
                          _stopBOTTOM[2].cashIn,
                          _stopBOTTOM[2].percentage,
                          false,
                        ),
                        rankingColumn(
                          _stopBOTTOM[3].employeeID,
                          _stopBOTTOM[3].target,
                          _stopBOTTOM[3].cashIn,
                          _stopBOTTOM[3].percentage,
                          false,
                        ),
                        rankingColumn(
                          _stopBOTTOM[4].employeeID,
                          _stopBOTTOM[4].target,
                          _stopBOTTOM[4].cashIn,
                          _stopBOTTOM[4].percentage,
                          false,
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
