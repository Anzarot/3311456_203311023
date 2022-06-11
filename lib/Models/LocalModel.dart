import 'package:hive/hive.dart';
part 'LocalModel.g.dart';

@HiveType(typeId: 0)
class LocalUser{
  @HiveField(0)
  late String Ad;
  @HiveField(1)
  late int Yas;
  @HiveField(2)
  late String Cinsiyet;
  @HiveField(3)
  late bool Emekli;

}