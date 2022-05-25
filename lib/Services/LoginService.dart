import 'package:firebase_auth/firebase_auth.dart';
Future logIn(String _email,String _password) async{
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
}