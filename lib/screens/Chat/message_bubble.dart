import 'package:flutter/material.dart';
import 'chat_model.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final String sender;
  final bool isMe;
  const MessageBubble(
      {Key? key, required this.text, required this.sender, required this.isMe}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (isMe) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(minWidth: 0, maxWidth: 200),
              decoration: isAllEmoji(text)
                  ? BoxDecoration(color: Colors.transparent)
                  : const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
                gradient: LinearGradient(
                  colors: [
                    Colors.purple,
                    Colors.deepPurple,
                    Colors.blueAccent
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
                child: RichText(
                  overflow: TextOverflow.clip,
                  strutStyle: StrutStyle(fontSize: 12.0),
                  text: TextSpan(
                    style: isAllEmoji(text)
                        ? const TextStyle(
                      fontSize: 25,
                    )
                        : const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        // fontWeight: FontWeight.w500,
                        fontFamily: 'Metropolis'),
                    text: text == null ? '' : text,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                sender,
                style: const TextStyle(color: Colors.black54, fontSize: 12),
              ),
            ),
            Container(
              constraints: const BoxConstraints(minWidth: 0, maxWidth: 200),
              // elevation: 5.0,
              decoration: isAllEmoji(text)
                  ? const BoxDecoration(
                color: Colors.transparent,
              )
                  : const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink, Colors.redAccent, Colors.orange],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
              ),

              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
                child: Text(
                  text == null ? '' : text,
                  style: isAllEmoji(text)
                      ? const TextStyle(
                    fontSize: 25,
                  )
                      : const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'Metropolis',
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}