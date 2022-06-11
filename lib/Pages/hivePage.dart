import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:maestro2/Models/Boxes.dart';
import 'dart:io';
import 'package:maestro2/Models/LocalModel.dart';
import 'package:maestro2/main.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HivePage extends StatefulWidget {
  const HivePage({Key? key}) : super(key: key);

  @override
  State<HivePage> createState() => _HivePageState();
}

class _HivePageState extends State<HivePage> {
  final adsoyadcontroller = TextEditingController();
  final yascontroller = TextEditingController();
  final cinsiyetcontroller = TextEditingController();

  List<String> CinsiyetListesi = ["Erkek", "Kadın"];
  Future openDialog() => showDialog(
      context: context,
      builder: (context) {
        bool isSwitched = false;
        return AlertDialog(
          title: Text("Veri Ekleme"),
          content: Column(
            children: [
              TextField(
                controller: adsoyadcontroller,
                decoration: InputDecoration(hintText: "Ad Soyad"),
              ),
              TextField(
                controller: yascontroller,
                decoration: InputDecoration(hintText: "Yaş"),
              ),
              TextField(
                controller: cinsiyetcontroller,
                decoration: InputDecoration(hintText: "Cinsiyet"),
              ),
              Text("Emeklilik"),
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  print(isSwitched.toString());
                  setState(() {
                    isSwitched = value;
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              )
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  addLocaluser(
                      adsoyadcontroller.text,
                      int.parse(yascontroller.text),
                      isSwitched,
                      cinsiyetcontroller.text);
                },
                child: Text("Ekle"))
          ],
        );
      });

  Future? addLocaluser(String _name, int _yas, bool _emekli, String _cinsiyet) {
    final localuserobj = LocalUser()
      ..Ad = _name
      ..Yas = _yas
      ..Cinsiyet = _cinsiyet
      ..Emekli = _emekli;
    final box = Boxes.getLocalUsers();
    box.add(localuserobj);
    print("Ekledim Panpa");
  }

  @override
  void dispose() {
    Hive.box('localuser').close();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text("Lokal VeriTabanı Deneme"),
            centerTitle: true,
            actions: [
          IconButton(
              onPressed: () {
                openDialog();
              },
              icon: Icon(Icons.add))
        ]));
  }
}
