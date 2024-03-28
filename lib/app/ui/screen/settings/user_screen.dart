import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:generease/app/controller/page_controller.dart';
import 'package:generease/app/ui/widget/button.dart';

class UserScreen extends StatelessWidget {
  UserScreen({super.key});

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
                    '계정/정보 관리',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: const Color(0xff2F4EFF),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
                Material(
                  color: const Color(0xff474747),
                  borderRadius: BorderRadius.circular(100),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(100),
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.image_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '휴대폰 번호',
                style: TextStyle(
                  color: Color(0xff121212),
                  fontSize: 16,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '010-0000-0000',
                style: TextStyle(
                  color: Color(0xff606060),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                print('이름');
              },
              child: Container(
                color: Colors.white,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '이름',
                          style: TextStyle(
                            color: Color(0xff121212),
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '조나희',
                          style: TextStyle(
                            color: Color(0xff606060),
                          ),
                        ),
                      ],
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
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                print('생년월일');
              },
              child: Container(
                color: Colors.white,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '생년월일',
                          style: TextStyle(
                            color: Color(0xff121212),
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '1998.10.20',
                          style: TextStyle(
                            color: Color(0xff606060),
                          ),
                        ),
                      ],
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
    );
  }
}
