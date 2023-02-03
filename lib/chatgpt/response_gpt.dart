import 'dart:convert';
import '/data/message.dart';



// That's how you make the call to chatgpt API
/*
Future<String> generateText(String prompt) async {
  var httpsUri = Uri.https("api.openai.com","/v1/completions");
  try {
    http.Response response = await http.post(httpsUri,
    headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer API_TOKEN'
    }, 
    body: json.encode({
    'model': 'text-davinci-003',
    "prompt": prompt,
    'temperature': 0.7,
    'max_tokens': 60,
    'frequency_penalty':0.5,
    'presence_penalty':0.0,
  }));
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

Future<Msg> gptAnswer(Future<String> response) async
{

  try {
    String result = await response;
    Map<String, dynamic> responseData = json.decode(result);
    List<dynamic> choices = responseData['choices'];
    String text = choices[0]['text'];
    final message = Msg(
                    text: text,
                    date: DateTime.now(),
                    isMe: false
    );
    return message;
  } catch (error) {
    final message = Msg(
                    text: error.toString(),
                    date: DateTime.now(),
                    isMe: false
    );
    return message;
  }
}