import 'package:flutter/material.dart';
import 'package:generease/app/controller/page_controller.dart';
import 'package:generease/app/ui/widget/button.dart';
import 'package:get/get.dart';

class AskScreen extends StatelessWidget {
  AskScreen({super.key});

  final AppPageController appPageController = Get.find<AppPageController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
      ),
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomBackButton(
                    onTap: () {
                      appPageController.index.value = 2;
                    },
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    '문의하기',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '제너이즈를 사용하면서 오류를 발견했거나\n제안하고 싶은 의견이 있으신가요?\n자유롭게 이야기해주세요.\n더 편리하고, 따뜻한 서비스로 만들어가는 밑거름이 됩니다.',
              style: TextStyle(
                color: Color(0xffA4A4A4),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
