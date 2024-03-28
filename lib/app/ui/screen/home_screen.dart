import 'package:flutter/material.dart';
import 'package:generease/app/ui/screen/contacts_screen.dart';
import 'package:get/get.dart';

import 'package:generease/app/ui/screen/apply_screen.dart';
import 'package:generease/app/ui/screen/consulting_screen.dart';
import 'package:generease/app/ui/screen/schedule_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            const Row(
              children: [
                Text(
                  'GENEREASE',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.notifications,
                  color: Color(0xffF5B700),
                  size: 30,
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            'assets/images/person.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/images/speechBalloon.png',
                            width: Get.width * 2 / 3,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '조나희님',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                  )
                                ],
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '다가오는 예약 일정',
                                      style: TextStyle(
                                        color: Color(0xff616161),
                                        fontSize: 12,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' 2024',
                                      style: TextStyle(
                                        color: Color(0xff2F4EFF),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '년',
                                      style: TextStyle(
                                        color: Color(0xff616161),
                                        fontSize: 12,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' 3',
                                      style: TextStyle(
                                        color: Color(0xff2F4EFF),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '월',
                                      style: TextStyle(
                                        color: Color(0xff616161),
                                        fontSize: 12,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' 4',
                                      style: TextStyle(
                                        color: Color(0xff2F4EFF),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '일',
                                      style: TextStyle(
                                        color: Color(0xff616161),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _blueBox(
                        ontap: () {
                          Get.to(() => const ConsultingScreen());
                        },
                        icon: 'computer',
                        text: '예약 상담',
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      _blueBox(
                        ontap: () {
                          Get.to(() => const ScheduleScreen());
                        },
                        icon: 'calendar',
                        text: '예약 일정',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _blueBox(
                        ontap: () {},
                        icon: 'mailIcon',
                        text: '친구초대',
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      _blueBox(
                        ontap: () {
                          Get.to(() => const ContactsScreen());
                        },
                        icon: 'call_ring',
                        text: '비상 연락망',
                        iconSize: 70,
                      ),
                    ],
                  ),
                  _whiteBox(
                    ontap: () {
                      print('앱 가이드 영상');
                    },
                    text: '앱 가이드 영상',
                    imagePath: 'assets/icons/check.png',
                  ),
                  _whiteBox(
                    ontap: () {
                      print('도우미 신청');
                      Get.to(() => const ApplyScreen());
                    },
                    text: '도우미 신청',
                    imagePath: 'assets/icons/noteIcon.png',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }

  Widget _blueBox({
    required Function() ontap,
    required String icon,
    required String text,
    double? iconSize,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Material(
        color: const Color(0xff2F4EFF),
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: ontap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: (Get.width - 60) / 2,
            height: (Get.width - 60) / 2,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/icons/$icon.png',
                  width: iconSize ?? 95,
                ),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _whiteBox({
    required Function() ontap,
    required String text,
    required String imagePath,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: ontap,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            height: 75,
            padding: const EdgeInsets.only(
              left: 20,
              right: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    color: Color(0xff5F5F5F),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff5F5F5F),
                  size: 15,
                ),
                const Spacer(),
                Image.asset(
                  imagePath,
                  width: 54,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
