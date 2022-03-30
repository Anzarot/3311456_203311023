import 'package:flutter/material.dart';
import 'package:maestro2/Pages/loginPage.dart';
class Cimen extends StatefulWidget {
  const Cimen({Key? key}) : super(key: key);

  @override
  _CimenState createState() => _CimenState();
}

class _CimenState extends State<Cimen> {
  @override
  Widget build(BuildContext context) {
    if(isDark==false){
    return Container(child: Image.asset("assets/images/blurlu.png"));
  }
    else {
      return Container(child: Image.asset("assets/images/blurluInverted.png"));
    }
    }
}
