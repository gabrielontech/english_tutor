
class Msg {
    final String text;
    final DateTime date;
    final bool isMe;

    const Msg({
        required this.text,
        required this.date,
        required this.isMe,
    });
}

Msg error(String text)
{
  final message = Msg(
                text: text,
                 date: DateTime.now(),
                 isMe: false
      );
      return message;
}

