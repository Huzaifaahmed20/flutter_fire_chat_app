import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/ChatScreen.dart';
import 'package:flutter_chat_app/screens/HomeScreen.dart';
import '../providers/ChatProvider.dart';
import 'package:flutter_chat_app/models/UserModel.dart';

class UsersList extends StatelessWidget {
  const UsersList({
    Key key,
    @required this.chats,
    @required this.appUsers,
    @required this.widget,
  }) : super(key: key);

  final ChatProvider chats;
  final List<UserModel> appUsers;
  final HomeScreen widget;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => chats.fetchUsers(),
      child: ListView.builder(
        itemCount: appUsers.length,
        itemBuilder: (ctx, idx) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${appUsers[idx].name[0]}'),
              ),
              title: Text('${appUsers[idx].name}'),
              subtitle: Text('${appUsers[idx].email}'),
              onTap: () => Navigator.of(context).pushNamed(
                ChatScreen.routeName,
                arguments: {'user': appUsers[idx], 'loggedInUser': widget.user},
              ),
            ),
          ),
        ),
      ),
    );
  }
}
