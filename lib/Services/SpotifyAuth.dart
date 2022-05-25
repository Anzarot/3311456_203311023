
/*/*
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'dart:convert' show jsonDecode;
import 'package:http/http.dart' as http;

final clientID = '215404274b9f4838b0a13af6a07bcc02';
final callbackUrlScheme = 'https://localhost:8000';

final url = Uri.https('accounts.google.com', '/o/oauth2/v2/auth', {
  'response_type': 'code',
  'client_id': clientID,
  'redirect_uri': '$callbackUrlScheme:/',
  'scope': 'user-read-private user-read-email user-top-read',
});

final result = await FlutterWebAuth.authenticate(url: url.toString(), callbackUrlScheme: callbackUrlScheme);

final code = Uri.parse(result).queryParameters['code'];

final response = await http.post('https://accounts.spotify.com/authorize', body: {
'client_id': clientID,
'redirect_uri': '$callbackUrlScheme:',
'grant_type': 'authorization_code',
'code': code,
});


//https://accounts.spotify.com/authorize?client_id=215404274b9f4838b0a13af6a07bcc02&response_type=code&redirect_uri=https://localhost:8000&scope=user-read-private user-read-email user-top-read


 */*/