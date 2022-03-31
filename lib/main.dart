import 'package:flutter/material.dart';
import 'package:maestro2/Pages/mainPage.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: const MyApp()));
}
bool isDark = false;
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover)),
          child: Row(
            children: [
              Spacer(flex: 3),
              Flexible(
                  flex: 9,
                  fit: FlexFit.tight,
                  child: Column(
                    children: [
                      Spacer(),
                      Flexible(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Column(
                            children: [
                              Spacer(
                                flex: 1,
                              ),
                              FittedBox(
                                child: Image.asset('assets/images/maestro.png'),
                              ),
                              Divider(),
                              Spacer(flex: 1),
                              FittedBox(child: Text("Kullanıcı Adı")),
                              Spacer(flex: 1),
                              Flexible(
                                  flex: 2,
                                  child: Row(children: [
                                    Spacer(),
                                    Flexible(flex: 5, child: TextField()),
                                    Spacer()
                                  ])),
                              Spacer(flex: 1),
                              FittedBox(child: Text("Şifre")),
                              Spacer(flex: 1),
                              Flexible(
                                  flex: 2,
                                  child: Row(children: [
                                    Spacer(),
                                    Flexible(
                                        flex: 5,
                                        child: TextField(
                                            obscureText: true,
                                            enableSuggestions: false,
                                            autocorrect: false)),
                                    Spacer()
                                  ])),
                              Spacer(flex: 3),
                              Flexible(
                                flex: 3,
                                child: Container(
                                  width: 250,
                                  child: FloatingActionButton(
                                      child: Text(
                                        "Giriş",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Color(0xff1b1b1c),
                                      shape: RoundedRectangleBorder(),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MainPage()),
                                        );
                                      }),
                                ),
                              ),
                              Spacer(flex: 3)
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  )),
              Spacer(flex: 3),
            ],
          )),
    );
  }
}
