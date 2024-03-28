import 'package:flutter/material.dart';
import 'package:generease/app/ui/widget/button.dart';
import 'package:get/get.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
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
                      '예약 관리',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: '예약은 최대 2개까지 가능합니다.\n',
                      style: TextStyle(
                        color: Color(0xffA4A4A4),
                        fontSize: 12,
                      ),
                    ),
                    TextSpan(
                      text: '상담 완료 후, ',
                      style: TextStyle(
                        color: Color(0xffA4A4A4),
                        fontSize: 12,
                      ),
                    ),
                    TextSpan(
                      text: '7일이 지나면 ',
                      style: TextStyle(
                        color: Color(0xffA4A4A4),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '자동으로 예약확정이 됩니다.',
                      style: TextStyle(
                        color: Color(0xffA4A4A4),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              _box(
                consultingDate: '2024.01.01',
                profileImagePath: 'assets/images/person.png',
                name: '조나희',
                kind: '스포츠',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _box({
    required String consultingDate,
    required String profileImagePath,
    required String name,
    required String kind,
  }) {
    return Container(
      height: 300,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 1,
            spreadRadius: 1,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '$consultingDate >',
              style: const TextStyle(
                color: Color(0xff5F5F5F),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                margin: const EdgeInsets.only(
                  top: 20,
                  right: 20,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    profileImagePath,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$name\n',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: '$kind 예약',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
