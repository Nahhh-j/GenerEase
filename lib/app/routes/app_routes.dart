import 'package:generease/app/binding/base_binding.dart';
import 'package:get/get.dart';

import 'package:generease/app/ui/screen/sign/login_screen.dart';
import 'package:generease/app/ui/screen/base_screen.dart';

abstract class Routes {
  static String LOGIN = '/login';
  static String BASE = '/base';
}

class AppPages {
  static List<GetPage> pages = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.BASE,
      page: () => const BaseScreen(),
      binding: BaseBinding(),
    ),
  ];
}
