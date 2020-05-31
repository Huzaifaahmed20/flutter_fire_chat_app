import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/UserModel.dart';

class ChatProvider extends ChangeNotifier {
  static final db = Firestore.instance;
  bool isLoading = false;

  void startLoader() {
    isLoading = true;
    // notifyListeners();
  }

  void stopLoader() {
    isLoading = false;
    // notifyListeners();
  }

  List<UserModel> _users = [];

  List<UserModel> get users => _users;

  Future<void> fetchUsers() async {
    _users.clear();
    try {
      startLoader();
      final snapshot =
          await db.collection('users').orderBy('name').getDocuments();
      snapshot.documents.forEach((element) {
        _users.add(
          UserModel(
            id: element.data['id'],
            email: element.data['email'],
            name: element.data['name'],
          ),
        );
      });
      notifyListeners();
      stopLoader();
    } catch (e) {
      print(e);
    }
  }
}
