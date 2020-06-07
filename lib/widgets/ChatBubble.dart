import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';


class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key key,
    @required this.isSent,
    @required this.message,
  }) : super(key: key);

  final bool isSent;
  final String message;

  @override
  Widget build(BuildContext context) {
    double px = 1 / MediaQuery.of(context).devicePixelRatio;

    return Bubble(
      margin: isSent
          ? BubbleEdges.only(top: 10, right: 10)
          : BubbleEdges.only(top: 10, left: 10),
      padding: BubbleEdges.all(15),
      elevation: 1 * px,
      alignment: isSent ? Alignment.topRight : Alignment.topLeft,
      nip: isSent ? BubbleNip.rightTop : BubbleNip.leftTop,
      color: isSent ? Colors.purple : Colors.black87,
      child: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
