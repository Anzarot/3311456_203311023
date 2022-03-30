import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maestro2/Widgets/Drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:maestro2/Utility Files/ClientSecret.dart';

Future<ProfilVeri> fetchProfilVeri() async {
  final response =
      await http.get(Uri.parse("https://api.spotify.com/v1/me"), headers: {
    HttpHeaders.acceptHeader: "Accept: application/json",
    HttpHeaders.contentTypeHeader: "Content-Type: application/json",
    HttpHeaders.authorizationHeader: "Authorization: Bearer $token"
  });

  if (response.statusCode == 200) {
    return ProfilVeri.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class ProfilVeri {
  final String ad;
  final String url;
  final String eposta;
  final String takipci;
  final String ulke;

  const ProfilVeri({
    required this.ad,
    required this.url,
    required this.eposta,
    required this.takipci,
    required this.ulke,
  });

  factory ProfilVeri.fromJson(Map<String, dynamic> json) {
    return ProfilVeri(
      ad: json['display_name'].toString(),
      url: json['images'][0]['url'].toString(),
      eposta: json['email'].toString(),
      takipci: json['followers']['total'].toString(),
      ulke: json['country'].toString()
    );
  }
}

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late Future<ProfilVeri> ProfilVerim;

  @override
  void initState() {
    super.initState();
    ProfilVerim = fetchProfilVeri();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SolBar(),
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black,
            title: Text("Profil")),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/profilBackground.png'),
                  fit: BoxFit.cover)),
          child: Row(
            children: [
              Flexible(flex: 2, child: Container()),
              Flexible(
                  flex: 7,
                  child: Container(
                    child: Column(
                      children: [
                        Flexible(
                          flex: 4,
                          child: Container(
                            color: Color(0x32FFFFFF),
                            child: Center(
                              child: Column(
                                children: [
                                  Flexible(flex:2,fit: FlexFit.tight,
                                    child: FutureBuilder<ProfilVeri>(
                                      future: ProfilVerim,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return CircleAvatar(
                                            backgroundColor: Color(0x00000000),
                                            radius: 100,
                                            backgroundImage: NetworkImage(
                                              snapshot.data!.url,
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text('${snapshot.error}');
                                        }
                                        return const CircularProgressIndicator();
                                      },
                                    ),
                                  ),
                                  Flexible(flex:1,fit: FlexFit.tight,
                                    child: FutureBuilder<ProfilVeri>(
                                        future: ProfilVerim,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return BorderedText(
                                              strokeWidth: 1,
                                              strokeColor: Colors.white,
                                              child: Text(snapshot.data!.ad,
                                                  style: TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontSize: 48,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Text('${snapshot.error}');
                                          }
                                          return const CircularProgressIndicator();
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: Container(
                            color: Color(0x96FFFFFF),
                            child: Center(
                              child: Column(
                                children: [
                                  Flexible(flex:1,fit: FlexFit.tight,
                                    child: Center(
                                      child: Row(children: [
                                        Icon(
                                          Icons.remove_red_eye_sharp ,
                                          size: 35,
                                        ),
                                        FutureBuilder<ProfilVeri>(
                                            future: ProfilVerim,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                    "Takipçi: " +
                                                        snapshot.data!.takipci,
                                                    style: TextStyle(fontSize: 30));
                                              } else if (snapshot.hasError) {
                                                return Text('${snapshot.error}');
                                              }
                                              return const CircularProgressIndicator();
                                            }),
                                      ]),
                                    ),
                                  ),
                                  Flexible(flex:1,fit: FlexFit.tight,
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.alternate_email,
                                            size: 35,
                                          ),
                                          Flexible(
                                            flex: 10,
                                            child: FutureBuilder<ProfilVeri>(
                                                future: ProfilVerim,
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                        "E-Posta: " +
                                                            snapshot.data!.eposta,
                                                        style: TextStyle(
                                                            fontSize: 30));
                                                  } else if (snapshot.hasError) {
                                                    return Text(
                                                        '${snapshot.error}');
                                                  }
                                                  return const CircularProgressIndicator();
                                                }),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),Flexible(flex:1,fit: FlexFit.tight,
                                    child: Center(
                                      child: Row(children: [
                                        Icon(
                                          Icons.assistant_photo,
                                          size: 35,
                                        ),
                                        FutureBuilder<ProfilVeri>(
                                            future: ProfilVerim,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                    "Ülke: " +
                                                        snapshot.data!.ulke,
                                                    style: TextStyle(fontSize: 30));
                                              } else if (snapshot.hasError) {
                                                return Text('${snapshot.error}');
                                              }
                                              return const CircularProgressIndicator();
                                            }),
                                      ]),
                                    ),
                                  ),Spacer(flex: 1,)
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
              Flexible(flex: 2, child: Container())
            ],
          ),
        ));
  }
}
