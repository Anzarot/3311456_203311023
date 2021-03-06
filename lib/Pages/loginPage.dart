import 'package:flutter/material.dart';
import 'package:maestro2/Pages/Register.dart';
import 'package:maestro2/Pages/mainPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:maestro2/Pages/passwordReset.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maestro2/Services/LoginService.dart';
class loginPage extends StatelessWidget {
   loginPage({Key? key}) : super(key: key);
  final loginEmail = TextEditingController();
  final loginPassword = TextEditingController();
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
                        flex: 5,
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

                              Spacer(flex: 2),
                              Flexible(
                                  flex: 4,
                                  child: Row(children: [
                                    Spacer(),
                                    Flexible(flex: 9, child: TextField(controller: loginEmail,decoration: InputDecoration(hintText: 'E-Mail'),)),
                                    Spacer()
                                  ])),
                              Spacer(flex: 1),
                              Flexible(
                                  flex: 4,
                                  child: Row(children: [
                                    Spacer(),
                                    Flexible(
                                        flex: 9,
                                        child: TextField(controller: loginPassword,
                                            obscureText: true,decoration: InputDecoration(hintText: '??ifre'),
                                            enableSuggestions: false,
                                            autocorrect: false)),
                                    Spacer()
                                  ])),
                              Spacer(flex: 3),
                              Flexible(
                                flex: 6,
                                child: Container(
                                  width: 250,
                                  child: FloatingActionButton(
                                      child: Text(
                                        "Giri??",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Color(0xff1b1b1c),
                                      shape: RoundedRectangleBorder(),
                                      onPressed: () {
                                        logIn(loginEmail.text, loginPassword.text);
                                      }),
                                ),
                              ),
                              Spacer(flex: 2),
                              Container(
                                  width: 250,
                                  child: FloatingActionButton(
                                      shape: RoundedRectangleBorder(),
                                      backgroundColor: Colors.white,
                                      child: Text(
                                        "Hesab??n??z yok mu? ??ye olun!",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const Register()),
                                        );
                                      })),
                              Spacer(flex: 2),
                              Container(
                                  width: 250,
                                  child: TextButton(onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const ResetPassword()),
                                        );
                                      },child: RichText(text: TextSpan(text: '??ifrenizi mi unuttunuz?'),),)),Spacer(flex: 2,)
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
