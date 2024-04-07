import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification/notification_services.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.setupInteractMessage(context);
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('Device Token');
      }
      if (kDebugMode) {
        print(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Notifications'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            notificationServices.getDeviceToken().then((value) async {
              var data = {
                'to': 'dvopwyuiQyevVQMNJPodzp:APA91bHr0c5QZ2Vcxkvq0aQfFNLHUr-tHXe8JMI_y-YOjdVbLIsxhHWlmbTSPgMX0GYF__9LUOAFWok95WAaOgb00DOIJipys07-44Fd8qWROV4EMLWE8UB7z0FrbexNiImEX4l8iKo1',
                'priority': 'high',
                'notification': {'title': 'Ash', 'body': 'Hi There'},
                'data' : {'type' : 'msg' , 'id' : '123456'}
              };
              await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
                  body: jsonEncode(data),
                  headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                    'Authorization':
                        'key=AAAAw14YQ5g:APA91bEy6ycEnz2VU-8t3uVtGGNuvpcoeoVKzPxald0CoIwlNfh_A2IDyGuS2WoavP8GoxpiUZIdI5rilS1vE73YN4ZCNEu9FqpypxlveobsBdhKZNRoNj0h7212T_8kj64yVQP18h85'
                  });
            });
          },
          child: const Text('Send Notification'),
        ),
      ),
    );
  }
}
