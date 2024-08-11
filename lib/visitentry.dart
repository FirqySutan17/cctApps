import 'package:cct/repositories/apirepositories.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VisitEntry extends StatefulWidget {
  VisitEntry({super.key});

  @override
  State<VisitEntry> createState() => _VisitEntryState();
}

class _VisitEntryState extends State<VisitEntry> {
  late WebViewController controller;
  bool _isLoading = false;
  String? _tokenAPI = '';
  String? _employeeID = '';

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
      String validAPI = await Apirepositories().checkWebViewUrl();
      String url = validAPI + '/visit/entry_mobile/' + _employeeID.toString();
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(
          Uri.parse(url),
        );
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getLoginSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Ambil nilai dari SharedPreferences
    String? token = prefs.getString('token');
    String? employeeId = prefs.getString('employee_id');
    // Update state dengan nilai yang diambil
    setState(() {
      _tokenAPI = token;
      _employeeID = employeeId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('VISIT ENTRY'),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : WebViewWidget(
                controller: controller,
              ),
      ),
    );
  }
}
