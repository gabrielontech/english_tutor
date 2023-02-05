import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '/chatgpt/response_gpt.dart';
import '/chatgpt/generate_text.dart';
import '/data/message.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final fieldText = TextEditingController();
  late Future<String> response;
  final List<Msg> messages = [
    Msg(
        text: "Welcome",
        date: DateTime.now().subtract(const Duration(minutes: 1)),
        isMe: true),
  ].reversed.toList();

  void clearText() {
    fieldText.clear();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Chat with gpt")),
        body: Column(
          children: [
            Expanded(
                child: GroupedListView<Msg, DateTime>(
              reverse: true,
              order: GroupedListOrder.DESC,
              useStickyGroupSeparators: true,
              floatingHeader: true,
              padding: const EdgeInsets.all(8),
              elements: messages,
              groupBy: (messages) => DateTime(
                  messages.date.year, messages.date.month, messages.date.day),
              groupHeaderBuilder: (Msg messages) => SizedBox(
                height: 40,
                child: Card(
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      DateFormat.yMMMd().format(messages.date),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              itemBuilder: (context, Msg messages) => Align(
                alignment: messages.isMe
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Card(
                  color: messages.isMe ? Colors.blue : Colors.blueGrey,
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(messages.text),
                  ),
                ),
              ),
            )),
            Container(
              color: Colors.grey.shade300,
              child: TextField(
                controller: fieldText,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12),
                    suffixIcon: ElevatedButton(
                      onPressed: () async {
                        final message = Msg(
                            text: fieldText.text,
                            date: DateTime.now(),
                            isMe: true);
                        setState(() => messages.add(message));
                        clearText();
                        response = (generateText(fieldText.text));
                        Msg bot = await gptAnswer(response);
                        setState(() => messages.add(bot));
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue)),
                      child: const Text('send'),
                    ),
                    hintText: "Type something here..."),
              ),
            )
          ],
        ),
      );
}
