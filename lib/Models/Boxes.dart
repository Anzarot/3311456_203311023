import 'package:hive/hive.dart';
import 'package:maestro2/Models/LocalModel.dart';
import 'package:maestro2/Pages/hivePage.dart';
class Boxes{
  static Box<LocalUser> getLocalUsers() => Hive.box<LocalUser>('localuser');
}