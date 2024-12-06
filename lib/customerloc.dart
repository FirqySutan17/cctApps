import 'dart:io';

import 'package:cct/repositories/apirepositories.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart'
    as webview_flutter_android;
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:geolocator/geolocator.dart';

class CustomerLocation extends StatefulWidget {
  CustomerLocation({super.key});

  @override
  State<CustomerLocation> createState() => _CustomerLocationState();
}

class _CustomerLocationState extends State<CustomerLocation> {
  late WebViewController controller;
  bool _isLoading = false;
  // bool serviceEnabled;
  // LocationPermission permission;
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

    // Periksa izin lokasi
    bool serviceEnabled;
    LocationPermission permission;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are disabled.");
      setState(() {
        _isLoading = false;
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permissions are denied.");
        setState(() {
          _isLoading = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permissions are permanently denied.");
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Atur pengaturan lokasi
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, // Akurasi tinggi
      distanceFilter: 10, // Minimal perubahan jarak (dalam meter) untuk update
    );

    // Ambil posisi pengguna
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );
    double latitude = position.latitude;
    double longitude = position.longitude;
    String? employeeId = prefs.getString('employee_id');

    // Lakukan proses lainnya
    await getLoginSession();

    if (_tokenAPI != null) {
      String validAPI = await Apirepositories().checkWebViewUrl();
      String location = validAPI +
          'location?token=${latitude}split${longitude}&page=ULMOBILE_${employeeId.toString()}';
      String url = validAPI +
          '/customer/update_customer_location/' +
          _employeeID.toString();
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(
          Uri.parse(url),
        );
      initFilePicker();
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Future<void> _initProcess() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   await getLoginSession();

  //   if (_tokenAPI != null) {
  //     String validAPI = await Apirepositories().checkWebViewUrl();
  //     String location = validAPI +
  //         'location?token=${latitude}split${longitude}&page=ULMOBILE_${EMPLOYEE_ID}';
  //     String url = validAPI +
  //         '/customer/update_customer_location/' +
  //         _employeeID.toString();
  //     controller = WebViewController()
  //       ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //       ..loadRequest(
  //         Uri.parse(url),
  //       );
  //     initFilePicker();
  //   }

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  initFilePicker() async {
    if (Platform.isAndroid) {
      final androidController = (controller.platform
          as webview_flutter_android.AndroidWebViewController);
      await androidController.setOnShowFileSelector(_androidFilePicker);
    }
  }

  Future<List<String>> _androidFilePicker(
      webview_flutter_android.FileSelectorParams params) async {
    if (params.acceptTypes.any((type) => type == 'image/*')) {
      final picker = image_picker.ImagePicker();
      final photo =
          await picker.pickImage(source: image_picker.ImageSource.camera);

      if (photo == null) {
        return [];
      }
      return [Uri.file(photo.path).toString()];
    } else {
      try {
        if (params.mode ==
            webview_flutter_android.FileSelectorMode.openMultiple) {
          final attachments =
              await FilePicker.platform.pickFiles(allowMultiple: true);
          if (attachments == null) return [];

          return attachments.files
              .where((element) => element.path != null)
              .map((e) => File(e.path!).uri.toString())
              .toList();
        } else {
          final attachment = await FilePicker.platform.pickFiles();
          if (attachment == null) return [];
          File file = File(attachment.files.single.path!);
          return [file.uri.toString()];
        }
      } catch (e) {
        return [];
      }
    }
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
          title: Text('CUSTOMER LOCATION'),
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
