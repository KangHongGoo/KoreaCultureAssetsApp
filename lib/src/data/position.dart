import 'dart:convert';

List<List<double>> welcomeFromJson(String str) => List<List<double>>.from(json.decode(str).map((x) => List<double>.from(x.map((x) => x?.toDouble()))));

String welcomeToJson(List<List<double>> data) => json.encode(List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x)))));