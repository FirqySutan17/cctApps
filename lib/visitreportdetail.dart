import 'package:cct/repositories/apirepositories.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VisitReportDetail extends StatefulWidget {
  final String visitingNo;

  VisitReportDetail({Key? key, required this.visitingNo}) : super(key: key);

  @override
  State<VisitReportDetail> createState() => _VisitReportDetailState();
}

class _VisitReportDetailState extends State<VisitReportDetail> {
  late WebViewController controller;
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
    String validAPI = await Apirepositories().checkWebViewUrl();
    String url = validAPI + '/visit/detail_mobile/' + widget.visitingNo;
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(url),
      );
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('VISIT DETAIL'),
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
