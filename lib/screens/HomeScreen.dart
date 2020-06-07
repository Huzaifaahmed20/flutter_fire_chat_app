import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/models/UserModel.dart';
import 'package:provider/provider.dart';

import '../providers/ChatProvider.dart';
import '../widgets/DrawerWidget.dart';
import '../widgets/UsersList.dart';
import '../helpers/UserSearchDelegate.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  final FirebaseUser user;

  HomeScreen(this.user);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void fetchedUsers() async {
    final chatsProvider = Provider.of<ChatProvider>(context, listen: false);

    await chatsProvider.fetchUsers();
  }

  @override
  void initState() {
    fetchedUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final chats = Provider.of<ChatProvider>(context);
    final appUsers =
        chats.users.where((element) => element.id != widget.user.uid).toList();
    return Scaffold(
      drawer: DrawerWidget(widget.user),
      appBar: AppBar(
        title: Text('${widget.user.displayName}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => showSearch(
                context: context,
                delegate: UserSearchDelegate(
                    users: appUsers, chats: chats, widget: widget)),
          )
        ],
      ),
      body: chats.isLoading
          ? LinearProgressIndicator()
          : UsersList(chats: chats, appUsers: appUsers, widget: widget),
    );
  }
}
