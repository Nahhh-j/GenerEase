import 'package:flutter/material.dart';
import 'package:generease/app/ui/screen/consulting_detail_screen.dart';
import 'package:generease/app/ui/widget/button.dart';
import 'package:get/get.dart';

class ConsultingScreen extends StatelessWidget {
  const ConsultingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomBackButton(),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '예약 상담',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      _button(
                        icon: 'culturalcenter',
                        text: '문화센터',
                        color: const Color(0xffAE480F),
                      ),
                      _button(
                        icon: 'eduIcon',
                        text: '교육프로그램',
                        color: const Color(0xff97580D),
                      ),
                      _button(
                        icon: 'sportsIcon',
                        text: '스포츠',
                        color: const Color(0xff6D5708),
                      ),
                      _button(
                        icon: 'hospitalIcon',
                        text: '병원',
                        color: const Color(0xffAF3157),
                      ),
                      _button(
                        icon: 'restaurantIcon',
                        text: '식당',
                        color: const Color(0xff408D48),
                      ),
                      _button(
                        icon: 'etcIcon',
                        text: '기타',
                        color: const Color(0xff0F4695),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button({
    required String icon,
    required String text,
    required Color color,
  }) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 3,
            spreadRadius: 1,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: () {
            Get.to(() => const ConsultingDetailScreen(),
                arguments: {'kind': text});
          },
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/$icon.png',
                  width: 48,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  text,
                  style: TextStyle(
                    color: color,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
