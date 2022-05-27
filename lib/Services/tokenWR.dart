import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/token.txt');
}

Future<File> writeToken(String token) async {
  final file = await _localFile;

  // Write the file
  return file.writeAsString(token);
}

Future<String> readToken() async {
  try {
    final file = await _localFile;

    // Read the file
    final contents = await file.readAsString();

    return contents;
  } catch (e) {
    // If encountering an error, return 0
    return "Error";
  }
}