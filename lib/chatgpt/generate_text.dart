import 'package:http/http.dart' as http;
import 'dart:convert';
import '/global_var/constant.dart';

Future<String> generateText(String prompt) async {
  var httpsUri = Uri.https("api.openai.com", "/v1/completions");
  try {
    http.Response response = await http.post(httpsUri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token, 
        },
        body: json.encode({
          'model': 'text-davinci-003',
          "prompt": prompt,
          'temperature': 0.8,
          'max_tokens': 200,
          'frequency_penalty': 0.5,
          'presence_penalty': 0.0,
        }));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return Future.error('res : ${response.statusCode}');
    }
  } catch (e) {
    return Future.error('An error occurred while generating text: $e');
  }
}
