import 'package:client_shop/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  static final routeName = 'notification_screen';
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  List<Message> messages = [];
  @override
  void initState() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure(
      // onBackgroundMessage: (Map<String, dynamic> message) async {
      //   print("OnBgMessage: $message");
      // },
      onLaunch: (Map<String, dynamic> message) async {
        print("OnLaunch: $message");
      },
      onMessage: (Map<String, dynamic> message) async {
        print("OnMessage: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(
            Message(
              title: notification['title'],
              body: notification['body'],
            ),
          );
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("OnResume: $message");
      },
    );
    printToken();
    super.initState();
  }

  Future<void> printToken() async {
    String token = await _firebaseMessaging.getToken();
    print("token is: $token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Screen'),
      ),
      body: ListView(
        children: messages
            .map((e) => ListTile(
                  title: Text(e.title),
                  subtitle: Text(e.body),
                ))
            .toList(),
      ),
    );
  }
}
