import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:push_notification_sample/main.dart';

class FirebaseApi {
  //create an instance of firebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  //Initialize notifications
  Future<void> initNotifications() async {
    //request permission
    await _firebaseMessaging.requestPermission();

    //fetch the FCM token for this device
    final fcmToken = await _firebaseMessaging.getToken();

    //print the token
    debugPrint("Token: $fcmToken");

    initPushNotifications();
  }

  //Handle received messages
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    //Navigate to the new screen when the message is received and user taps.
    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );
  }

  //Initialize background and foreground settings
  Future initPushNotifications() async {
    //handle notification if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    //Attach event listeners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
