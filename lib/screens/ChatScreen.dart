import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/UserModel.dart';
import '../providers/ChatProvider.dart';
import '../widgets/MessagesList.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat';
  final TextEditingController _messageBodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;

    final UserModel receiver = args['user'];
    final FirebaseUser sender = args['loggedInUser'];
    List fetchUserMessages(messages) {
      return messages
          .where((element) =>
              (element.data['receiverId'] == receiver.id &&
                  element.data['senderId'] == sender.uid) ||
              (element.data['receiverId'] == sender.uid &&
                  element.data['senderId'] == receiver.id))
          .toList();
    }

    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(receiver.name),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: chatProvider.fetchMessages(receiver.id, sender.uid),
              builder: (ctx, snap) {
                if (!snap.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final messages = fetchUserMessages(snap.data.documents);

                if (messages.length == 0) {
                  return Center(
                    child: Text('No Chat found'),
                  );
                }

                return MessagesList(messages: messages, sender: sender);
              },
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: _messageBodyController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      onPressed: () {
                        chatProvider.sendMessage(receiver.id, sender.uid,
                            _messageBodyController.text);
                        FocusScope.of(context).unfocus();
                        _messageBodyController.clear();
                      },
                      child: Text('Send'),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
