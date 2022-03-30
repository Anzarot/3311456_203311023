import 'package:flutter/material.dart';
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
      body: ListView(
        padding: EdgeInsets.all(5),
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Monthly()),
              );
            },
            title: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 48,
                ),
                Text("  Aylık",
                    style: TextStyle(
                      fontSize: 48,
                    ))
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SemiAnnual()),
              );
            },
            title: Row(
              children: [
                Icon(
                  Icons.view_week,
                  size: 48,
                ),
                Text("  6 Aylık",
                    style: TextStyle(
                      fontSize: 48,
                    ))
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AllTime()),
              );
            },
            title: Row(
              children: [
                Icon(
                  Icons.watch_later,
                  size: 48,
                ),
                Text("  Tüm \n  Zamanlar",
                    style: TextStyle(
                      fontSize: 48,
                    ))
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.insert_chart,
                  size: 48,
                ),
                Text("  Özgünlük \n  Hesabı",
                    style: TextStyle(
                      fontSize: 48,
                    ))
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
          ListTile(
            onTap: () {},
            title: Row(
              children: [
                Icon(
                  Icons.favorite,
                  size: 48,
                ),
                Text("  Aylık Türler",
                    style: TextStyle(
                      fontSize: 48,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
