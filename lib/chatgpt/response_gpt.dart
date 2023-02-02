import 'dart:convert';
import '/data/message.dart';



// That's how you make the call to chatgpt API
/*
// Function to make API request
Future<String> generateText(String prompt) async {
  // Set API endpoint and headers
  var httpsUri = Uri(
    scheme: 'https',
    host: 'api.openai.com',
    path: 'v1/engines/davinci-codex/completions');
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer YOUR_API_KEY'
  };

  // Set request body
  Map<String, dynamic> body = 
  {
    'prompt': prompt,
    'temperature': 0.7,
    'max_tokens': 100,
    'stop': '\n',
    'model': 'text-davinci-002',
    'completions':1,
    'log_level':'info',
    'engine':'davinci'
  };
  try {
    http.Response response = await http.post(httpsUri, headers: headers, body: json.encode(body));
    if (response.statusCode == 200)
    {
      return response.body;
    } else 
    {
      return Future.error('res : ${response.statusCode}');
    }
  } catch (e) {
    return Future.error('An error occurred while generating text: $e');
  }
}
*/

void gptAnswer(List<Msg> messages, Future<String> response)
{
  try {
  response.then((result) {
  Map<String, dynamic> responseData = json.decode(result);
  List<dynamic> choices = responseData['choices'];
  String text = choices[0]['text'];
  final message = Msg(
                  text: text,
                  date: DateTime.now(),
                  isMe: false
  );
  messages.add(message);
});
  } catch (e) {
    String text = "An error occurred while generating text: $e";
     final message = Msg(
                  text: text,
                  date: DateTime.now(),
                  isMe: false
     );
     messages.add(message);
  }
}