import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ChatProvider.dart';
import '../widgets/DrawerWidget.dart';

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
    // print(appUsers);
    // final isLoading = chats.isLoading;
    return Scaffold(
      drawer: DrawerWidget(widget.user),
      appBar: AppBar(
        title: Text('${widget.user.displayName}'),
      ),
      body: chats.isLoading
          ? LinearProgressIndicator()
          : ListView.builder(
              itemCount: appUsers.length,
              itemBuilder: (ctx, idx) => ListTile(
                title: Text('${appUsers[idx].name}'),
              ),
            ),
    );
  }
}
