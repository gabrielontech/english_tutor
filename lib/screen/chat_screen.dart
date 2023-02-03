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
  late Future<String> response;
  final List<Msg> messages = [
    Msg(
        text: "Hello",
        date: DateTime.now().subtract(const Duration(minutes: 1)),
        isMe: false),
  ].reversed.toList();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Chat with gpt")),
        body: Column(
          children: [
            Expanded(child: GroupedListView<Msg, DateTime>(
              reverse: true,
              order: GroupedListOrder.DESC,
              useStickyGroupSeparators: true,
              floatingHeader: true,
              padding: const EdgeInsets.all(8) ,
               elements: messages, 
               groupBy: (messages)=> DateTime(
                messages.date.year,
                messages.date.month,
                messages.date.day
               ),
               groupHeaderBuilder: (Msg messages) => SizedBox(
                height: 40,
                child: Card(
                  color: Theme.of(context).primaryColor,
                  child: Padding(padding: const EdgeInsets.all(8), child: Text(DateFormat.yMMMd().format(messages.date), style: TextStyle(color: Colors.white),),),
                  ),
               ),
               itemBuilder: (context, Msg messages) => Align(
                alignment: messages.isMe ? Alignment.centerRight : Alignment.centerLeft,
                 child: Card(
                  color: messages.isMe ? Colors.blue : Colors.blueGrey,
                  elevation: 8,
                             child: Padding(padding: const EdgeInsets.all(12), child: Text(messages.text),),
                 ),
               ),
               )),
            Container(
              color: Colors.grey.shade300,
              child: TextField(
                  decoration:  const InputDecoration(
                contentPadding:  EdgeInsets.all(12),
                hintText: "Type something here..."
              ),
              onSubmitted: (text)
               async {
                final message = Msg(
                  text: text,
                  date: DateTime.now(),
                  isMe: true
                );
                setState(() => messages.add(message));
                response = (generateText(text));
                Msg bot = await gptAnswer(response);
                setState(() => messages.add(bot));
              }
              ),
            )
          ],
        ),
      );
}