import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class VisitEntry extends StatefulWidget {
  const VisitEntry({Key? key}) : super(key: key);

  @override
  VisitEntryState createState() => VisitEntryState();
}

class VisitEntryState extends State<VisitEntry> {
  int _activeCurrentStep = 0;

  TextEditingController region =
      TextEditingController(text: 'Kalimantan Selatan');
  TextEditingController site = TextEditingController(text: '3220');
  TextEditingController cgcustomer =
      TextEditingController(text: '1114051 - AGUNG MITRA SEJAHTERA. CV');
  TextEditingController jenis = TextEditingController(text: 'GSM(POULTRY)');
  TextEditingController owner = TextEditingController(text: 'ARIF BUDIMAN');
  TextEditingController nokontak = TextEditingController(text: '-');
  TextEditingController alamat =
      TextEditingController(text: 'JL.KYAI MAKSUM KM 01 DUSUN METESEH');
  TextEditingController stopar = TextEditingController();
  TextEditingController currentar = TextEditingController();
  TextEditingController collateralamount = TextEditingController();
  TextEditingController reasonopen = TextEditingController();
  TextEditingController reasonclose = TextEditingController();

  TextEditingController _visitDateController = TextEditingController();
  TextEditingController _openDateController = TextEditingController();
  TextEditingController _closeDateController = TextEditingController();

  static const locale = 'id';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(locale).format(int.parse(s));
  String convertToIdr(dynamic s, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(s);
  }

  DateTime selectedDate = DateTime.now();

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

  List<String> plant = <String>[
    'CJFNC Jakarta',
    'CJFNC Serang',
    'CJFNC Lampung',
    'CJFNC Jombang',
    'CJFNC Semarang',
    'CJFNC Kalimantan',
    'Super Unggas Jaya'
  ];
  List<String> customer = <String>[
    'Customer Jakarta',
    'Customer Serang',
    'Customer Lampung',
    'Customer Jombang',
    'Customer Semarang',
    'Customer Kalimantan',
    'Customer Super Unggas Jaya'
  ];
  List<String> tipestop = <String>[
    'Sukarela',
    'Dipaksa',
  ];
  List<String> tipecollection = <String>[
    'Cicilan',
    'Transaksi Ulang',
    'Jalur Hukum',
    'Take Over Asset',
    'Ambil Jaminan',
    'Sulit Collection',
    'SHM',
  ];
  List<String> opents = <String>[
    'Cucup sisulap',
    'Akung Jakun',
    'Ichsan Fatturahman',
    'Firqy Sutan',
  ];
  List<String> openasm = <String>[
    'Cucup sisulap',
    'Akung Jakun',
    'Ichsan Fatturahman',
    'Firqy Sutan',
  ];
  List<String> opengsm = <String>[
    'Cucup sisulap',
    'Akung Jakun',
    'Ichsan Fatturahman',
    'Firqy Sutan',
  ];
  List<String> opencct = <String>[
    'Cucup sisulap',
    'Akung Jakun',
    'Ichsan Fatturahman',
    'Firqy Sutan',
  ];
  List<String> closets = <String>[
    'Cucup sisulap',
    'Akung Jakun',
    'Ichsan Fatturahman',
    'Firqy Sutan',
  ];
  List<String> closeasm = <String>[
    'Cucup sisulap',
    'Akung Jakun',
    'Ichsan Fatturahman',
    'Firqy Sutan',
  ];
  List<String> closegsm = <String>[
    'Cucup sisulap',
    'Akung Jakun',
    'Ichsan Fatturahman',
    'Firqy Sutan',
  ];
  List<String> closecct = <String>[
    'Cucup sisulap',
    'Akung Jakun',
    'Ichsan Fatturahman',
    'Firqy Sutan',
  ];
  String? plantValue;
  String? customerValue;
  String? tipestopValue;
  String? tipecollectionValue;
  String? opentsValue;
  String? openasmValue;
  String? opengsmValue;
  String? opencctValue;
  String? closetsValue;
  String? closeasmValue;
  String? closegsmValue;
  String? closecctValue;

  List<Step> stepList() => [
        Step(
          state:
              _activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeCurrentStep >= 0,
          title: const Text('1',
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Cjfont',
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("1. INFORMASI CUSTOMER",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Cjfont',
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _visitDateController,
                  onTap: () async {
                    // Below line stops keyboard from appearing
                    FocusScope.of(context).requestFocus(new FocusNode());

                    // Show Date Picker Here
                    await _selectDate(context);
                    List splited_date = selectedDate.toString().split(" ");
                    String visitDate = splited_date[0];
                    _visitDateController.text = visitDate;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('VISIT DATE'),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Cjfont',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                DropdownButtonFormField<String>(
                  value: plantValue,
                  decoration: InputDecoration(
                    labelText: 'PLANT',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Cjfont',
                    ),
                    border: OutlineInputBorder(),
                  ),
                  icon: Icon(Icons.keyboard_arrow_down),
                  hint: Text('Select Plant'),
                  onChanged: (String? newValue) {
                    setState(() {
                      plantValue = newValue;
                    });
                  },
                  validator: (String? value) {
                    if (value == null) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                  items: plant.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 14,
                ),
                DropdownButtonFormField<String>(
                  value: customerValue,
                  decoration: InputDecoration(
                    labelText: 'CUSTOMER',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Cjfont',
                    ),
                    border: OutlineInputBorder(),
                  ),
                  icon: Icon(Icons.keyboard_arrow_down),
                  hint: Text('Select Customer'),
                  onChanged: (String? newValue) {
                    setState(() {
                      customerValue = newValue;
                    });
                  },
                  validator: (String? value) {
                    if (value == null) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                  items: customer.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 14,
                ),
                TextField(
                  controller: region,
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'REGION',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Cjfont',
                    ),
                    filled: true,
                    fillColor: Color(0xffeeeeee),
                  ),
                ),
                const SizedBox(
                  height: 14,
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
                    ),
                    filled: true,
                    fillColor: Color(0xffeeeeee),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                TextField(
                  controller: cgcustomer,
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'GROUP CUSTOMER',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Cjfont',
                    ),
                    filled: true,
                    fillColor: Color(0xffeeeeee),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                TextField(
                  controller: jenis,
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'JENIS',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Cjfont',
                    ),
                    filled: true,
                    fillColor: Color(0xffeeeeee),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                TextField(
                  controller: owner,
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'OWNER',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Cjfont',
                    ),
                    filled: true,
                    fillColor: Color(0xffeeeeee),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                TextField(
                  controller: nokontak,
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'NO KONTAK',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Cjfont',
                    ),
                    filled: true,
                    fillColor: Color(0xffeeeeee),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                TextField(
                  controller: alamat,
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ALAMAT',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Cjfont',
                    ),
                    filled: true,
                    fillColor: Color(0xffeeeeee),
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
            state: _activeCurrentStep <= 1
                ? StepState.editing
                : StepState.complete,
            isActive: _activeCurrentStep >= 1,
            title: const Text('2',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Cjfont',
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("2. INFORMASI TRANSAKSI",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Cjfont',
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _openDateController,
                    onTap: () async {
                      // Below line stops keyboard from appearing
                      FocusScope.of(context).requestFocus(new FocusNode());

                      // Show Date Picker Here
                      await _selectDate(context);
                      List splited_date = selectedDate.toString().split(" ");
                      String openDate = splited_date[0];
                      _openDateController.text = openDate;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('OPEN DATE'),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cjfont',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    controller: _closeDateController,
                    onTap: () async {
                      // Below line stops keyboard from appearing
                      FocusScope.of(context).requestFocus(new FocusNode());

                      // Show Date Picker Here
                      await _selectDate(context);
                      List splited_date = selectedDate.toString().split(" ");
                      String closeDate = splited_date[0];
                      _closeDateController.text = closeDate;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('CLOSE DATE'),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cjfont',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  DropdownButtonFormField<String>(
                    value: tipestopValue,
                    decoration: InputDecoration(
                      labelText: 'TIPE STOP',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cjfont',
                      ),
                      border: OutlineInputBorder(),
                    ),
                    icon: Icon(Icons.keyboard_arrow_down),
                    hint: Text('Select Tipe Stop'),
                    onChanged: (String? newValue) {
                      setState(() {
                        tipestopValue = newValue;
                      });
                    },
                    validator: (String? value) {
                      if (value == null) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                    items:
                        tipestop.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextField(
                    controller: stopar,
                    decoration: const InputDecoration(
                      hintText: '0',
                      border: OutlineInputBorder(),
                      labelText: 'STOP AR',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    inputFormatters: [
                      CurrencyTextInputFormatter.currency(
                        locale: 'id',
                        decimalDigits: 0,
                        symbol: 'Rp ',
                      ),
                    ],
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextField(
                    controller: currentar,
                    decoration: const InputDecoration(
                      hintText: '0',
                      border: OutlineInputBorder(),
                      labelText: 'AR SAAT INI',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    inputFormatters: [
                      CurrencyTextInputFormatter.currency(
                        locale: 'id',
                        decimalDigits: 0,
                        symbol: 'Rp ',
                      ),
                    ],
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextField(
                    controller: collateralamount,
                    decoration: const InputDecoration(
                      hintText: '0',
                      border: OutlineInputBorder(),
                      labelText: 'COLLATERAL AMOUNT',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    inputFormatters: [
                      CurrencyTextInputFormatter.currency(
                        locale: 'id',
                        decimalDigits: 0,
                        symbol: 'Rp ',
                      ),
                    ],
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  DropdownButtonFormField<String>(
                    value: tipecollectionValue,
                    decoration: InputDecoration(
                      labelText: 'TIPE COLLECTION',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cjfont',
                      ),
                      border: OutlineInputBorder(),
                    ),
                    icon: Icon(Icons.keyboard_arrow_down),
                    hint: Text('Select Tipe Collection'),
                    onChanged: (String? newValue) {
                      setState(() {
                        tipecollectionValue = newValue;
                      });
                    },
                    validator: (String? value) {
                      if (value == null) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                    items: tipecollection
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.grey),
                    )),
                    child: Text("PENANGGUNG JAWAB KETIKA OPEN",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Cjfont',
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DropdownButtonFormField<String>(
                    value: opentsValue,
                    decoration: InputDecoration(
                      labelText: 'TS',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cjfont',
                      ),
                      border: OutlineInputBorder(),
                    ),
                    icon: Icon(Icons.keyboard_arrow_down),
                    hint: Text('Select TS'),
                    onChanged: (String? newValue) {
                      setState(() {
                        opentsValue = newValue;
                      });
                    },
                    validator: (String? value) {
                      if (value == null) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                    items: opents.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  DropdownButtonFormField<String>(
                    value: opengsmValue,
                    decoration: InputDecoration(
                      labelText: 'GSM',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cjfont',
                      ),
                      border: OutlineInputBorder(),
                    ),
                    icon: Icon(Icons.keyboard_arrow_down),
                    hint: Text('Select GSM'),
                    onChanged: (String? newValue) {
                      setState(() {
                        opengsmValue = newValue;
                      });
                    },
                    validator: (String? value) {
                      if (value == null) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                    items:
                        opengsm.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  DropdownButtonFormField<String>(
                    value: openasmValue,
                    decoration: InputDecoration(
                      labelText: 'ASM',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cjfont',
                      ),
                      border: OutlineInputBorder(),
                    ),
                    icon: Icon(Icons.keyboard_arrow_down),
                    hint: Text('Select ASM'),
                    onChanged: (String? newValue) {
                      setState(() {
                        openasmValue = newValue;
                      });
                    },
                    validator: (String? value) {
                      if (value == null) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                    items:
                        openasm.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  DropdownButtonFormField<String>(
                    value: opencctValue,
                    decoration: InputDecoration(
                      labelText: 'CCT',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cjfont',
                      ),
                      border: OutlineInputBorder(),
                    ),
                    icon: Icon(Icons.keyboard_arrow_down),
                    hint: Text('Select CCT'),
                    onChanged: (String? newValue) {
                      setState(() {
                        opencctValue = newValue;
                      });
                    },
                    validator: (String? value) {
                      if (value == null) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                    items:
                        opencct.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.grey),
                    )),
                    child: Text("PENANGGUNG JAWAB KETIKA STOP",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Cjfont',
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DropdownButtonFormField<String>(
                    value: closetsValue,
                    decoration: InputDecoration(
                      labelText: 'TS',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cjfont',
                      ),
                      border: OutlineInputBorder(),
                    ),
                    icon: Icon(Icons.keyboard_arrow_down),
                    hint: Text('Select TS'),
                    onChanged: (String? newValue) {
                      setState(() {
                        closetsValue = newValue;
                      });
                    },
                    validator: (String? value) {
                      if (value == null) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                    items:
                        closets.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  DropdownButtonFormField<String>(
                    value: closegsmValue,
                    decoration: InputDecoration(
                      labelText: 'GSM',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cjfont',
                      ),
                      border: OutlineInputBorder(),
                    ),
                    icon: Icon(Icons.keyboard_arrow_down),
                    hint: Text('Select GSM'),
                    onChanged: (String? newValue) {
                      setState(() {
                        closegsmValue = newValue;
                      });
                    },
                    validator: (String? value) {
                      if (value == null) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                    items:
                        closegsm.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  DropdownButtonFormField<String>(
                    value: closeasmValue,
                    decoration: InputDecoration(
                      labelText: 'ASM',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cjfont',
                      ),
                      border: OutlineInputBorder(),
                    ),
                    icon: Icon(Icons.keyboard_arrow_down),
                    hint: Text('Select ASM'),
                    onChanged: (String? newValue) {
                      setState(() {
                        closeasmValue = newValue;
                      });
                    },
                    validator: (String? value) {
                      if (value == null) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                    items:
                        closeasm.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  DropdownButtonFormField<String>(
                    value: closecctValue,
                    decoration: InputDecoration(
                      labelText: 'CCT',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cjfont',
                      ),
                      border: OutlineInputBorder(),
                    ),
                    icon: Icon(Icons.keyboard_arrow_down),
                    hint: Text('Select CCT'),
                    onChanged: (String? newValue) {
                      setState(() {
                        closecctValue = newValue;
                      });
                    },
                    validator: (String? value) {
                      if (value == null) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                    items:
                        closecct.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextField(
                    controller: reasonopen,
                    minLines:
                        4, // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,

                    decoration: const InputDecoration(
                      hintText: 'Tulis alasan disini..',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                      labelText: 'Alasan Stop',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cjfont',
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextField(
                    controller: reasonclose,
                    minLines:
                        4, // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,

                    decoration: const InputDecoration(
                      hintText: 'Tulis alasan disini..',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                      labelText: 'Status biaya belum diselesaikan',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cjfont',
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            )),
        Step(
            state: StepState.complete,
            isActive: _activeCurrentStep >= 2,
            title: const Text('FINAL',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Cjfont',
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            content: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Name: ${region.text}'),
                Text('Site: ${site.text}'),
                Text('CGCustomer: ${cgcustomer.text}'),
                Text('Jenis : ${jenis.text}'),
                Text('Owner : ${owner.text}'),
                Text('No. Kontak : ${nokontak.text}'),
                Text('Alamat : ${alamat.text}'),
              ],
            )))
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('VISIT ENTRY',
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'Cjfont',
                color: Colors.black,
                fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Theme(
          data: ThemeData(
            canvasColor: Colors.white,
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Color(0xffff9304),
                  // background: Colors.red,
                  // secondary: Colors.green,
                ),
          ),
          child: Stepper(
            controlsBuilder: (context, details) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red,
                  ),
                  width: 165,
                  height: 45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        // style: TextButton.styleFrom(
                        // backgroundColor: Color(0xff007dc3)),
                        onPressed: details.onStepCancel,
                        child: Text(
                          "Kembali",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xff007dc3),
                  ),
                  width: 165,
                  height: 45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        // style: TextButton.styleFrom(
                        // backgroundColor: Color(0xff007dc3)),
                        onPressed: details.onStepContinue,
                        child: Text(
                          "Selanjutnya",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            type: StepperType.horizontal,
            currentStep: _activeCurrentStep,
            steps: stepList(),
            onStepContinue: () {
              if (_activeCurrentStep < (stepList().length - 1)) {
                setState(() {
                  _activeCurrentStep += 1;
                });
              }
            },
            onStepCancel: () {
              if (_activeCurrentStep == 0) {
                return;
              }

              setState(() {
                _activeCurrentStep -= 1;
              });
            },
            onStepTapped: (int index) {
              setState(() {
                _activeCurrentStep = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
