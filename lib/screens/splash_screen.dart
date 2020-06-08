import 'dart:async';
import 'package:convid/screens/bloc/all_countries_bloc.dart';
import 'package:convid/services/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  void navpage () {
    Navigator.pushReplacementNamed(context, '/navigator');
  }

  @override

  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), navpage);
    AllCountriesBloc().getAllCountries();
    MyLocator().getUserLocation();

  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.05,
            child: Image.asset('asset/convid.jpg'),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.09,
            right: MediaQuery.of(context).size.width * 0.07,
            child: Image.asset('asset/convid.jpg'),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.09,
            left: MediaQuery.of(context).size.width * 0.07,
            child: Image.asset('asset/convid.jpg'),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
            child: Image.asset('asset/convid.jpg'),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: RichText(
                    text: TextSpan(
                    text: 'CON', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffB2822E), fontSize: 30),
                      children: [
                        TextSpan(
                          text: 'S', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 40),
                        ),
                        TextSpan(
                          text: 'tat', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffB2822E), fontSize: 30),
                        ),
                      ]
                  ),
                 ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
