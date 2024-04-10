import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generease/app/ui/screen/connect_screen.dart';
import 'package:get/get.dart';

import 'package:generease/app/ui/widget/button.dart';

class ConsultingDetailScreen extends StatefulWidget {
  const ConsultingDetailScreen({super.key});

  @override
  State<ConsultingDetailScreen> createState() => _ConsultingDetailScreenState();
}

class _ConsultingDetailScreenState extends State<ConsultingDetailScreen> {
  Map<String, dynamic> arguments = Get.arguments;
  late String kind;

  MethodChannel channel = const MethodChannel('generease');
  TextEditingController nameCtrl = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool isAvailable = true;
  bool isSearchMode = false;

  List<String> nameList = [
    '조나희',
    '유재혁',
    '이지원',
    '조다희',
    '주자혁',
    '이자원',
    '쥬나희',
    '몰라',
  ];

  void _showBottomSheet({required String name}) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          width: Get.width,
          height: Get.height * 3 / 4,
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 20,
            left: 10,
            right: 10,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 57,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xffF5F5F5),
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              Container(
                width: 120,
                height: 120,
                margin: const EdgeInsets.only(
                  top: 15,
                  bottom: 15,
                ),
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
              Text(
                name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                '현재 접속중',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                '평균 1시간내 답장',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'assets/icons/sportsIcon2.png',
                    width: 66,
                  ),
                  Image.asset(
                    'assets/icons/eduIcon2.png',
                    width: 66,
                  ),
                  Image.asset(
                    'assets/icons/culturalcenter2.png',
                    width: 66,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              CustomButton(
                onTap: () {
                  _showDialog();
                },
                onLongPress: () {},
                text: '상담 연결',
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                color: const Color(0xff2F4EFF),
                borderRadius: BorderRadius.circular(18),
                height: 58,
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDialog() {
    isAvailable
        ? showCupertinoModalPopup(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                content: const Text(
                  '도우미님과 상담 연결을\n신청하겠습니까?',
                  style: TextStyle(fontSize: 16),
                ),
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      '허용안함',
                      style: TextStyle(color: Color(0xff007AFF)),
                    ),
                  ),
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () async {
                      Navigator.pop(context);
                      Get.to(
                        () => ConnectScreen(),
                        arguments: {'name': '조나희', 'phoneNum': '01031090060'},
                      );
                      if (Platform.isIOS) {
                        try {
                          await channel.invokeMethod(
                            'showLiveActivity',
                            ['조나희', '상담대기'],
                          );
                        } catch (e) {
                          print('Live Activity 호출 실패');
                        }
                      }
                    },
                    child: const Text(
                      '허용',
                      style: TextStyle(color: Color(0xff007AFF)),
                    ),
                  ),
                ],
              );
            },
          )
        : showCupertinoModalPopup(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: const Text('상담 연결이 현재 불가능합니다.'),
                content:
                    const Text('최대 예약 가능 횟수는 2회입니다.\n다른 예약이 확정된 후에 다시 시도해주세요.'),
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      '확인',
                      style: TextStyle(color: Color(0xff007AFF)),
                    ),
                  ),
                ],
              );
            },
          );
  }

  @override
  void initState() {
    super.initState();

    kind = arguments['kind'];

    nameCtrl.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
        ),
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  CustomBackButton(
                    onTap: isSearchMode
                        ? () {
                            setState(() {
                              isSearchMode = false;
                            });
                          }
                        : () {
                            Get.back();
                          },
                  ),
                  isSearchMode
                      ? const SizedBox(
                          width: 10,
                        )
                      : const Spacer(),
                  isSearchMode
                      ? Expanded(
                          child: SizedBox(
                            height: 36,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: '찾는 도우미 이름 입력',
                                hintStyle: const TextStyle(
                                  color: Color(0xffA4A4A4),
                                ),
                                contentPadding: const EdgeInsets.only(left: 15),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffDBDBDB), width: 1.5),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffDBDBDB), width: 1.5),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              controller: nameCtrl,
                              keyboardType: TextInputType.text,
                              cursorHeight: 20,
                              cursorColor: Colors.grey,
                              focusNode: _focusNode,
                            ),
                          ),
                        )
                      : Text(
                          kind,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                  isSearchMode ? const SizedBox() : const Spacer(),
                  isSearchMode
                      ? const SizedBox()
                      : Container(
                          margin: const EdgeInsets.all(0),
                          child: Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isSearchMode = true;
                                });
                              },
                              borderRadius: BorderRadius.circular(14),
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xffF5F5F5),
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.search,
                                    color: Color(0xff121212),
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: _helperList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _helperList() {
    return ListView.builder(
      itemCount: nameList.length,
      itemBuilder: (context, index) {
        return isSearchMode
            ? nameList[index].contains(nameCtrl.value.text)
                ? listBox(nameList[index])
                : const SizedBox()
            : listBox(nameList[index]);
      },
    );
  }

  Widget listBox(String name) {
    return GestureDetector(
      onTap: () => _focusNode.unfocus(),
      child: Container(
        height: 110,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 0,
              spreadRadius: 0.1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                SizedBox(
                  width: 58,
                  height: 58,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'assets/images/person.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: const Color(0xff2F4EFF),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$name\n',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const TextSpan(
                    text: '평균 1시간내 답장',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Material(
                color: const Color(0xff2F4EFF).withOpacity(0.8),
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: () {
                    _showBottomSheet(name: name);
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Center(
                    child: Image.asset(
                      'assets/icons/connect_white.png',
                      width: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
