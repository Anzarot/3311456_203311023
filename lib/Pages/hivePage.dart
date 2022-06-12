import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:maestro2/Models/Boxes.dart';
import 'dart:io';
import 'package:maestro2/Models/LocalModel.dart';
import 'package:maestro2/main.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:maestro2/Models/LocalModel.dart';

class HivePage extends StatefulWidget {
  const HivePage({Key? key}) : super(key: key);

  @override
  State<HivePage> createState() => _HivePageState();
}

class _HivePageState extends State<HivePage> {
  final adsoyadcontroller = TextEditingController();
  final yascontroller = TextEditingController();
  bool cinsiyet = false;
  bool emekli = false;
  final box = Boxes.getLocalUsers();
  Uuid randomid = Uuid();
  List<String> CinsiyetListesi = ["Erkek", "Kadın"];

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

  void editLocalUser(LocalUser _localuser, String _ad, int _yas, bool _emekli,
      bool _cinsiyet) {
    String cinsiyetString = '';
    if (_cinsiyet)
      cinsiyetString = 'Kadın';
    else
      cinsiyetString = 'Erkek';
    _localuser.Ad = _ad;
    _localuser.Cinsiyet = cinsiyetString;
    _localuser.Yas = _yas;
    _localuser.Emekli = _emekli;
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
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Kayıt Ekle'),
                      content: Column(
                        children: [
                          TextField(
                            controller: adsoyadcontroller,
                            decoration: InputDecoration(hintText: 'Ad Soyad'),
                          ),
                          Spacer(),
                          TextField(
                            controller: yascontroller,
                            decoration: InputDecoration(hintText: 'Yaş'),
                          ),
                          Spacer(),
                          Text("Cinsiyet"),
                          Switch(
                              value: cinsiyet,
                              onChanged: (bool value) {
                                setState(() {
                                  cinsiyet = !cinsiyet;
                                });
                              }),
                          Spacer(),
                          Text('Emekli'),
                          Switch(
                              value: emekli,
                              onChanged: (value) {
                                setState(() {
                                  emekli = !emekli;
                                });
                              })
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              String cinsiyetString = '';
                              if (cinsiyet)
                                cinsiyetString = 'Kadın';
                              else
                                cinsiyetString = 'Erkek';

                              addLocaluser(
                                  adsoyadcontroller.text,
                                  int.parse(yascontroller.text),
                                  emekli,
                                  cinsiyetString);
                              Navigator.pop(context);
                            });
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.add))
          ]),
      body: Container(
        child: ListView.builder(
            itemCount: box.length,
            itemBuilder: (BuildContext context, int index) {
              final guncelVeri = box.getAt(index)!;
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: Text(guncelVeri.Ad.toUpperCase()[0]),
                    ),
                    title: Text(guncelVeri.Ad),
                    subtitle: Text(guncelVeri.Yas.toString()),
                    trailing: Text(emeklilik(guncelVeri.Emekli)),
                    tileColor: cinsiyetrenk(guncelVeri.Cinsiyet),
                    hoverColor: Colors.deepPurple,
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        final cAd = TextEditingController();
                        final cYas = TextEditingController();
                        bool cEmekli = false;
                        bool cCinsiyet = false;
                        return AlertDialog(
                          title: const Text('Kaydı Değiştir'),
                          content: Column(
                            children: [
                              TextField(
                                decoration:
                                    InputDecoration(hintText: 'Ad Soyad'),
                                controller: cAd,
                              ),
                              Spacer(),
                              TextField(
                                decoration: InputDecoration(hintText: 'Yaş'),
                                controller: cYas,
                              ),
                              Spacer(),
                              Text('Cinsiyet'),
                              Switch(
                                  value: cCinsiyet,
                                  onChanged: (val) {
                                    cCinsiyet = !cCinsiyet;
                                  }),
                              Spacer(),
                              Text('Emeklilik'),
                              Switch(
                                  value: cEmekli,
                                  onChanged: (val) {
                                    cEmekli = !cEmekli;
                                  }),
                              Spacer(),
                            ],
                          ),
                          actions: <Widget>[IconButton(onPressed: (){setState(() {
                            box.deleteAt(index);
                            Navigator.pop(context);
                          });}, icon: Icon(Icons.delete)),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  if(cAd.text.isEmpty)
                                    cAd.text=guncelVeri.Ad;
                                  if(cYas.text.isEmpty)
                                    cYas.text=guncelVeri.Yas.toString();
                                  editLocalUser(guncelVeri, cAd.text,
                                      int.parse(cYas.text), cEmekli, cCinsiyet);

                                  Navigator.pop(context, 'OK');
                                });
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Divider(
                    height: 0,
                  )
                ],
              );
            }),
      ),
    );
  }
}

String emeklilik(bool _val) {
  if (_val)
    return 'Emekli';
  else
    return 'Emekli Değil';
}

Color cinsiyetrenk(String _val) {
  if (_val == 'Kadın')
    return Colors.pinkAccent;
  else
    return Colors.blue;
}
