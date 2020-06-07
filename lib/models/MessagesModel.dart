class MessagesModel {
  String receiverId;
  String senderId;
  String messageBody;
  DateTime timestamp;

  MessagesModel(
      {this.receiverId, this.senderId, this.messageBody, this.timestamp});
}
