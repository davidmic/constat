import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyLocator extends ChangeNotifier {
  static String country;
  static double lat;
  static double long;
  double _latitude;
  double _longitude;

//  get country => _country;
//  set country (String val) => _country = val;

  get latitude => _latitude;
  set latitude (double val) => _latitude = val;

  get longitude => _longitude;
  set longitude (double val) => _longitude = val;

  getUserLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
    GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();
    latitude = position.latitude;
    longitude = position.longitude;
    lat = position.latitude;
    long = position.longitude;
    print(latitude.toString() + " " + longitude.toString());
    getUserCountry(
      longitude: longitude,
      latitude: latitude,
    );
    notifyListeners();
    return;
  }

  getUserCountry({double latitude, double longitude}) async {
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(latitude, longitude);
    country = placemark[0].country.toString().toLowerCase();
    print(placemark[0].country.toString());
    notifyListeners();
  }
}

