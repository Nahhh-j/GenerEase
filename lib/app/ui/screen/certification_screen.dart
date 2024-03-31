import 'dart:async';

import 'package:flutter/material.dart';
import 'package:generease/app/ui/screen/register_screen.dart';
import 'package:get/get.dart';

import 'package:generease/app/ui/widget/button.dart';

class CertificationScreen extends StatefulWidget {
  const CertificationScreen({super.key});

  @override
  State<CertificationScreen> createState() => _CertificationScreenState();
}

class _CertificationScreenState extends State<CertificationScreen> {
  Timer? timer;
  Duration myDuration = const Duration(minutes: 3);

  TextEditingController num1Ctrl = TextEditingController();
  TextEditingController num2Ctrl = TextEditingController();
  TextEditingController num3Ctrl = TextEditingController();
  TextEditingController num4Ctrl = TextEditingController();

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setCountDown();
    });
  }

  void stopTimer() {
    setState(() {
      timer?.cancel();
    });
  }

  void setCountDown() {
    int reduceSecondsBy = 1;
    setState(() {
      var seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    num1Ctrl.dispose();
    num2Ctrl.dispose();
    num3Ctrl.dispose();
    num4Ctrl.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Container(
          width: Get.width,
          height: Get.height,
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          decoration: const BoxDecoration(color: Colors.white),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CustomBackButton(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '인증번호',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '어떤 경우에도 타인에게 공개하지 마세요!',
                            style: TextStyle(
                              color: Color(0xffA4A4A4),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              margin: const EdgeInsets.only(
                                top: 30,
                                bottom: 20,
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(5),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xffDBDBDB)),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xff2F4EFF),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                    gapPadding: 0,
                                  ),
                                ),
                                autofocus: true,
                                focusNode: focusNode1,
                                showCursor: false,
                                controller: num1Ctrl,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                ),
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    focusNode1.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(focusNode2);
                                  }
                                },
                              ),
                            ),
                            Container(
                              width: 64,
                              height: 64,
                              margin: const EdgeInsets.only(
                                top: 30,
                                bottom: 20,
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(5),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xffDBDBDB)),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xff2F4EFF),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                focusNode: focusNode2,
                                showCursor: false,
                                controller: num2Ctrl,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                ),
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    focusNode2.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(focusNode3);
                                  }
                                },
                              ),
                            ),
                            Container(
                              width: 64,
                              height: 64,
                              margin: const EdgeInsets.only(
                                top: 30,
                                bottom: 20,
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(5),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xffDBDBDB)),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xff2F4EFF),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                focusNode: focusNode3,
                                showCursor: false,
                                controller: num3Ctrl,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                ),
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    focusNode3.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(focusNode4);
                                  }
                                },
                              ),
                            ),
                            Container(
                              width: 64,
                              height: 64,
                              margin: const EdgeInsets.only(
                                top: 30,
                                bottom: 20,
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(5),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xffDBDBDB)),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xff2F4EFF),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                focusNode: focusNode4,
                                showCursor: false,
                                controller: num4Ctrl,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                ),
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    focusNode4.unfocus();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              '남은시간 ',
                              style: TextStyle(color: Color(0xffA4A4A4)),
                            ),
                            Text(
                              '$minutes:$seconds',
                              style: const TextStyle(
                                color: Color(0xffF65151),
                              ),
                            ),
                          ],
                        ),
                        CustomButton(
                          onTap: () {
                            print(
                                '인증번호 : ${num1Ctrl.text}${num2Ctrl.text}${num3Ctrl.text}${num4Ctrl.text}');
                            // todo 인증번호 체크
                            Get.to(() => const RegisterScreen());
                            num1Ctrl.text = '';
                            num2Ctrl.text = '';
                            num3Ctrl.text = '';
                            num4Ctrl.text = '';
                          },
                          onLongPress: () {},
                          height: 58,
                          margin: const EdgeInsets.only(
                            top: 30,
                            bottom: 10,
                          ),
                          color: const Color(0xff2F4EFF),
                          borderRadius: BorderRadius.circular(18),
                          text: '인증번호 확인',
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // todo 인증번호 안올 때
                          },
                          child: const Text(
                            '인증번호가 오지않나요?',
                            style: TextStyle(
                              color: Color(0xffA4A4A4),
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xffA4A4A4),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
