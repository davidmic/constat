import 'package:convid/screens/bloc/all_countries_bloc.dart';
import 'package:convid/services/locator.dart';
import 'package:convid/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  Widget myCard ({String title, String content}) {
    return  Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffB2822E)),),
            Text(content),
          ],
        ),
      ),
    );
  }
  getCurrentWeatherIcon(){
    Widget icon;
    if (MyWeather.weatherData['main']['temp'] > 28) {
      icon = Icon(Icons.wb_sunny, size: 35, color: Colors.yellowAccent,);
    } else if (MyWeather.weatherData['main']['temp'] > 20) {
      icon = Icon(Icons.wb_sunny, size: 35,);
    } else if (MyWeather.weatherData['main']['temp'] <= 20) {
      icon = Icon(Icons.cloud, size: 35, color: Colors.white,);
    }
    return icon;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FutureBuilder<Object>(
          future:  AllCountriesBloc().getOneCountry(country: MyLocator.country, lat: MyLocator.lat, long: MyLocator.long),
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: ListView.builder(
                shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: AllCountriesBloc.oneCountrylist.length,
                  itemBuilder: (context, index) {
                    final current = AllCountriesBloc.oneCountrylist[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: -MediaQuery.of(context).size.height * 0.01,
                              left: MediaQuery.of(context).size.width * 0.558,
                              child:  Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: FlutterAnalogClock(
                                  dateTime: DateTime.now(),
                                  dialPlateColor: Colors.white,
                                  hourHandColor: Colors.black,
                                  minuteHandColor: Colors.black,
                                  secondHandColor: Colors.black,
                                  numberColor: Colors.black,
                                  borderColor: Colors.black,
                                  tickColor: Colors.black,
                                  centerPointColor: Colors.black,
                                  showBorder: true,
                                  showTicks: true,
                                  showMinuteHand: true,
                                  showSecondHand: true,
                                  showNumber: true,
                                  borderWidth: 8.0,
                                  hourNumberScale: .10,
                                  hourNumbers: ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII'],
                                  isLive: true,
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  height:  MediaQuery.of(context).size.height * 0.35,
                                  decoration: const BoxDecoration(),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(MyWeather.weatherData['name'].toString() + ", " + current['country'].toString(),
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                ),
                               SizedBox(height: 10,),
//                        Hot:84-99 F (29-37.5 C) Warm:70-84 F (21-29 C) Cool:55-69 F (13-21 C) Cold: Below 55 F (Below 13 C)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left:15.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          RichText(
                                            text: TextSpan(
                                                text: '${MyWeather.weatherData['main']['temp'].toString()}',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                                                children: [
                                                  TextSpan(
                                                    text: "\u1d52",
                                                  ),
                                                  TextSpan(
                                                    text: '\u1d9c',
                                                  ),
                                                ]
                                            ),
                                          ),
//                                      SizedBox(height: 30,),
                                          Row(
                                            children: <Widget>[
                                              getCurrentWeatherIcon(),
                                              SizedBox(width: 10,),
                                              Text(MyWeather.weatherData['weather'][0]['description'].toString(),
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text('Feels Like:',
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(MyWeather.weatherData['main']['feels_like'].toString() + '\u1d52',
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text('Pressure:',
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(MyWeather.weatherData['main']['pressure'].toString(),
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text('Humidity:',
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(MyWeather.weatherData['main']['humidity'].toString(),
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text('Wind Speed:',
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(MyWeather.weatherData['wind']['speed'].toString(),
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text('Coronovirus Statistics',
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Divider(thickness: 3,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        myCard(
                                            title: 'New',
                                            content: current['cases']['new'].toString()
                                        ),
                                        myCard(
                                          title: 'Active',
                                          content: current['cases']['active'].toString(),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        myCard(
                                          title: 'Critical',
                                          content: current['cases']['critical'].toString(),
                                        ),
                                        myCard(
                                          title: 'Recoveries',
                                          content: current['cases']['recovered'].toString(),
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        myCard(
                                          title: 'New Deaths',
                                          content: current['deaths']['new'] == null ? 'Unknown' : current['deaths']['new'].toString(),
                                        ),
                                        myCard(
                                          title: 'Total Deaths',
                                          content: current['deaths']['total'].toString(),
                                        )
                                      ],
                                    ),

                                  ],
                                ),
                                Divider(),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(right:15.0, left:15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text('T/P: ', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffB2822E)),),
                                          Text(current['tests']['total'] == null ? 'Unknown' + " / " + current['population'].toString() :current['tests']['total'].toString() + " / " + current['population'].toString()),
                                        ],
                                      ),

                                      Row(
                                        children: <Widget>[
//                                      Text('Continent: ', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffB2822E)),),

                                          Text(current['continent'].toString()),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20,),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              ),
            );
          }
        ),
      ],
    );
  }
}
