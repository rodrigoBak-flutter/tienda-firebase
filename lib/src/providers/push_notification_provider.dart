import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

//Token = enTsjSIkk18:APA91bHi9FnaZjQeG3NsqRh9Wf8oZjQJFNAdCpJ1byR25WrS8vBRwa8R6-gb37pgW3Q1B9ZW398xyPSNhx8TTiEHr-PPeHgMbrMBIST7oGAY5JnkT2hKszlsS-bw-U2zFR4yPGmrnwBe
class PushNotificationsProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast();

  Stream<String> get mensajesStream => _mensajesStreamController.stream;

  static Future<dynamic> onBackgroundMessage(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  initNotifications() async {
    await _firebaseMessaging.requestNotificationPermissions();
    final token = await _firebaseMessaging.getToken();

    //print('==== FCM Token ======');
    //print(token);

    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage:
          Platform.isIOS ? null : PushNotificationsProvider.onBackgroundMessage,
      onLaunch: onLaunch,
      onResume: onResume,
    );
  }

  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    // print('====== onMessage ====== ');
    // print('message: $message');
    // print('argumento: $argumento');
    String argumento = 'no-data';

    if (Platform.isAndroid) {
      argumento = message['data']['talleres'] ?? 'no-data';
    } else {
      argumento = message['talleres'] ?? 'no-data';
    }

    _mensajesStreamController.sink.add(argumento);
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    // print('====== onLaunch ====== ');
    // print('message: $message');
    // print('argumento: $argumento');
    String argumento = 'no-data';

    if (Platform.isAndroid) {
      argumento = message['data']['talleres'] ?? 'no-data';
    } else {
      argumento = message['talleres'] ?? 'no-data';
    }

    _mensajesStreamController.sink.add(argumento);
  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
    // print('====== onResume ====== ');
    // print('message: $message');
    // print('argumento: $argumento');
    String argumento = 'no-data';

    if (Platform.isAndroid) {
      argumento = message['data']['talleres'] ?? 'no-data';
    } else {
      argumento = message['talleres'] ?? 'no-data';
    }

    _mensajesStreamController.sink.add(argumento);
  }

  dispose() {
    _mensajesStreamController?.close();
  }
}
