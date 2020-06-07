import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/models/UserModel.dart';
import 'package:flutter_chat_app/providers/ChatProvider.dart';
import 'package:provider/provider.dart';
import 'package:bubble/bubble.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat';
  final TextEditingController _messageBodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double px = 1 / MediaQuery.of(context).devicePixelRatio;

    final args =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;

    final UserModel receiver = args['user'];
    final FirebaseUser sender = args['loggedInUser'];

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

                  final messages = snap.data.documents
                      .where((element) =>
                          (element.data['receiverId'] == receiver.id &&
                              element.data['senderId'] == sender.uid) ||
                          (element.data['receiverId'] == sender.uid &&
                              element.data['senderId'] == receiver.id))
                      .toList();
                  if (messages.length == 0) {
                    return Center(
                      child: Text('No Chat found'),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (ctx, idx) {
                          bool isSent = messages[idx]['senderId'] == sender.uid;
                          return isSent
                              ? Bubble(
                                  margin: BubbleEdges.only(top: 10),
                                  padding: BubbleEdges.all(15),
                                  elevation: 1 * px,
                                  alignment: Alignment.topRight,
                                  nip: BubbleNip.rightTop,
                                  color: Colors.purple,
                                  child: Text(
                                    messages[idx]['messageBody'],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : Bubble(
                                  margin: BubbleEdges.only(top: 10),
                                  padding: BubbleEdges.all(15),
                                  elevation: 1 * px,
                                  alignment: Alignment.topLeft,
                                  nip: BubbleNip.leftTop,
                                  color: Colors.black87,
                                  child: Text(
                                    messages[idx]['messageBody'],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                        }),
                  );
                }),
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
                      onPressed: () => chatProvider.sendMessage(
                          receiver.id, sender.uid, _messageBodyController.text),
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
