import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
Future linkUser({required String spotifyToken,required String userID}) async{

  final userw = FirebaseFirestore.instance.collection('userToken').doc(userID+'-user');
  final json = {
    'spotifyToken': spotifyToken,
  };
  await userw.set(json);
}