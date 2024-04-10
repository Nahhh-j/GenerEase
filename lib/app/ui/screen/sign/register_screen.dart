// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generease/app/ui/widget/toast.dart';
import 'package:get/get.dart';

import 'package:generease/app/routes/app_routes.dart';
import 'package:generease/app/ui/widget/datepicker.dart';
import 'package:generease/app/ui/widget/button.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final Uri operatingPolicyUrl = Uri.parse(
      'https://thunder-twister-d63.notion.site/fbf6261d173f49b68893ca728259afc0');
  final Uri privacyPolicyUrl = Uri.parse(
      'https://thunder-twister-d63.notion.site/bf41d54689c44a4288a4a6704eb85dd3');
  final FocusNode _focusNode = FocusNode();
  TextEditingController nameCtrl = TextEditingController();
  DateTime today = DateTime.now();
  DateTime? birthDay;
  bool _isChecked1 = false;
  bool _isChecked2 = false;

  void _showDatePicker(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => Container(
        height: 300,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  void setBirthDay(DateTime date) {
    setState(() {
      birthDay = date;
    });
  }

  bool _checkData() {
    if (nameCtrl.value.text == "" ||
        _isChecked1 == false ||
        _isChecked2 == false) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    super.initState();

    nameCtrl.addListener(() {
      setState(() {});
    });

    print('today : $today');
    print('birthday : $birthDay');
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
                  child: CustomBackButton(
                    margin: EdgeInsets.only(bottom: 10),
                  ),
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
                            '정보를 입력해주세요.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 29,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          height: 47,
                          margin: const EdgeInsets.only(top: 30),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Container(
                                padding: const EdgeInsets.all(14),
                                child:
                                    Image.asset('assets/icons/person_grey.png'),
                              ),
                              hintText: '이름',
                              hintStyle: const TextStyle(
                                color: Color(0xffA4A4A4),
                                fontSize: 14,
                              ),
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffDBDBDB)),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffDBDBDB)),
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            cursorColor: Colors.grey,
                            controller: nameCtrl,
                            keyboardType: TextInputType.text,
                            focusNode: _focusNode,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9a-zA-Zㄱ-ㅎ가-힣]')),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _focusNode.unfocus();
                            _showDatePicker(
                              Column(
                                children: [
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            '취소',
                                            style: TextStyle(
                                              color: Colors.blue[700],
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            '완료',
                                            style: TextStyle(
                                              color: Colors.blue[700],
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomCupertinoDatePicker(
                                    initDate: today,
                                    onDateTimeChanged: setBirthDay,
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Container(
                            width: Get.width,
                            height: 47,
                            margin: const EdgeInsets.only(top: 15),
                            padding: const EdgeInsets.only(
                              left: 12,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffDBDBDB)),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/note.png',
                                  width: 20,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  birthDay == null
                                      ? '생년월일'
                                      : "${birthDay!.year}년 ${birthDay!.month}월 ${birthDay!.day}일",
                                  style: TextStyle(
                                    color: birthDay == null
                                        ? const Color(0xffA4A4A4)
                                        : Colors.black,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: Color(0xffC5C5C5),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _focusNode.unfocus();

                                setState(() {
                                  _isChecked1 = !_isChecked1;
                                });
                              },
                              child: Container(
                                width: 18,
                                height: 18,
                                margin: const EdgeInsets.only(
                                  left: 5,
                                  right: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xffF5F5F5),
                                  border: Border.all(
                                    color: const Color(0xffA4A4A4),
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: _isChecked1
                                    ? const Icon(
                                        Icons.check,
                                        size: 10,
                                        weight: 20,
                                      )
                                    : const SizedBox(),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                _focusNode.unfocus();

                                if (!await launchUrl(operatingPolicyUrl)) {
                                  toast('운영정책 페이지를 열 수 없습니다.');
                                }
                              },
                              child: const Text(
                                '[필수] 이용약관 동의',
                                style: TextStyle(
                                  color: Color(0xff121212),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _focusNode.unfocus();

                                setState(() {
                                  _isChecked2 = !_isChecked2;
                                });
                              },
                              child: Container(
                                width: 18,
                                height: 18,
                                margin: const EdgeInsets.only(
                                  left: 5,
                                  right: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xffF5F5F5),
                                  border: Border.all(
                                    color: const Color(0xffA4A4A4),
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: _isChecked2
                                    ? const Icon(
                                        Icons.check,
                                        size: 10,
                                        weight: 20,
                                      )
                                    : const SizedBox(),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                _focusNode.unfocus();

                                if (!await launchUrl(privacyPolicyUrl)) {
                                  toast('개인정보 처리방침 페이지를 열 수 없습니다.');
                                }
                              },
                              child: const Text(
                                '[필수] 개인정보 처리방침 동의',
                                style: TextStyle(
                                  color: Color(0xff121212),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        CustomButton(
                          onTap: _checkData()
                              ? () {
                                  Get.offAllNamed(Routes.BASE);
                                  // Get.offAll(() => const BaseScreen());
                                }
                              : () {},
                          onLongPress: () {},
                          text: '회원가입 완료',
                          height: 58,
                          margin: const EdgeInsets.only(
                            top: 20,
                            bottom: 10,
                          ),
                          borderRadius: BorderRadius.circular(18),
                          color: const Color(0xff2F4EFF),
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
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
