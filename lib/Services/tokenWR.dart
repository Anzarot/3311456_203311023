/* import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

writeToken(String text) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final File file = File('${directory.path}/token.txt');
  await file.writeAsString(text);
}

Future<String> readToken() async {
  String text ="";
  try {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/token.txt');
    text = await file.readAsString();
    print("YAZDIM");
  } catch (e) {
    print("Couldn't read file");
  }
  return text;
}

 */