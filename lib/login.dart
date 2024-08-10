import 'dart:async';
import 'package:cct/repositories/apirepositories.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool passwordVisible = false;
  bool _isLoading = false;

  List<String> site = <String>[
    'PT. CJ FEED & CARE INDONESIA',
    'PT. SUPER UNGGAS JAYA',
  ];

  String? siteValue;

  Future<void> loginAction() async {
    setState(() {
      _isLoading = true;
    });

    String urlAPI = 'http://103.209.6.32:8080/cct-api/api/login';
    try {
      String validAPI = await Apirepositories().checkAPIUrl();
      urlAPI = validAPI + '/cct-api/api/login';
      var response = await http.post(
        Uri.parse(urlAPI),
        body: {
          'username': _usernameController.text,
          'password': _passwordController.text,
          'company': 'FEED',
          'apiversion': '0.1'
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        String token =
            jsonResponse["data"]["token"]; // Misalnya API mengembalikan token

        // Simpan token atau status login di SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString(
            'full_name', jsonResponse["data"]["user"]["FULL_NAME"]);

        // Redirect ke halaman beranda atau lakukan sesuatu setelah login berhasil
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        // Handle jika login gagal
        // Misalnya menampilkan pesan error
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Gagal'),
              content: Text('Username atau Password salah.'),
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
      }
    } on http.ClientException catch (e) {
      // Handle socket exception - connection timeout
      print('SocketException: ${e.message}');
      print('URL:\n${e.uri}');
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : content(),
    );
  }

  Widget content() {
    double heightForStack = (MediaQuery.of(context).size.height - 350);
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
                          width: 170.0, height: 170.0)),
                ),
              ),
            ),
            Container(
              // height: heightForStack,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
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
                      DropdownButtonFormField<String>(
                        value: siteValue,
                        decoration: InputDecoration(
                          labelText: 'Site',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Cjfont',
                          ),
                          border: OutlineInputBorder(),
                        ),
                        icon: Icon(Icons.keyboard_arrow_down),
                        hint: Text('Select site'),
                        onChanged: (String? newValue) {
                          setState(() {
                            siteValue = newValue;
                          });
                        },
                        validator: (String? value) {
                          if (value == null) {
                            return 'Please select an option';
                          }
                          return null;
                        },
                        items:
                            site.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
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
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Employee ID",
                            labelText: "Employee ID",
                            alignLabelWithHint: false,
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          controller: _usernameController,
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
                          controller: _passwordController,
                        ),
                      ),
                      SizedBox(
                        height: 40,
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
                            loginAction();
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
            SizedBox(
              height: 30,
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
