import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/constant.dart';
import 'package:sn_2nd/screen/chat_module/chat_screen.dart';
import 'package:sn_2nd/screen/chat_module/controller/chat_controller.dart';
import 'package:sn_2nd/screen/chat_module/model/conversation_model.dart';
import 'package:sn_2nd/screen/chat_module/widget/controller/chat_item_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class chatItem extends StatelessWidget {
  chatItem({
    Key? key,
  }) : super(key: key);
  final ChatItemController _chatItemController = Get.find();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ChatController _chatController = Get.find();
        _chatController.conversationId =
            _chatItemController.conversationModel.id;
        Get.to(() => ChatScreen());
      },
      child: Container(
        height: 12.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30.sp,
                  backgroundImage: const AssetImage(
                    'assets/image/health.png',
                  ),
                ),
                4.w.widthBox,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _chatItemController.UserName,
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    SizedBox(
                      width: 50.w,
                      child: 'Audi A3 Sportback 35'
                          .text
                          .size(12.sp)
                          .overflow(TextOverflow.ellipsis)
                          .make(),
                    ),
                  ],
                ),
              ],
            ),
            'Jul 08'.text.size(12.sp).make(),
          ],
        ),
      ),
    );
  }
}
