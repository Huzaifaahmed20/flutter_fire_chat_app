import 'package:flutter_chat_app/app/locator.dart';
import 'package:flutter_chat_app/models/MessagesModel.dart';
import 'package:flutter_chat_app/services/auth_service.dart';
import 'package:flutter_chat_app/services/firestore_service.dart';
import 'package:stacked/stacked.dart';

class ChatViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  FirestoreService _firestoreService = locator<FirestoreService>();

  List<MessagesModel> _messages = [];
  List<MessagesModel> get messages => _messages;

  // Stream listenToMessages() {}

  // @override
  // Stream get stream => listenToMessages();

  Future sendMessage(String messageBody, String receiverId) async {
    final MessagesModel message = MessagesModel(
      messageBody: messageBody,
      receiverId: receiverId,
      senderId: _authService.currentUser.id,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    await _firestoreService.createMessage(message);
  }

  void listenToMessages(String friendId) {
    setBusy(true);

    _firestoreService
        .listenToMessagesRealTime(friendId, _authService.currentUser.id)
        .listen((messagesData) {
      List<MessagesModel> updatedMessages = messagesData;
      if (updatedMessages != null && updatedMessages.length > 0) {
        _messages = updatedMessages;
        notifyListeners();
      }

      setBusy(false);
    });
  }
}
