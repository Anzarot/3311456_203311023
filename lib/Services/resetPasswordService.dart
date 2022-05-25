import 'package:firebase_auth/firebase_auth.dart';

Future resetPassword(String _email) async{
  await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
}