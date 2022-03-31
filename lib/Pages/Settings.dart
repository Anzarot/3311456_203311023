import 'package:flutter/material.dart';
import 'package:maestro2/Widgets/Drawer.dart';
import 'dart:async' show Future;
import '../main.dart';
import 'package:flutter/services.dart' show rootBundle;
class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}


class _SettingsState extends State<Settings> {
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SolBar(),
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black,
            title: Text("Ayarlar")),
        body: Container(
          child: ListView(
            children: [
              SwitchListTile(
                  title: Text("Karanlık Mod "),
                  value: isDark,
                  onChanged: (bool value) {
                    setState(() {
                      isDark=!isDark;

                    });
                  }),
              Divider()
            ],
          ),
        ));
  }
}

