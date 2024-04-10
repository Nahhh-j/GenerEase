import 'package:flutter/material.dart';
import 'package:generease/app/ui/screen/settings/ask_screen.dart';
import 'package:generease/app/ui/screen/settings/noti_screen.dart';
import 'package:generease/app/ui/screen/settings/user_screen.dart';
import 'package:get/get.dart';

import 'package:generease/app/controller/page_controller.dart';
import 'package:generease/app/ui/screen/home_screen.dart';
import 'package:generease/app/ui/screen/history_screen.dart';
import 'package:generease/app/ui/screen/settings/settings_screen.dart';

class BaseScreen extends GetView<AppPageController> {
  const BaseScreen({super.key});

  Widget page() {
    if (controller.index.value == 0) {
      return const HomeScreen();
    } else if (controller.index.value == 1) {
      return const HistoryScreen();
    } else if (controller.index.value == 2) {
      return SettingsScreen();
    } else if (controller.index.value == 3) {
      return const NotiScreen();
    } else if (controller.index.value == 4) {
      return UserScreen();
    } else {
      return AskScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Obx(() => page()),
          Container(
            width: Get.width,
            height: 80,
            // padding: const EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    print('홈 버튼 누름');
                    controller.index.value = 0;
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.home_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text(
                        '홈',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('상담 버튼 누름');
                    controller.index.value = 1;
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.chat,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text(
                        '상담',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  child: GestureDetector(
                    onTap: () {
                      print('설정 버튼 누름');
                      controller.index.value = 2;
                      print(controller.index.value);
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.settings_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                        Text(
                          '설정',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
