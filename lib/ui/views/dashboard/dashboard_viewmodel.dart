import 'package:flutter_chat_app/app/locator.dart';
import 'package:flutter_chat_app/models/UserModel.dart';
import 'package:flutter_chat_app/services/auth_service.dart';
import 'package:flutter_chat_app/services/firestore_service.dart';
import 'package:stacked/stacked.dart';

class DashboardViewModel extends FutureViewModel<List<UserModel>> {
  final AuthService _authService = locator<AuthService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  UserModel get user => _authService.currentUser;

  Future<List<UserModel>> users() async {
    return await _firestoreService.getAllUsersOnce(_authService.currentUser.id);
  }

  @override
  Future<List<UserModel>> futureToRun() {
    return users();
  }

  void signOut() => _authService.logOut();
}
