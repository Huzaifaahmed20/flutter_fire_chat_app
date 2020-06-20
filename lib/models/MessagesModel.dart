class MessagesModel {
  String receiverId;
  String senderId;
  String messageBody;
  int createdAt;

  MessagesModel({this.receiverId, this.senderId, this.messageBody, this.createdAt});

  MessagesModel.fromData(Map<String, dynamic> data)
      : receiverId = data['receiverId'],
        senderId = data['senderId'],
        messageBody = data['messageBody'],
        createdAt = data['createdAt'];

  static MessagesModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MessagesModel(
      receiverId: map['receiverId'],
      senderId: map['senderId'],
      messageBody: map['messageBody'],
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'receiverId': receiverId,
      'senderId': senderId,
      'messageBody': messageBody,
      'createdAt': createdAt,
    };
  }
}
