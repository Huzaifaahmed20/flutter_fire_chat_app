import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/models/MessagesModel.dart';

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
  List<MessagesModel> _messages = [];
  List<MessagesModel> get messages => _messages;

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

  Stream<QuerySnapshot> fetchMessages(String receiverId, String senderId) {
    try {
      final snapshot = db
          .collection('messages')
          .orderBy('date')
          .snapshots();
      return snapshot;
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future<void> sendMessage(
      String receiverId, String senderId, String messageBody) async {
    print(receiverId);
    print(senderId);
    print(messageBody);
    final documentRef = db.collection('messages').document();

    db.runTransaction((transaction) async {
      DocumentSnapshot freshSnap = await transaction.get(documentRef);
      await transaction.set(freshSnap.reference, {
        'receiverId': receiverId,
        'senderId': senderId,
        'messageBody': messageBody,
        'date': DateTime.now().millisecondsSinceEpoch
      });
    });
    notifyListeners();
  }
}
