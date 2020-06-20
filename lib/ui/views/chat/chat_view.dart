import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/models/UserModel.dart';
// import 'package:provider/provider.dart';
import 'package:flutter_chat_app/ui/views/chat/chat_viewmodel.dart';
import 'package:flutter_chat_app/ui/widgets/MessagesList.dart';
import 'package:stacked/stacked.dart';

// import '../models/UserModel.dart';
// import '../providers/ChatProvider.dart';
// import '../../widgets/MessagesList.dart';

class ChatView extends StatelessWidget {
  static const routeName = '/chat';
  ChatView(this.friend);
  final UserModel friend;
  final TextEditingController _messageBodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget buildChatMessages(model, friendId) {
      if (model.messages.length == 0) {
        return Center(
          child: Text('No Messages to show'),
        );
      } else {
        if (model.isBusy) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          child: MessagesList(messages: model.messages, friendId: friend.id),
        );
      }
    }

    return ViewModelBuilder<ChatViewModel>.reactive(
      onModelReady: (model) => model.listenToMessages(friend.id),
      builder: (context, model, child) {
        print('MESSAGES ${model.messages}');
        return Scaffold(
          appBar: AppBar(
            title: Text(friend.name),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildChatMessages(model, friend.id),
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
                        onPressed: () => model.sendMessage(_messageBodyController.text, friend.id),
                        child: Text('Send'),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
      viewModelBuilder: () => ChatViewModel(),
    );
    // final args =
    //     ModalRoute.of(context).settings.arguments as Map<String, Object>;

    // final UserModel receiver = args['user'];
    // final FirebaseUser sender = args['loggedInUser'];
    // List fetchUserMessages(messages) {
    //   return messages
    //       .where((element) =>
    //           (element.data['receiverId'] == receiver.id &&
    //               element.data['senderId'] == sender.uid) ||
    //           (element.data['receiverId'] == sender.uid &&
    //               element.data['senderId'] == receiver.id))
    //       .toList();
    // }

    // final chatProvider = Provider.of<ChatProvider>(context);
  }
}
