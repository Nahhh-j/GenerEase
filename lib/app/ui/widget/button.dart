import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final Function() onLongPress;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final String text;
  final TextStyle? textStyle;

  const CustomButton({
    Key? key,
    required this.onTap,
    required this.onLongPress,
    this.margin,
    this.color,
    this.borderRadius,
    this.width,
    this.height,
    required this.text,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(0),
      child: Material(
        color: color ?? Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: borderRadius,
          child: SizedBox(
            width: width,
            height: height,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                text,
                style: textStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomBackButton extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final Function()? onTap;

  const CustomBackButton({
    Key? key,
    this.margin,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap ??
              () {
                FocusManager.instance.primaryFocus?.unfocus();
                Get.back();
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
                Icons.arrow_back_ios_new,
                color: Color(0xff121212),
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
