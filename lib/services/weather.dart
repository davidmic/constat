import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyWeather extends ChangeNotifier {

  static var weatherData = {};

  String ApiKey = "ba83d75f80c6cebfed107372eebe4c26";

  Future<http.Response> getOneWeather ({double lat, double long}) async {
    var response =  await http.get("https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&units=metric&appid=$ApiKey");
    if (response.statusCode == 200) {
      var content = jsonDecode(response.body);
      weatherData = content;
      print(content);
      notifyListeners();
    }
  }

}