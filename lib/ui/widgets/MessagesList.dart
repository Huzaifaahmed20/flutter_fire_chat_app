import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './ChatBubble.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({
    Key key,
    @required this.messages,
    @required this.sender,
  }) : super(key: key);

  final List<DocumentSnapshot> messages;
  final FirebaseUser sender;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (ctx, idx) {
          bool isSent = messages[idx]['senderId'] == sender.uid;
          return ChatBubble(
            isSent: isSent,
            message: messages[idx]['messageBody'],
          );
        },
      ),
    );
  }
}
