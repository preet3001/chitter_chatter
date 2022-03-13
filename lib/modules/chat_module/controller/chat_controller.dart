import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sn_2nd/constant.dart';
import 'package:sn_2nd/screen/chat_module/constants/chat_constants.dart';
import 'package:sn_2nd/screen/chat_module/model/message_model.dart';
import 'package:sn_2nd/web_services/api_provider.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  TextEditingController messageController = TextEditingController();
  String conversationId = '';

  final messageDao = MessageDao();
  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      Uuid uuid = Uuid();
      final message = MessageModel(
          id: uuid.v1(),
          conversationId: conversationId,
          sender: Constants.id,
          reciever: '',
          message: messageController.text);
      messageDao.saveMessage(message);
      messageController.clear();
    }
  }
}

class MessageDao {
  final DatabaseReference _messagesRef =
      FirebaseDatabase.instance.ref().child(ChatConstants.messages);

  void saveMessage(MessageModel message) {
    _messagesRef.push().set(message.toJson());
  }

  Query getMessageQuery() {
    return _messagesRef;
  }
}
