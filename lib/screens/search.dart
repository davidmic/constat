import 'package:convid/screens/bloc/all_countries_bloc.dart';
import 'package:convid/services/locator.dart';
import 'package:flutter/material.dart';


class MySearch extends SearchDelegate {
 @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
   final ThemeData theme = Theme.of(context);
   return theme.copyWith(
     primaryColor: theme.primaryColor,
     primaryIconTheme: theme.primaryIconTheme,
     primaryColorBrightness: theme.primaryColorBrightness,
     primaryTextTheme: theme.primaryTextTheme,
   );
//    return super.appBarTheme(context);
  }
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
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
    return FutureBuilder<Object>(
        future: AllCountriesBloc().getOneCountry(country: query, lat: MyLocator.lat, long: MyLocator.long),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ListView.builder(
                itemCount: AllCountriesBloc.oneCountrylist.length,
                itemBuilder: (context, index) {
                  final current = AllCountriesBloc.oneCountrylist[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(current['country'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text('Statistics',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
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
                                      content: current['cases']['new']
                                          .toString()
                                  ),
                                  myCard(
                                    title: 'Active',
                                    content: current['cases']['active']
                                        .toString(),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  myCard(
                                    title: 'Critical',
                                    content: current['cases']['critical']
                                        .toString(),
                                  ),
                                  myCard(
                                    title: 'Recoveries',
                                    content: current['cases']['recovered']
                                        .toString(),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceAround,
                                children: <Widget>[
                                  myCard(
                                    title: 'New Deaths',
                                    content: current['deaths']['new'] == null
                                        ? 'Unknown'
                                        : current['deaths']['new'].toString(),
                                  ),
                                  myCard(
                                    title: 'Total Deaths',
                                    content: current['deaths']['total']
                                        .toString(),
                                  )
                                ],
                              ),

                            ],
                          ),
                          Divider(),

                          Padding(
                            padding: const EdgeInsets.only(right: 15.0,
                                left: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text('T/P: ', style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffB2822E)),),
                                    Text(current['tests']['total'] == null
                                        ? 'Unknown' + " / " +
                                        current['population'].toString()
                                        : current['tests']['total'].toString() +
                                        " / " +
                                        current['population'].toString()),
                                  ],
                                ),

                                Row(
                                  children: <Widget>[
                                    Text('Continent: ', style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffB2822E)),),

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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Text("");
  }

}