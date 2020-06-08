import 'package:convid/screens/bloc/all_countries_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AllCountries extends StatefulWidget {
  @override
  _AllCountriesState createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {

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

  @override
  Widget build(BuildContext context) {
    var allCountryBloc = Provider.of<AllCountriesBloc>(context);

    return  Padding(
        padding: const EdgeInsets.only(top:10.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: AllCountriesBloc.list.length,
            itemBuilder: (context, index) {
            final current = AllCountriesBloc.list[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left:15.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(current['country'].toString(),
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text('Statistics',
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
//                                  Text('Continent: ', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffB2822E)),),

                                Text(current['continent'].toString()),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              );
            }
        ),
    );
  }
}
