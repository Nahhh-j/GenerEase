import 'package:flutter/material.dart';
import 'package:generease/app/ui/widget/button.dart';
import 'package:get/get.dart';

class ConnectScreen extends StatelessWidget {
  ConnectScreen({super.key});

  final Map<String, dynamic> arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: Get.width,
          height: Get.height,
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Text(
                arguments['name'],
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                '도우미와 연결 중입니다...',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 240,
                    height: 240,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(120),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: Image.asset(
                        'assets/images/person.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/icons/connect_blue.png',
                    width: 100,
                  ),
                ],
              ),
              const Spacer(),
              CustomButton(
                onTap: () {
                  Navigator.pop(context);
                },
                onLongPress: () {},
                text: '연결 취소',
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                height: 58,
                color: const Color(0xffC1C1C1),
                borderRadius: BorderRadius.circular(18),
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
