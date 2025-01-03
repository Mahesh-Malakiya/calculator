
// class FirebaseNotificationService extends GetxService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   String? token;
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<FirebaseNotificationService> init() async {
//     await _initializeFirebaseMessaging();
//     return this;
//   }

// // get token
//   Future<String?> getFcmToken() async {
//     final token = await _firebaseMessaging.getToken();
//     appPrint('_firebaseMessaging_Token: $token');
//     if (token != null) {
//       await AppPreference.addStringToSF(Constants.fcmToken, token);
//     }
//     return token;
//   }

//   //refresh token

//   Future<String?> refreshFcmToken() async {
//     _firebaseMessaging.onTokenRefresh.listen((token) async {
//       appPrint('refresh__firebaseMessaging_Token: $token');
//       await AppPreference.addStringToSF(Constants.fcmToken, token);
//     });
//     return null;
//   }

//   Future<void> _initializeFirebaseMessaging() async {
//     // Request permissions for iOS
//     final settings = await _firebaseMessaging.requestPermission();
//     appPrint('User granted permission: ${settings.authorizationStatus}');

//     // Get the token
//     token = await _firebaseMessaging.getToken();
//     appPrint('FirebaseMessaging token: $token');

//     // Handle background messages
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//     // Handle foreground messages
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       appPrint('Got a message whilst in the foreground!');
//       appPrint('Message data: ${message.data}');

//       if (message.notification != null) {
//         appPrint(
//           'Message also contained a notification: ${message.notification}',
//         );
//         _showNotification(message.notification);

//         // Add the notification to the NotificationController
//         Get.put<NotificationController>(NotificationController())
//             .addNotification(message.notification!);
//       }
//     });

//     await initMessaging();
//   }

//   Future<void> initMessaging() async {
//     if (Platform.isAndroid) {
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>()!
//           .requestNotificationsPermission();
//       await FirebaseMessaging.instance
//           .setForegroundNotificationPresentationOptions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//     } else if (Platform.isIOS) {
//       final settings = await _firebaseMessaging.requestPermission();
//       if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//         appPrint('User granted permission');
//       } else {
//         appPrint('User declined or has not accepted permission');
//       }
//     }
//     await Permission.notification.request();

//     const initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//     );

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);

//     //
//   }

//   Future<void> _showNotification(RemoteNotification? notification) async {
//     if (notification != null) {
//       const androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'your_channel_id',
//         'your_channel_name',
//         channelDescription: 'your_channel_description',
//         importance: Importance.max,
//         priority: Priority.high,
//         showWhen: false,
//       );
//       const platformChannelSpecifics =
//           NotificationDetails(android: androidPlatformChannelSpecifics);
//       await flutterLocalNotificationsPlugin.show(
//         0,
//         notification.title,
//         notification.body,
//         platformChannelSpecifics,
//         payload: 'item x',
//       );
//     }
//   }

//   static Future<void> _firebaseMessagingBackgroundHandler(
//     RemoteMessage message,
//   ) async {
//     await Firebase.initializeApp();
//     appPrint('Handling a background message: ${message.messageId}');
//     await AppNotification.showBigTextNotification(
//       title: message.notification?.title ?? '',
//       body: message.notification?.body ?? '',
//       fln: FlutterLocalNotificationsPlugin(),
//     );
//   }
// }
