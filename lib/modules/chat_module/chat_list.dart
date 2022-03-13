import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/screen/chat_module/controller/chat_controller.dart';
import 'package:sn_2nd/screen/chat_module/controller/chat_list_controller.dart';
import 'package:sn_2nd/screen/chat_module/model/conversation_model.dart';
import 'package:sn_2nd/screen/chat_module/widget/chat_item.dart';

import 'package:velocity_x/velocity_x.dart';

import 'widget/controller/chat_item_controller.dart';

class ChatList extends StatelessWidget {
  ChatList({Key? key}) : super(key: key);
  ChatListController _chatListController = Get.find();
  ChatController _chatController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 12.h,
              width: double.infinity,
              color: Colors.blue.shade700,
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_outlined,
                    size: 25.sp,
                    color: Colors.white,
                  ).onTap(() {
                    Navigator.pop(context);
                  }),
                  4.w.widthBox,
                  'My Chat'
                      .text
                      .size(22.sp)
                      .color(Colors.white)
                      .letterSpacing(1)
                      .make(),
                ],
              ),
            ),
            /* Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 10,
                itemBuilder: (context, i) {
                  return chatItem();
                },
              ),
            ), */
            Expanded(
                child: FirebaseAnimatedList(
              query: _chatListController.conversationDao.getConversationQuery(),
              itemBuilder: (context, snapshot, animation, index) {
                final json = snapshot.value as Map<String, dynamic>;
                final conversationModel = ConversationModel.fromJson(json);
                final ChatItemController _chatItemController =
                    Get.put(ChatItemController());
                _chatItemController.conversationModel = conversationModel;
                return chatItem();
              },
            ))
          ],
        ),
      ),
    );
  }
}
