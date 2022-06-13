import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class popUser {
  final int? pop;
  final String? id;

  popUser({this.pop, this.id});

  Map<String, dynamic> toMap() {
    return {
      'pop': pop,
      'id': id,
    };
  }

  Map<String, dynamic> toJson() => {'pop': pop};

  static popUser fromJson(Map<String, dynamic> json) =>
      popUser(pop: json['Popularity'], id: json['id']);

  popUser.fromFirestore(Map<String, dynamic> firestore)
      : pop = firestore['Popularity'],
        id = firestore['id'];
}

Stream<List<popUser>> readPopularity() {
  return FirebaseFirestore.instance
      .collection('userPopularity')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => popUser.fromJson(doc.data())).toList());
}

Widget buildUser(popUser popuser) => ListTile(
      leading: CircleAvatar(child: Text(popuser.pop.toString())),
      title: Text(popuser.id.toString()),
    );

