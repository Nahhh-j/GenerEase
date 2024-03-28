import 'package:flutter/material.dart';
import 'package:generease/app/ui/widget/button.dart';

class ApplyScreen extends StatefulWidget {
  const ApplyScreen({super.key});

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController workCtrl = TextEditingController();
  TextEditingController timeCtrl = TextEditingController();
  TextEditingController motiveCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    emailCtrl.addListener(() {
      setState(() {});
    });

    workCtrl.addListener(() {
      setState(() {});
    });

    timeCtrl.addListener(() {
      setState(() {});
    });

    motiveCtrl.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    workCtrl.dispose();
    timeCtrl.dispose();
    motiveCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                        '도우미 신청',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color(0xff2F4EFF),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Icon(
                              Icons.person_outline,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                          Material(
                            color: const Color(0xff474747),
                            borderRadius: BorderRadius.circular(50),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {
                                print('tap');
                              },
                              child: Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Icon(
                                  Icons.image,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 58,
                        margin: const EdgeInsets.only(top: 10, bottom: 5),
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(20),
                            prefixIcon: Icon(Icons.email),
                            hintText: '이메일',
                            hintStyle: const TextStyle(
                              color: Color(0xffA4A4A4),
                              fontSize: 14,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xffDBDBDB),
                                width: 1.5,
                              ),
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
                          // focusNode: focusNode1,
                          controller: emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {},
                        ),
                      ),
                      Container(
                        height: 58,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(20),
                            prefixIcon: Icon(Icons.email),
                            hintText: '학교/직장',
                            hintStyle: const TextStyle(
                              color: Color(0xffA4A4A4),
                              fontSize: 14,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xffDBDBDB),
                                width: 1.5,
                              ),
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
                          // focusNode: focusNode1,
                          controller: workCtrl,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {},
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 58,
                          margin: const EdgeInsets.only(bottom: 5),
                          padding: const EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xffDBDBDB),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/icons/case.png',
                                width: 19.5,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                '근무(재학) 여부',
                                style: TextStyle(color: Color(0xffA4A4A4)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 58,
                          margin: const EdgeInsets.only(bottom: 5),
                          padding: const EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xffDBDBDB),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/icons/fire.png',
                                width: 15,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                '예약 전문 분야',
                                style: TextStyle(color: Color(0xffA4A4A4)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 58,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(20),
                            prefixIcon: Icon(Icons.email),
                            hintText: '예상 활동(답변) 시간',
                            hintStyle: const TextStyle(
                              color: Color(0xffA4A4A4),
                              fontSize: 14,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xffDBDBDB),
                                width: 1.5,
                              ),
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
                          // focusNode: focusNode1,
                          controller: timeCtrl,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {},
                        ),
                      ),
                      Container(
                        height: 58,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(20),
                            prefixIcon: Icon(Icons.email),
                            hintText: '지원동기',
                            hintStyle: const TextStyle(
                              color: Color(0xffA4A4A4),
                              fontSize: 14,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xffDBDBDB),
                                width: 1.5,
                              ),
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
                          // focusNode: focusNode1,
                          controller: motiveCtrl,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                CustomButton(
                  onTap: () {},
                  onLongPress: () {},
                  text: '도우미 지원하기',
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  height: 58,
                  color: const Color(0xff2F4EFF),
                  borderRadius: BorderRadius.circular(18),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    '자주 묻는 질문 확인하기',
                    style: TextStyle(
                      color: Color(0xffA4A4A4),
                      decoration: TextDecoration.underline,
                    ),
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
