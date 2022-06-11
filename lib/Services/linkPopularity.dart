import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
Future linkPopularity({required int popularity,required String userID}) async{

  final userp = FirebaseFirestore.instance.collection('userPopularity').doc(userID+'-pop');
  final json = {
    'Popularity': popularity,
    'id':userID
  };
  await userp.set(json);
}