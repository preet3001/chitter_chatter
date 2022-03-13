// To parse this JSON data, do
//
//     final conversationModel = conversationModelFromJson(jsonString);

import 'dart:convert';

List<ConversationModel> conversationModelFromJson(String str) =>
    List<ConversationModel>.from(
        json.decode(str).map((x) => ConversationModel.fromJson(x)));

String conversationModelToJson(List<ConversationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConversationModel {
  ConversationModel({
    required this.id,
    required this.party1,
    required this.party2,
  });

  String id;
  String party1;
  String party2;

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      ConversationModel(
        id: json["id"],
        party1: json["party1"],
        party2: json["party2"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "party1": party1,
        "party2": party2,
      };
}
