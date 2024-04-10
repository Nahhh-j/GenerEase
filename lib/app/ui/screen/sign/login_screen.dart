import 'package:flutter/material.dart';
import 'package:generease/app/ui/screen/sign/request_message_screen.dart';
import 'package:get/get.dart';

import 'package:generease/app/ui/widget/button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          color: Color(0xff2F4EFF),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 110),
              Image.asset(
                'assets/icons/mainIcon.png',
                width: 240,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 5,
                    height: 5,
                    margin: const EdgeInsets.only(
                      left: 3,
                      right: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  Container(
                    width: 5,
                    height: 5,
                    margin: const EdgeInsets.only(
                      left: 3,
                      right: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  Container(
                    width: 5,
                    height: 5,
                    margin: const EdgeInsets.only(
                      left: 3,
                      right: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  Container(
                    width: 5,
                    height: 5,
                    margin: const EdgeInsets.only(
                      left: 3,
                      right: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'GENEREASE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                '세대 간의 연결\n지금 편리한 예약을 소통을 통해 시작해보세요!',
                style: TextStyle(color: Color(0xffE2D8FB)),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              CustomButton(
                onTap: () {
                  Get.to(
                    () => const RequestMessageScreen(),
                    arguments: {'kind': 'register'},
                  );
                },
                onLongPress: () {},
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                height: 53,
                margin: const EdgeInsets.all(10),
                text: '시작하기',
                textStyle: const TextStyle(
                  color: Color(0xff2F4EFF),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '이미 계정이 있나요?',
                    style: TextStyle(
                      color: Color(0xffE2D8FB),
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => const RequestMessageScreen(),
                        arguments: {'kind': 'login'},
                      );
                    },
                    child: const Text(
                      ' 로그인',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
