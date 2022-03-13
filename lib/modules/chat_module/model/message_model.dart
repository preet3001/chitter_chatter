// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

List<MessageModel> messageModelFromJson(String str) => List<MessageModel>.from(
    json.decode(str).map((x) => MessageModel.fromJson(x)));

String messageModelToJson(List<MessageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessageModel {
  MessageModel({
    required this.id,
    required this.conversationId,
    required this.sender,
    required this.reciever,
    required this.message,
  });

  String id;
  String conversationId;
  String sender;
  String reciever;
  String message;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        conversationId: json["conversationId"],
        sender: json["sender"],
        reciever: json["reciever"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "conversationId": conversationId,
        "sender": sender,
        "reciever": reciever,
        "message": message,
      };
}
