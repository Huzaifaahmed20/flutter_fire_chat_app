import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/models/UserModel.dart';
import 'package:provider/provider.dart';

import '../providers/ChatProvider.dart';
import '../widgets/DrawerWidget.dart';
import '../widgets/UsersList.dart';

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
                delegate:
                    UsersSeach(users: appUsers, chats: chats, widget: widget)),
          )
        ],
      ),
      body: chats.isLoading
          ? LinearProgressIndicator()
          : UsersList(chats: chats, appUsers: appUsers, widget: widget),
    );
  }
}


class UsersSeach extends SearchDelegate<String> {
  UsersSeach({this.users, this.chats, this.widget});
  List<UserModel> users;
  final chats;
  final widget;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // nothing todo for now
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<UserModel> searcUsers = query.isEmpty
        ? users
        : users
            .where((i) =>
                i.name.toLowerCase().contains(query) ||
                i.email.toLowerCase().contains(query))
            .toList();
    if (searcUsers.length == 0) {
      return Center(
        child: Text('No users found'),
      );
    }
    return UsersList(chats: chats, appUsers: searcUsers, widget: widget);
  }
}
