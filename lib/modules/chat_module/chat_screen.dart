import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/constant.dart';
import 'package:sn_2nd/screen/chat_module/controller/chat_controller.dart';
import 'package:sn_2nd/screen/chat_module/model/message_model.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);

  ChatController _chatController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: Text(
          '', //this.peerNickname,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // List of messages
              //buildListMessage(),
              FirebaseAnimatedList(
                query: _chatController.messageDao.getMessageQuery(),
                itemBuilder: (context, snapshot, animation, index) {
                  final json = snapshot.value as Map<String, dynamic>;
                  final messageModel = MessageModel.fromJson(json);
                  return Row(
                    mainAxisAlignment: messageModel.sender == Constants.id
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: 70.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.sp),
                            color: Colors.grey.shade200),
                        child: Padding(
                          padding: EdgeInsets.all(6.sp),
                          child: Text(
                            messageModel.message,
                            style: TextStyle(fontSize: 10.sp),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),

              // Input content
              Container(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 5.w,
                    ),
                    Flexible(
                      child: Container(
                        child: TextField(
                          onSubmitted: (value) {
                            /* onSendMessage(
                                textEditingController.text, TypeMessage.text); */
                            _chatController.sendMessage();
                          },
                          style: TextStyle(
                              color: Colors.blue.shade200, fontSize: 15),
                          controller: _chatController.messageController,
                          decoration: InputDecoration.collapsed(
                            hintText: 'Type your message...',
                            hintStyle: TextStyle(color: Colors.grey.shade300),
                          ),
                          //focusNode: focusNode,
                        ),
                      ),
                    ),

                    // Button send message
                    Material(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            /* onSendMessage(
                              textEditingController.text, TypeMessage.text), */
                            _chatController.sendMessage();
                          },
                          color: Colors.blue.shade200,
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ],
                ),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: Colors.grey.shade300, width: 0.5)),
                    color: Colors.white),
              )
            ],
          ),
          // Loading
        ],
      ),
    );
  }
}
