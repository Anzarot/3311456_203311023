import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:maestro2/Models/PopPair.dart';
import 'package:maestro2/Models/Users.dart';
import 'package:maestro2/Pages/AdminPage.dart';
import 'package:maestro2/Services/linkPopularity.dart';
import 'package:maestro2/Widgets/Drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:maestro2/Utility Files/ClientSecret.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<Popularity> fetchPopularity() async {
  final response = await http.get(
      Uri.parse(
          "https://api.spotify.com/v1/me/top/tracks?time_range=short_term&limit=100&offset=0"),
      headers: {
        HttpHeaders.acceptHeader: "Accept: application/json",
        HttpHeaders.contentTypeHeader: "Content-Type: application/json",
        HttpHeaders.authorizationHeader: "Authorization: Bearer $token"
      });

  if (response.statusCode == 200) {
    print('Oldu!');
    return Popularity.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class Popularity {
  final int avgPopularity;

  const Popularity({
    required this.avgPopularity,
  });

  factory Popularity.fromJson(Map<String, dynamic> json) {
    num popSum = 0;
    int listLength = json['items'].length;
    for (int i = 0; i < listLength; i++) {
      popSum = popSum + json['items'][i]['popularity'];
    }
    int sumAvg = (popSum / listLength).floor();

    return Popularity(
      avgPopularity: sumAvg,
    );
  }
}

class PopularityMetric extends StatefulWidget {
  const PopularityMetric({Key? key}) : super(key: key);

  @override
  State<PopularityMetric> createState() => _PopularityMetricState();
}

class _PopularityMetricState extends State<PopularityMetric> {
  @override
  final user = FirebaseAuth.instance.currentUser!;
  late Future<Popularity> Populerlik;
  void initState() {
    super.initState();
    Populerlik = fetchPopularity();
  }
  List<Color> popRenkList = [Colors.red,Colors.orange,Colors.yellow,Colors.lightGreenAccent,Colors.green];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popülerlik"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Row(children: [
        Spacer(),
        Flexible(
          flex: 10,
          child: Column(children: [
            Spacer(),
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                child: FutureBuilder<Popularity>(
                  future: Populerlik,
                  builder: (context, snapshot) {
                    try {
                      if (snapshot.hasData) {
                        linkPopularity(
                            popularity: snapshot.data!.avgPopularity,
                            userID: user.uid);

                        return Row(children: [
                          Text(
                            "            Popülerlik Skorunuz: ",
                            style: TextStyle(
                              fontSize: 26,
                            ),
                          ),
                          Text(
                            snapshot.data!.avgPopularity.toString(),
                            style: TextStyle(
                                fontSize: 36, fontWeight: FontWeight.bold, color: popRenk(snapshot.data!.avgPopularity)),
                          )
                        ]);
                      } else if (snapshot.hasError) {
                        print(snapshot.data!.avgPopularity);
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    } catch (e) {
                      return Text("Bir hata oluştu: " + e.toString());
                    }
                  },
                ),
              ),
            ),
            Spacer(),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: StreamBuilder<List<popUser>>(
                  stream: readPopularity(),
                  builder: (context, snapshot) {
                    final List<Color> gradient = [
                      Colors.red.shade900,
                      Colors.green.shade700
                    ];
                    if (snapshot.hasData) {
                      final users = snapshot.data!;
                      List<PopPair> popAll = [];
                      for (int i = 0; i <= 100; i++) {
                        PopPair yeniPop = PopPair(popX: i, popY: 0);
                        popAll.add(yeniPop);
                      }
                      for (int i = 0; i < users.length; i++) {
                        int arananPop = users[i].pop!;
                        for (int j = 0; j <= 100; j++) {
                          if (popAll[j].popX == arananPop) {
                            popAll[j].popY++;
                          }
                        }
                      }
                      List<FlSpot> spotAll = [];
                      for (int i = 0; i <= 100; i++) {
                        FlSpot yeniSpot =
                            FlSpot(i.toDouble(), popAll[i].popY.toDouble());
                        spotAll.add(yeniSpot);
                      }

                      return Container(
                        child: LineChart(
                          LineChartData(
                              titlesData: FlTitlesData(
                                  show: true,
                                  topTitles: AxisTitles(axisNameSize: 0),
                                  rightTitles: AxisTitles(axisNameSize: 0),),
                              minX: 0,
                              minY: 0,
                              maxX: 100,
                              maxY: 10,
                              lineBarsData: [
                                LineChartBarData(gradient: LinearGradient(colors: popRenkList),
                                    spots: spotAll,
                                    isCurved: true,
                                    dotData: FlDotData(show: false),
                                    belowBarData: BarAreaData(
                                        show: true, gradient: LinearGradient(colors: popRenkList)))
                              ]),
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            Spacer(
              flex: 2,
            )
          ]),
        ),
        Spacer(
          flex: 2,
        )
      ]),
    );
  }
}

/*
List<int> allPop = [];
for(int i=0;i<users.length;i++){
allPop.add(users[i].pop!);
*/
