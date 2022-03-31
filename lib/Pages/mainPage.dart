import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:maestro2/Pages/AllTime.dart';
import 'package:maestro2/Pages/Monthly.dart';

import 'package:maestro2/Widgets/Drawer.dart';
import 'package:maestro2/Pages/SemiAnnual.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SolBar(),
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text("Maestro")),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/profilBackground.png'),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              Spacer(),
              Flexible(
                child: Row(
                  children: [Spacer(),
                    Flexible(
                        fit: FlexFit.tight,
                        child: Container(
                          child: FittedBox(
                            child: FloatingActionButton(backgroundColor: Color(0x16FFFFFF),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  FittedBox(
                                    child: Icon(
                                      Icons.calendar_today,
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "Aylık",
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Monthly()),
                                );
                              },
                            ),
                          ),
                        )),Spacer(),
                    Flexible(
                        fit: FlexFit.tight,
                        child: FittedBox(
                          child: FloatingActionButton(backgroundColor: Color(0x16FFFFFF),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                FittedBox(
                                  child: Icon(
                                    Icons.view_week,
                                  ),
                                ),
                                FittedBox(
                                    child: Text(
                                  "6 Aylık",
                                ))
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SemiAnnual()),
                              );
                            },
                          ),
                        )),Spacer(),
                  ],
                ),
              ),
              Spacer(),
              Flexible(
                child: Row(
                  children: [Spacer(),
                    Flexible(
                        fit: FlexFit.tight,
                        child: FittedBox(
                          child: FloatingActionButton(backgroundColor: Color(0x16FFFFFF),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                FittedBox(
                                  child: Icon(
                                    Icons.watch_later,
                                  ),
                                ),
                                FittedBox(
                                  child: Text(
                                    "    Tüm\nZamanlar",
                                  ),
                                )
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AllTime()),
                              );
                            },
                          ),
                        )),Spacer(),
                    Flexible(
                        fit: FlexFit.tight,
                        child: FittedBox(
                            child: FloatingActionButton(backgroundColor: Color(0x16FFFFFF),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    FittedBox(
                                      child: Icon(
                                        Icons.insert_chart,
                                      ),
                                    ),
                                    FittedBox(
                                      child: Text(
                                        "Özgünlük\n  Hesabı",
                                      ),
                                    )
                                  ],
                                ),
                                onPressed: () {}))),Spacer(),
                  ],
                ),
              ),
              Spacer(),
              Flexible(
                child: Row(
                  children: [
                    Spacer(),
                    Flexible(
                        fit: FlexFit.tight,
                        child: FittedBox(
                          child: FloatingActionButton(backgroundColor: Color(0x16FFFFFF),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  FittedBox(
                                    child: Icon(
                                      Icons.favorite,
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      " Aylık\nTürler",
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {}),
                        )),Spacer(),
                    Flexible(
                        fit: FlexFit.tight,
                        child: FittedBox(
                            child: FloatingActionButton(backgroundColor: Color(0x16FFFFFF),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                onPressed: () {}))),Spacer(),
                  ],
                ),
              ),
              Spacer(),
            ],
          )),
    );
  }
}
