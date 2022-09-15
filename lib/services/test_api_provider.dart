import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testing/models/test.dart';

class TestProvider {
  Future<List<Test>> getData(link) async {
    final uri = Uri.parse(link);
    final headers = {'accept': 'application/json'};
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> testJson = json.decode(response.body)['data'];
      return testJson.map((json) => Test.fromJson(json)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<bool> postData(tests) async {
    final uri = Uri.parse('https://flutter.webspark.dev/flutter/api');
    final body = tests.map((e) => e.toJson()).toList();
    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.post(
      uri,
      headers: headers,
      body: json.encode(body),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
