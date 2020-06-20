import 'package:flutter/material.dart';
import 'package:flutter_chat_app/models/UserModel.dart';
import 'package:flutter_chat_app/ui/widgets/UsersListViewModel.dart';
import 'package:stacked/stacked.dart';

class UsersList extends StatelessWidget {
  const UsersList({
    Key key,
    @required this.users,
  }) : super(key: key);

  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UsersListViewModel>.nonReactive(
      builder: (context, model, child) => ListView.builder(
        itemCount: users.length,
        itemBuilder: (ctx, idx) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${users[idx].name[0]}'),
              ),
              title: Text('${users[idx].name}'),
              subtitle: Text('${users[idx].email}'),
              onTap: () => model.navigateToChatScreen(users[idx]),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => UsersListViewModel(),
    );
  }
}
