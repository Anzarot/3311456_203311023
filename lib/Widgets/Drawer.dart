import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:maestro2/Utility Files/ClientSecret.dart';
import 'package:maestro2/Pages/Profil.dart';
import 'package:maestro2/Pages/Settings.dart';
import 'package:flutter/material.dart';
Future<Avatar> fetchAvatar() async {
  final response = await http.get(
      Uri.parse(
          "https://api.spotify.com/v1/me"),
      headers: {
        HttpHeaders.acceptHeader: "Accept: application/json",
        HttpHeaders.contentTypeHeader: "Content-Type: application/json",
        HttpHeaders.authorizationHeader: "Authorization: Bearer $token"
      });

  if (response.statusCode == 200) {
    return Avatar.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class Avatar {
  final String url;

  const Avatar({
    required this.url
  });

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      url: json['images'][0]['url'].toString(),
    );
  }
}




class SolBar extends StatefulWidget {
  const SolBar({Key? key}) : super(key: key);

  @override
  _SolBarState createState() => _SolBarState();
}

class _SolBarState extends State<SolBar> {
  late Future<Avatar> Avatarim;
  void initState() {
    super.initState();
    Avatarim = fetchAvatar();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.all(0),
        child: Column(
          children: [
            Flexible(
                flex: 1,
                child: Container(
                  child: FutureBuilder<Avatar>(
                    future: Avatarim,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          child: BackdropFilter(
                            child: Center(
                              child: Positioned(
                                left: 0.5,
                                right: 0.5,
                                top: 0.5,
                                bottom: 0.5,
                                child: CircleAvatar(
                                  backgroundColor: Color(0xFFFFFFFF),
                                  radius: 42,
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Color(0x80000000),
                                    backgroundImage:
                                    NetworkImage(snapshot.data!.url),
                                  ),
                                ),
                              ),
                            ),
                            filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                          ),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/drawerBackground.png'),
                                  fit: BoxFit.cover)),
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    },
                  ),

                )),
            Divider(
              height: 0,
            ),
            Flexible(
                flex: 3,
                child: ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    ListTile(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProfilPage()),
                          );
                        },
                        title: Row(children: [
                          Icon(
                            Icons.account_circle,
                          ),
                          Text(
                            "  Profilim",
                          )
                        ])),
                    Divider(
                      height: 0,
                    ),
                    ListTile(
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Settings()),
                        );
                      },
                      title: Row(children: [
                        Icon(
                          Icons.settings,
                        ),
                        Text(
                          "  Ayarlar",
                        )
                      ]),
                    ),
                    Divider(
                      height: 0,
                    ),
                    ListTile(
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                      tileColor: Colors.red,
                      onTap: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      title: Row(
                        children: [
                          Icon(Icons.logout, color: Colors.white),
                          Text("  Çıkış Yap",
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                  ],
                )),Container(child: Image.asset("assets/images/blurlu.png"))
          ],
        ),
      ),
    );
  }
}