import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:ninedot_task/utils/shared_prefs.dart';

String? token;

class AppNotificationHandler {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
  );

  ///get fcm token
  static Future getFcmToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    try {
      token = await firebaseMessaging.getToken();
      preferences.putString(SharedPreference.fcmToken, token.toString());
      log("=========fcm-token===$token");
      return token;
    } catch (e) {
      log("=========fcm- Error :$e");
      return null;
    }
  }

  ///call when app in fore ground
  static void showMsgHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      RemoteNotification? notification = message!.notification;
      log('Notification Call :${notification!.titleLocKey}');

      if (message.data.isNotEmpty) {
        String type = message.data['type'];
        if (type == "true") {
          Future.delayed(const Duration(seconds: 30), () {
            showMsg(notification);
          });
        } else {
          showMsg(notification);
        }
      }
    });
  }

  /// handle notification when app in fore ground..///close app
  static void getInitialMsg() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      log('------RemoteMessage message------$message');
    });
  }

  ///show notification msg
  static void showMsg(RemoteNotification notification) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      '${notification.title}',
      '${notification.body}',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_channel',
          'High Importance Notifications',
          importance: Importance.max,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  ///background notification handler..
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    log('Handling a background message ${message.data}');
  }

  ///call when click on notification back
  static void onMsgOpen() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('A new onMessageOpenedApp event was published!');
      log('listen->${message.data}');
    });
  }

  /// send notification device to device
  static Future<bool?> sendMessage({
    String? message,
    String? receiverFcmToken,
    bool isLater = false,
  }) async {
    try {
      const url =
          "https://fcm.googleapis.com/v1/projects/task-ninedot/messages:send";
      http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${preferences.getString(SharedPreference.accessAuthToken)}',
        },
        body: jsonEncode(
          <String, dynamic>{
            'message': {
              'token': receiverFcmToken,
              'notification': {
                'title': 'Hello!!!',
                'body': message,
              },
              "data": {
                "type": "$isLater"
              }
            }
          },
        ),
      );
      log("RESPONSE CODE ${response.statusCode}");
      log("RESPONSE BODY ${response.body}");
    } catch (e) {
      log("error push notification");
    }
    return null;
  }

  ///Get Access Token
  static Future getAccessToken() async {
    try {
      final serviceAccountKey =
          await rootBundle.loadString('assets/key/firebase_key.json');
      final accountCredentials = ServiceAccountCredentials.fromJson(
        json.decode(serviceAccountKey),
      );
      final scopes = ['https://www.googleapis.com/auth/cloud-platform'];
      final authClient =
          await clientViaServiceAccount(accountCredentials, scopes);
      final accessToken = authClient.credentials.accessToken.data;
      preferences.putString(
          SharedPreference.accessAuthToken, accessToken.toString());
      authClient.close();
      return accessToken;
    } catch (e) {
      log("=========AccessToken---Error :$e");
      return null;
    }
  }
}
