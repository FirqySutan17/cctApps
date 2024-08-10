import 'dart:async';
import 'package:cct/models/visit.dart';
import 'package:cct/repositories/apirepositories.dart';
import 'package:cct/repositories/plantrepositories.dart';
import 'package:cct/visitreportdetail.dart';
import 'package:flutter/material.dart';

import 'package:cct/models/plant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class VisitReport extends StatefulWidget {
  const VisitReport({super.key});

  @override
  State<VisitReport> createState() => _VisitReportState();
}

class _VisitReportState extends State<VisitReport> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String? plantValue;

  final _scrollController = ScrollController();
  bool hasMore = true;
  int _currentPage = 1;
  List<Visit> listData = [];

  // String urlAPI = 'http://103.209.6.32:8080/cct-api/api';
  String urlAPI = 'http://10.137.26.67:8080/cct-api/api';
  String? _tokenAPI = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initProcess();
  }

  Future<void> _initProcess() async {
    setState(() {
      plantValue = '*';
      _isLoading = true;
      _startDateController.text = '2024-07-01';
      _endDateController.text = '2024-08-06';
    });

    await getLoginSession();
    if (_tokenAPI != null) {
      String validAPI = await Apirepositories().checkAPIUrl();
      setState(() {
        urlAPI = validAPI;
      });
      _fetchData();
    }
  }

  Future<void> getLoginSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Ambil nilai dari SharedPreferences
    String? token = prefs.getString('token');
    // Update state dengan nilai yang diambil
    setState(() {
      _tokenAPI = token;
    });
  }

  Future<void> _fetchData() async {
    String url = urlAPI + '/report/visit';
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $_tokenAPI'},
        body: {
          'start_date': _startDateController.text,
          'end_date': _endDateController.text,
          'plant': plantValue,
          'pagination': _currentPage.toString()
        },
      );
      print('start date : ' + _startDateController.text.toString());
      print('end date : ' + _endDateController.text.toString());
      print('plant : ' + plantValue.toString());
      print('current page : ' + _currentPage.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        setState(() {
          if (!jsonResponse.containsKey('data')) {
            hasMore = false;
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text('No more data loaded'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            List<dynamic> responseData = jsonResponse['data'];
            if (responseData.length > 0) {
              List<Visit> newList = responseData
                  .map((itemJson) => Visit.fromJSON(itemJson))
                  .toList();
              print('new list length' + newList.length.toString());
              listData.addAll(newList);
              if (newList.length < 10) {
                hasMore = false;
              }
              _currentPage++;
            }
          }
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

  Future<void> submitFilter() async {
    setState(() {
      _isLoading = true;
      _currentPage = 1;
      hasMore = true;
      listData = [];
    });
    _fetchData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMore() {
    setState(() {
      _currentPage++;
    });
    _fetchData();
  }

  Widget itemData(Visit visit) {
    return Container(
      width: double.infinity,
      // height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.only(
        //   topRight: Radius.elliptical(35, 35),
        //   topLeft: Radius.elliptical(35, 35),
        // ),
      ),

      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VisitReportDetail(visitingNo: visit.visitingNo),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(
                  top: 0.0, bottom: 5.0, right: 10.0, left: 10.0),
              width: double.infinity,
              padding: const EdgeInsets.only(
                  top: 15.0, bottom: 15.0, right: 15.0, left: 15.0),
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
                  bottom: BorderSide(color: Color(0xffedecec), width: 2),
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
                        Text(visit.visitingDate,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontFamily: 'Cjfont',
                              color: Colors.black,
                            )),
                        Text(visit.visitingNo,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Cjfont',
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        Text(visit.companyName,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Cjfont',
                              color: Colors.black,
                            )),
                        Text("${visit.customerCode} -${visit.customerName}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Cjfont',
                              color: Colors.black,
                            )),
                        Text(visit.drafterName,
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
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> formFilterData(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              scrollable: true,
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _startDateController,
                        onTap: () async {
                          // Below line stops keyboard from appearing
                          FocusScope.of(context).requestFocus(new FocusNode());

                          // Show Date Picker Here
                          await _selectDate(context);
                          List splited_date =
                              selectedDate.toString().split(" ");
                          String startDate = splited_date[0];
                          _startDateController.text = startDate;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Start Date'),
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Cjfont',
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _endDateController,
                        onTap: () async {
                          // Below line stops keyboard from appearing
                          FocusScope.of(context).requestFocus(new FocusNode());

                          // Show Date Picker Here
                          await _selectDate(context);
                          List splited_date =
                              selectedDate.toString().split(" ");
                          String startDate = splited_date[0];
                          _endDateController.text = startDate;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('End Date'),
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Cjfont',
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      FutureBuilder<List<Plant>>(
                        future: PlantRepositories().getDataPlant(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Plant>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return DropdownButtonFormField<String>(
                              value: plantValue,
                              decoration: InputDecoration(
                                labelText: 'Plant',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Cjfont',
                                ),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  plantValue = newValue;
                                });
                              },
                              hint: Text('Choose Plant'),
                              items: snapshot.data!
                                  .map<DropdownMenuItem<String>>((Plant item) {
                                return DropdownMenuItem<String>(
                                  value: item.code,
                                  child: Text(item.codeName),
                                );
                              }).toList(),
                            );
                          }
                        },
                      ),
                    ],
                  )),
              title: Text(
                'FILTER DATA',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'CjFont',
                    fontSize: 15),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pop();
                      submitFilter();
                    }
                  },
                  child: Text('SUBMIT',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'CjFont',
                          fontSize: 14)),
                ),
              ],
            );
          });
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : content(context),
    );
  }

  Widget content(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg-blue.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 20.0, right: 15.0, left: 15.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "VISIT REPORT",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Cjfont',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xffff9304),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed('/menu');
                          },
                          child: Text(
                            "MENU",
                            style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
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
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffff9304),
                    ),
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 20.0, left: 20.0),
                    child: TextButton(
                      onPressed: () async {
                        await formFilterData(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "FILTER",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Cjfont',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image.asset(
                            'assets/images/icon-filter.png',
                            width: 35,
                            height: 35,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(height: 5),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == listData.length) {
                  if (hasMore) {
                    _fetchData();
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return SizedBox.shrink();
                  }
                }
                return itemData(listData[index]);
              },
              childCount: listData.length + 1,
            ),
          ),
        ],
      ),
    );
  }
}
