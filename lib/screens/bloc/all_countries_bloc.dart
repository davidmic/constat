import 'dart:convert';

import 'package:convid/services/locator.dart';
import 'package:convid/services/weather.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllCountriesBloc extends ChangeNotifier {
  static List<dynamic> list = [];
  static List<dynamic> oneCountrylist = [];

  List<dynamic> _responseDecode = [];

  get responseDecode => _responseDecode;

  set responseDecode (List<dynamic> val) => _responseDecode = val;

  String convidApi = "https://covid-193.p.rapidapi.com/statistics";
  String oneCountryApi = "https://covid-193.p.rapidapi.com/history?day=2020-06-02&country=";

  Future<http.Response> getAllCountries () async {
    var response =  await http.get(convidApi, headers: {
      "x-rapidapi-host": "covid-193.p.rapidapi.com",
      "x-rapidapi-key": "3819ef5616msha7fad23608638f9p18e6eajsn69b38768d6e0",
    });
    if (response.statusCode == 200) {
      var content = jsonDecode(response.body);
      print(content);
      list = content['response'];
      print(list);
      notifyListeners();
    }
  }

  Future<http.Response> getOneCountry ({String country, double lat, double long}) async {
    MyWeather().getOneWeather(lat: lat, long: long);
    print('Countryis' + country.toString());
    var response =  await http.get(oneCountryApi + country.toString(), headers: {
      "x-rapidapi-host": "covid-193.p.rapidapi.com",
      "x-rapidapi-key": "3819ef5616msha7fad23608638f9p18e6eajsn69b38768d6e0",
    });
    if (response.statusCode == 200) {
      var content = jsonDecode(response.body);
      print(content);
      oneCountrylist = content['response'];
      print(oneCountrylist);
      notifyListeners();
    }
  }
}