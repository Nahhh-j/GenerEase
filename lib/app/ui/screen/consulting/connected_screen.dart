import 'package:flutter/material.dart';
import 'package:generease/app/ui/screen/consulting/calling_screen.dart';
import 'package:generease/app/ui/widget/button.dart';
import 'package:get/get.dart';

class ConnectedScreen extends StatelessWidget {
  ConnectedScreen({super.key});

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
                height: 80,
              ),
              Container(
                width: 63,
                height: 63,
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
              Text(
                arguments['name'],
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                '도우미와 연결되었습니다.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 6,
                      spreadRadius: 0.1,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: const Color(0xff2F4EFF),
                  borderRadius: BorderRadius.circular(6),
                  child: InkWell(
                    onTap: () {
                      Get.to(
                        () => const CallingScreen(),
                        arguments: {'name': '조나희', 'phoneNum': '01031090060'},
                      );
                    },
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      width: 212,
                      height: 212,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/icons/call_ring.png',
                            width: 100,
                          ),
                          const Text(
                            '안심번호 전화',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              CustomButton(
                onTap: () {
                  Navigator.pop(context);
                },
                onLongPress: () {},
                text: '상담 취소',
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
                height: 10,
              ),
              CustomButton(
                onTap: () {
                  Navigator.pop(context);
                },
                onLongPress: () {},
                text: '상담 완료',
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
                height: 58,
                color: const Color(0xff2F4EFF),
                borderRadius: BorderRadius.circular(18),
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
