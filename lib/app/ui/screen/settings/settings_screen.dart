import 'package:flutter/material.dart';
import 'package:generease/app/controller/page_controller.dart';
import 'package:generease/app/ui/widget/toast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final AppPageController appPageController = Get.find<AppPageController>();

  final Uri operatingPolicyUrl = Uri.parse(
      'https://thunder-twister-d63.notion.site/fbf6261d173f49b68893ca728259afc0');
  final Uri privacyPolicyUrl = Uri.parse(
      'https://thunder-twister-d63.notion.site/bf41d54689c44a4288a4a6704eb85dd3');

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'GENEREASE',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '알림 설정',
                    style: TextStyle(
                      color: Color(0xff2F4EFF),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  GestureDetector(
                    onTap: () {
                      appPageController.index.value = 3;
                    },
                    child: Container(
                      color: Colors.white,
                      margin: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                      ),
                      child: const Row(
                        children: [
                          Text(
                            '알림 수신 설정',
                            style: TextStyle(
                              color: Color(0xff121212),
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xffA4A4A4),
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width,
                    height: 1.5,
                    color: const Color(0xffF5F5F5),
                    margin: const EdgeInsets.only(bottom: 20),
                  ),
                  const Text(
                    '사용자 설정',
                    style: TextStyle(
                      color: Color(0xff2F4EFF),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      appPageController.index.value = 4;
                    },
                    child: Container(
                      color: Colors.white,
                      margin: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                      ),
                      child: const Row(
                        children: [
                          Text(
                            '계정 / 정보 관리',
                            style: TextStyle(
                              color: Color(0xff121212),
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xffA4A4A4),
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width,
                    height: 1.5,
                    color: const Color(0xffF5F5F5),
                    margin: const EdgeInsets.only(bottom: 20),
                  ),
                  const Text(
                    '기타',
                    style: TextStyle(
                      color: Color(0xff2F4EFF),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('공지사항');
                    },
                    child: Container(
                      color: Colors.white,
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: const Row(
                        children: [
                          Text(
                            '공지사항',
                            style: TextStyle(
                              color: Color(0xff121212),
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xffA4A4A4),
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('로그아웃');
                    },
                    child: Container(
                      color: Colors.white,
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: const Row(
                        children: [
                          Text(
                            '로그아웃',
                            style: TextStyle(
                              color: Color(0xff121212),
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xffA4A4A4),
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('탈퇴하기');
                    },
                    child: Container(
                      color: Colors.white,
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: const Row(
                        children: [
                          Text(
                            '탈퇴하기',
                            style: TextStyle(
                              color: Color(0xff121212),
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xffA4A4A4),
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('문의하기');
                      appPageController.index.value = 6;
                    },
                    child: Container(
                      color: Colors.white,
                      margin: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                      ),
                      child: const Row(
                        children: [
                          Text(
                            '문의하기',
                            style: TextStyle(
                              color: Color(0xff121212),
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xffA4A4A4),
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width,
                    height: 1.5,
                    color: const Color(0xffF5F5F5),
                    margin: const EdgeInsets.only(bottom: 20),
                  ),
                  const Text(
                    '약관 및 정책',
                    style: TextStyle(
                      color: Color(0xff2F4EFF),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (!await launchUrl(operatingPolicyUrl)) {
                        toast('운영정책 페이지를 열 수 없습니다.');
                      }
                    },
                    child: Container(
                      color: Colors.white,
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: const Row(
                        children: [
                          Text(
                            '운영정책',
                            style: TextStyle(
                              color: Color(0xff121212),
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xffA4A4A4),
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      print('개인정보 처리방침');
                      if (!await launchUrl(privacyPolicyUrl)) {
                        toast('개인정보 처리방침 페이지를 열 수 없습니다.');
                      }
                    },
                    child: Container(
                      color: Colors.white,
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: const Row(
                        children: [
                          Text(
                            '개인정보 처리방침',
                            style: TextStyle(
                              color: Color(0xff121212),
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xffA4A4A4),
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
