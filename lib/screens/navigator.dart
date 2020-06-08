import 'package:convid/screens/all_countries.dart';
import 'package:convid/screens/bloc/all_countries_bloc.dart';
import 'package:convid/screens/home.dart';
import 'package:convid/screens/search.dart';
import 'package:convid/services/locator.dart';
import 'package:flutter/material.dart';

class MyNavigator extends StatefulWidget {

  @override
  _MyNavigatorState createState() => _MyNavigatorState();
}

class _MyNavigatorState extends State<MyNavigator> {
  List<Widget> pages = [MyHome(), AllCountries()];
  int selected = 0;
  @override

  void initState () {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(selected == 0 ? 'Current Country' : 'All Countries'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
              iconSize: 25,
              onPressed: () async {
                AllCountriesBloc().getAllCountries();
                MyLocator().getUserLocation();
              },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: MySearch(),
              );
            },
//            color: Color(0xff003399),
          ),
        ],
      ),
    body: SafeArea(
      child: pages[selected],
    ),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: selected,
      selectedItemColor: Color(0xffB2822E),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
        onTap: (val){
          setState(() {
            selected = val;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.flag,
              size: 30,
            ),
            title: Text('All Countries'),
          ),
        ]
    ),
    );
  }
}
