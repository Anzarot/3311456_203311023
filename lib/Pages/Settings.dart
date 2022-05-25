import 'package:flutter/material.dart';
import 'package:maestro2/Services/linkTokenService.dart';
import 'package:maestro2/Utility%20Files/ClientSecret.dart';
import 'package:maestro2/Widgets/Drawer.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final user = FirebaseAuth.instance.currentUser!;
  final tokenController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SolBar(),
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black,
            title: Text("Ayarlar")),
        body: Container(
            child: Row(
              children: [Spacer(),Flexible(flex: 3,
                child: Column(
                  children: [
                    Spacer(),
                    Flexible(
                        fit: FlexFit.tight,
                        flex: 5,
                        child: FittedBox(child: Text("Spotify Hesabını Bağla!"))),
                    Spacer(),
                    Flexible(
                        fit: FlexFit.tight,
                        flex: 6,
                        child: Image.asset('assets/images/SpotifyLogoLight.png')),
                    Spacer(),
                    TextField(
                      controller: tokenController,
                    ),
                    Spacer(),
                    Flexible(
                        fit: FlexFit.tight,
                        flex: 6,
                        child: FittedBox(
                            child: Container(width: 250,
                              child: FloatingActionButton(shape: RoundedRectangleBorder(),
                                  backgroundColor: Colors.black,
                                  child: Text("Link"),
                                  onPressed: () => {
                                        linkUser(
                                            spotifyToken: tokenController.text,
                                            userID: user.uid)
                                      }),
                            ))),Spacer()
                  ],
                ),
              ),Spacer()]
            )));
  }
}
