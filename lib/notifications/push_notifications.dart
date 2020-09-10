import 'package:client_shop/models/message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationManager {
  PushNotificationManager._();

  factory PushNotificationManager() => _instance;

  static final PushNotificationManager _instance = PushNotificationManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  bool _initialized = false;
  List<Message> messages = [];
  Future<void> init() async {
    if (!_initialized) {
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure(
        onBackgroundMessage: (Map<String, dynamic> message) async {
          print("OnBgMessage: $message");
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("OnLaunch: $message");
        },
        onMessage: (Map<String, dynamic> message) async {
          print("OnMessage: $message");
        },
        onResume: (Map<String, dynamic> message) async {
          print("OnResume: $message");
        },
      );

      String token = await _firebaseMessaging.getToken();
      print("token is: $token");
      _initialized = true;
    }
  }

  List<Message> get messageList {
    return messages;
  }

  Future<void> sendNotification() async {
    // _firebaseMessaging.
  }
}
