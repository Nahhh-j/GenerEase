import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPageController extends GetxController {
  FlutterLocalNotificationsPlugin localNoti = FlutterLocalNotificationsPlugin();

  RxInt index = 0.obs;

  void requestPermissions() async {
    if (await Permission.notification.isDenied &&
        !await Permission.notification.isPermanentlyDenied) {
      await [Permission.notification].request();
    }
  }

  void init() async {
    AndroidInitializationSettings android =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    DarwinInitializationSettings ios = const DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    InitializationSettings settings =
        InitializationSettings(android: android, iOS: ios);

    await localNoti.initialize(settings);
  }

  @override
  void onInit() {
    super.onInit();

    requestPermissions();
    init();
  }
}
