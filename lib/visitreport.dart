import 'dart:async';
import 'package:cct/repositories/plantrepositories.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:cct/models/plant.dart';

class VisitReport extends StatefulWidget {
  @override
  State<VisitReport> createState() => _VisitReportState();
}

class _VisitReportState extends State<VisitReport> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String? plantValue;

  @override
  void initState() {
    super.initState();
    setState(() {
      plantValue = '*';
    });
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
                        ),
                      ),
                      SizedBox(height: 10),
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
                        ),
                      ),
                      SizedBox(height: 10),
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
              title: Text('Filter Data'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Submit Filter'),
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
                      onPressed: () async {
                        await formFilterData(context);
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
                      ),
                    ),
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
