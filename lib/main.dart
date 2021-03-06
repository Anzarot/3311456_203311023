import 'package:flutter/material.dart';
import 'package:maestro2/Models/LocalModel.dart';
import 'package:maestro2/Pages/mainPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maestro2/Pages/loginPage.dart';
import 'firebase_options.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(LocalUserAdapter());
  await Hive.openBox<LocalUser>('localuser');
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp(),));
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData)
          return MainPage();
        else
          return loginPage();
      },
    );
  }
}

