import 'package:firebase_project/core/constant/const.dart';
import 'package:firebase_project/model/api/api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ApiServices {
  static Future<Stream<Welcome>> getUserList() async {
    const String url = kBaseUrl;

    final client = http.Client();
    final streamedRest = await client.send(
      http.Request('get', Uri.parse(url)),
    );

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .expand((data) => (data as List))
        .map((data) => Welcome.fromJson(data));
  }
}
