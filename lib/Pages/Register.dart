import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uuid/uuid.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  @override
  final email = TextEditingController();
  final password = TextEditingController();
  final password2 = TextEditingController();
  var uuid = Uuid();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Kayıt Ol"),
      ),
      body: Container(
        child: Row(children: [
          Spacer(),
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: Column(
              children: [
                Spacer(
                  flex: 1,
                ),
                Flexible(fit: FlexFit.tight, child: Text("E-Posta")),
                Flexible(fit: FlexFit.tight, child: TextField(controller: email,)),
                Spacer(),
                Flexible(fit: FlexFit.tight, child: Text("Şifre")),
                Flexible(
                  fit: FlexFit.tight,
                  child: TextField(controller: password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false),
                ),
                Spacer(),
                Flexible(fit: FlexFit.tight, child: Text("Şifre (Tekrar)")),
                Flexible(
                  fit: FlexFit.tight,
                  child: TextField(controller: password2,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false),
                ),
                Spacer(),
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                      width: 100,
                      child: FloatingActionButton(
                          shape: RoundedRectangleBorder(),
                          backgroundColor: Colors.black,
                          child: Text("Kayıt Ol"),
                          onPressed: (){
                            if(password.text==password2.text){
                              FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
                              Navigator.pop(context);
                            }

                              //createUser(userID: uuid.v4(), userEMail: email.text, userPassword:password.text);

                          })),
                ),
                Spacer()
              ],
            ),
          ),
          Spacer()
        ]),
      ),
    );
  }
}
