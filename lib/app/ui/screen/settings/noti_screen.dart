import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:generease/app/controller/page_controller.dart';
import 'package:generease/app/ui/widget/button.dart';

class NotiScreen extends StatefulWidget {
  const NotiScreen({super.key});

  @override
  State<NotiScreen> createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> {
  AppPageController appPageController = Get.find<AppPageController>();

  bool toggle1 = false;
  bool toggle2 = false;
  bool toggle3 = false;

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
                    '알림 수신 설정',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: '상담 연결 알림\n',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: '상담이 성공적으로 연결되었을 경우 알림',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                CupertinoSwitch(
                  value: toggle1,
                  onChanged: (bool value) {
                    setState(() {
                      toggle1 = !toggle1;
                    });
                  },
                  activeColor: const Color(0xff2F4EFF),
                ),
              ],
            ),
            Container(
              width: Get.width,
              height: 1.5,
              color: const Color(0xffF5F5F5),
              margin: const EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
            ),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: '예약 확정 알림\n',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: '예약한 서비스나 상담이 확정되는 경우 알림',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                CupertinoSwitch(
                  value: toggle2,
                  onChanged: (bool value) {
                    setState(() {
                      toggle2 = !toggle2;
                    });
                  },
                  activeColor: const Color(0xff2F4EFF),
                ),
              ],
            ),
            Container(
              width: Get.width,
              height: 1.5,
              color: const Color(0xffF5F5F5),
              margin: const EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
            ),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: '문의 답변 알림\n',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: '문의한 사항에 대한 답변이 도착할 경우 알림',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                CupertinoSwitch(
                  value: toggle3,
                  onChanged: (bool value) {
                    setState(() {
                      toggle3 = !toggle3;
                    });
                  },
                  activeColor: const Color(0xff2F4EFF),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
