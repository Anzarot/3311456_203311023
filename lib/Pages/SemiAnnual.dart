import 'package:flutter/material.dart';
import 'package:maestro2/Widgets/Drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:maestro2/Utility Files/ClientSecret.dart';

Future<Artist> fetchArtist() async {
  final response = await http.get(
      Uri.parse(
          "https://api.spotify.com/v1/me/top/artists?time_range=medium_term&limit=3&offset=0"),
      headers: {
        HttpHeaders.acceptHeader: "Accept: application/json",
        HttpHeaders.contentTypeHeader: "Content-Type: application/json",
        HttpHeaders.authorizationHeader: "Authorization: Bearer $token"
      });

  if (response.statusCode == 200) {
    return Artist.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class Artist {
  final String firstName;
  final String firstURL;
  final String secondName;
  final String secondURL;
  final String thirdName;
  final String thirdURL;

  const Artist({
    required this.firstName,
    required this.firstURL,
    required this.secondName,
    required this.secondURL,
    required this.thirdName,
    required this.thirdURL,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      firstName: json['items'][0]['name'],
      firstURL: json['items'][0]['images'][1]['url'],
      secondName: json['items'][1]['name'],
      secondURL: json['items'][1]['images'][1]['url'],
      thirdName: json['items'][2]['name'],
      thirdURL: json['items'][2]['images'][1]['url'],
    );
  }
}

Future<Track> fetchTracks() async {
  final response = await http.get(
      Uri.parse(
          "https://api.spotify.com/v1/me/top/tracks?time_range=medium_term&limit=3&offset=0"),
      headers: {
        HttpHeaders.acceptHeader: "Accept: application/json",
        HttpHeaders.contentTypeHeader: "Content-Type: application/json",
        HttpHeaders.authorizationHeader: "Authorization: Bearer $token"
      });

  if (response.statusCode == 200) {
    print('Oldu!');
    return Track.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class Track {
  final String firstArtistName;
  final String firstURL;
  final String firstTitle;
  final String secondArtistName;
  final String secondURL;
  final String secondTitle;
  final String thirdArtistName;
  final String thirdURL;
  final String thirdTitle;

  const Track({
    required this.firstArtistName,
    required this.firstURL,
    required this.firstTitle,
    required this.secondArtistName,
    required this.secondURL,
    required this.secondTitle,
    required this.thirdArtistName,
    required this.thirdURL,
    required this.thirdTitle,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
        firstTitle: json['items'][0]['name'],
        firstURL: json['items'][0]['album']['images'][1]['url'],
        firstArtistName: json['items'][0]['album']['artists'][0]['name'],
        secondTitle: json['items'][1]['name'],
        secondURL: json['items'][1]['album']['images'][1]['url'],
        secondArtistName: json['items'][1]['album']['artists'][0]['name'],
        thirdTitle: json['items'][2]['name'],
        thirdURL: json['items'][2]['album']['images'][1]['url'],
        thirdArtistName: json['items'][2]['album']['artists'][0]['name']);
  }
}

class SemiAnnual extends StatefulWidget {
  const SemiAnnual({Key? key}) : super(key: key);

  @override
  _SemiAnnualState createState() => _SemiAnnualState();
}

class _SemiAnnualState extends State<SemiAnnual> {
  late Future<Artist> Artists;
  late Future<Track> Tracks;
  @override
  void initState() {
    super.initState();
    Tracks = fetchTracks();
    Artists = fetchArtist();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SolBar(),
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black,
            title: Text("6 Aylık")),
        body: Container(
          child: ListView(
            children: [
              ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Şarkılar",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 70),
                    ),
                    Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                          border:
                          Border.all(color: Colors.yellowAccent, width: 7)),
                      child: FutureBuilder<Track>(
                        future: Tracks,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Image.network(
                              snapshot.data!.firstURL,
                              fit: BoxFit.fill,
                            );
                          } else if (snapshot.hasError) {
                            print(snapshot.data!.firstURL);
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                    FutureBuilder<Track>(
                        future: Tracks,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!.firstTitle,
                                style: TextStyle(fontSize: 60));
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        }),
                    FutureBuilder<Track>(
                        future: Tracks,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!.firstArtistName,
                                style: TextStyle(fontSize: 30));
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        }),
                    Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey, width: 7)),
                      child: FutureBuilder<Track>(
                        future: Tracks,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Image.network(
                              snapshot.data!.secondURL,
                              fit: BoxFit.fill,
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                    FutureBuilder<Track>(
                        future: Tracks,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!.secondTitle,
                                style: TextStyle(fontSize: 60));
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        }),
                    FutureBuilder<Track>(
                        future: Tracks,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!.secondArtistName,
                                style: TextStyle(fontSize: 30));
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        }),
                    Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.brown, width: 7)),
                      child: FutureBuilder<Track>(
                        future: Tracks,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Image.network(
                              snapshot.data!.thirdURL,
                              fit: BoxFit.fill,
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                    FutureBuilder<Track>(
                        future: Tracks,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!.thirdTitle,
                                style: TextStyle(fontSize: 60));
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        }),
                    FutureBuilder<Track>(
                        future: Tracks,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!.thirdArtistName,
                                style: TextStyle(fontSize: 30));
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        })
                  ],
                ),
              ),
              ///////////////////////////////////////////////////////////////////////////
              ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Sanatçılar",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 70),
                    ),
                    Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                          border:
                          Border.all(color: Colors.yellowAccent, width: 7)),
                      child: FutureBuilder<Artist>(
                        future: Artists,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Image.network(
                              snapshot.data!.firstURL,
                              fit: BoxFit.fill,
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                    FutureBuilder<Artist>(
                        future: Artists,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!.firstName,
                                style: TextStyle(fontSize: 60));
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        }),
                    Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey, width: 7)),
                      child: FutureBuilder<Artist>(
                        future: Artists,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Image.network(snapshot.data!.secondURL,
                                fit: BoxFit.fill);
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                    FutureBuilder<Artist>(
                        future: Artists,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!.secondName,
                                style: TextStyle(fontSize: 60));
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        }),
                    Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.brown, width: 7)),
                      child: FutureBuilder<Artist>(
                        future: Artists,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Image.network(snapshot.data!.thirdURL,
                                fit: BoxFit.fill);
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                    FutureBuilder<Artist>(
                        future: Artists,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!.thirdName,
                                style: TextStyle(fontSize: 60));
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        }),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
