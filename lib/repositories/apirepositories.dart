import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Apirepositories {
  String checkUrl = 'https://cjfnc.id/checkurl/';
  Future<String> checkAPIUrl() async {
    String validURL = '';
    try {
      print(checkUrl);
      var response = await http.get(Uri.parse(checkUrl));
      print(response.body);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        validURL = jsonResponse['URL'].toString() + '/cct-api/api';
      }
    } on http.ClientException catch (e) {
      // Handle socket exception - connection timeout
      print('SocketException: ${e.message}');
      print('URL:\n${e.uri}');
    } catch (e) {
      print('Error: $e');
    }

    return validURL;
  }
}
