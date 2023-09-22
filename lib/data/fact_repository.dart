import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/fact.dart';

Future<Fact> getRandomFact() async {
  final response = await http
      .get(Uri.parse("https://uselessfacts.jsph.pl/api/v2/facts/random"));
  if (response.statusCode == 200) {
    return Fact.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load fact');
  }
}

Future<Fact> getTodaysFact() async {
  final response = await http
      .get(Uri.parse("https://uselessfacts.jsph.pl/api/v2/facts/today"));
  if (response.statusCode == 200) {
    return Fact.fromJson(jsonDecode(response.body) as Map<String,dynamic>);
  } else {
    throw Exception('Failed to load fact');
  }
}
