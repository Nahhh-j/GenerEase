import 'package:flutter/material.dart';

import 'package:generease/app/ui/widget/button.dart';

class ApplyDetailScreen extends StatelessWidget {
  const ApplyDetailScreen({super.key});

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
              // TextFormField(
              //   decoration: InputDecoration(
              //     prefixIcon: Container(
              //       padding: const EdgeInsets.all(14),
              //       child: Image.asset('assets/icons/person_grey.png'),
              //     ),
              //     hintText: '이름',
              //     hintStyle: const TextStyle(
              //       color: Color(0xffA4A4A4),
              //       fontSize: 14,
              //     ),
              //     contentPadding: EdgeInsets.zero,
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: const BorderSide(color: Color(0xffDBDBDB)),
              //       borderRadius: BorderRadius.circular(18),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: const BorderSide(color: Color(0xffDBDBDB)),
              //       borderRadius: BorderRadius.circular(18),
              //     ),
              //   ),
              //   cursorColor: Colors.grey,
              //   controller: nameCtrl,
              //   keyboardType: TextInputType.text,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
