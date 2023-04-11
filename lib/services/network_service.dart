import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkService {
  String url;
  NetworkService({
    required this.url,
  });
  Future<dynamic> getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }
}
