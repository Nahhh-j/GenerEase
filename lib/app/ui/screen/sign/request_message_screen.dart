import 'package:flutter/material.dart';
import 'package:generease/app/ui/screen/sign/certification_screen.dart';
import 'package:generease/app/ui/widget/button.dart';
import 'package:get/get.dart';

class RequestMessageScreen extends StatefulWidget {
  const RequestMessageScreen({super.key});

  @override
  State<RequestMessageScreen> createState() => _RequestMessageScreenState();
}

class _RequestMessageScreenState extends State<RequestMessageScreen> {
  Map<String, dynamic> arguments = Get.arguments;
  late String kind;

  final FocusNode _focusNode = FocusNode();

  TextEditingController phoneNumberCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    kind = arguments['kind'];

    phoneNumberCtrl.addListener(() {
      setState(() {});
    });

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    phoneNumberCtrl.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _focusNode.unfocus(),
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
                            '안녕하세요!',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 29,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        kind == 'register'
                            ? const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '휴대폰 번호로 가입해주세요.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 29,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            : const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '가입한 휴대폰 번호를\n입력해주세요.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 29,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                        kind == 'register'
                            ? const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '휴대폰 번호는 안전하게 보관되며, 공개되지 않아요.',
                                  style: TextStyle(color: Color(0xffA4A4A4)),
                                ),
                              )
                            : const SizedBox(),
                        Container(
                          height: 47,
                          margin: const EdgeInsets.only(top: 30),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Container(
                                padding: const EdgeInsets.all(14),
                                child: Image.asset('assets/icons/call.png'),
                              ),
                              hintText: '휴대폰 번호(-없이 숫자만 입력)',
                              hintStyle:
                                  const TextStyle(color: Color(0xffA4A4A4)),
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffDBDBDB)),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xffDBDBDB),
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              counterText: '',
                            ),
                            focusNode: _focusNode,
                            cursorColor: Colors.grey,
                            controller: phoneNumberCtrl,
                            keyboardType: TextInputType.number,
                            maxLength: 11,
                          ),
                        ),
                        CustomButton(
                          onTap: () {
                            _focusNode.unfocus();

                            if (phoneNumberCtrl.value.text == '') {
                              print('아무것도 입력 안함');
                            } else {
                              Get.to(() => const CertificationScreen());
                              // todo 인증문자 받기
                            }
                          },
                          onLongPress: () {},
                          height: 58,
                          margin: const EdgeInsets.only(
                            top: 20,
                            bottom: 10,
                          ),
                          color: const Color(0xff2F4EFF),
                          borderRadius: BorderRadius.circular(18),
                          text: '인증문자 받기',
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        Row(
                          children: [
                            kind == 'register'
                                ? const Text(
                                    '이미 계정이 있나요?',
                                    style: TextStyle(color: Color(0xffA4A4A4)),
                                  )
                                : const Text(
                                    '아직 계정이 없으신가요?',
                                    style: TextStyle(color: Color(0xffA4A4A4)),
                                  ),
                            kind == 'register'
                                ? GestureDetector(
                                    onTap: () {
                                      _focusNode.unfocus();

                                      setState(() {
                                        kind = 'login';
                                        phoneNumberCtrl.text = '';
                                      });
                                      // FocusManager.instance.primaryFocus?.unfocus();
                                    },
                                    child: const Text(
                                      ' 로그인',
                                      style: TextStyle(
                                        color: Color(0xff2F4EFF),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      _focusNode.unfocus();

                                      setState(() {
                                        kind = 'register';
                                        phoneNumberCtrl.text = '';
                                      });
                                      // FocusManager.instance.primaryFocus?.unfocus();
                                    },
                                    child: const Text(
                                      ' 회원가입',
                                      style: TextStyle(
                                        color: Color(0xff2F4EFF),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                          ],
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
