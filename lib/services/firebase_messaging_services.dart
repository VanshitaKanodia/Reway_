import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

import '../constants/firebase_const.dart';

class FirebaseMessages {
   static var  token;
  static FirebaseMessaging FMessaging = FirebaseMessaging.instance;

  static Future<void> getFirebaseMessagingToken() async {
    await FMessaging.requestPermission();

    await FMessaging.getToken().then((t) => {
          if (t != null) {
            log('Push token: $t'),
            token = t,
            }
        });
  }

  static Future<void> sendNotification({ required String token, String? title,String? msg}) async {
    try {
      var url = Uri.parse("https://fcm.googleapis.com/fcm/send");
      final body = {
        "to":
            token,
        "notification": {
          "title":title,
          "body": msg
        }
      };

      var res = await http.post(url, body: jsonEncode(body), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader:
            'key=AAAAQMM2qH4:APA91bFzSZ6MBO4FH7ma96x9YmLXaI0jEneH9s57jFTSj_uJvJzxAgQ2oWxlFhwgPIKrUBWJ1-UpIx3HhCI3qav2FlmG8y0KsxKkSztEg-oYLStSRHLJdnGNovgzvrQWzU7rk4Qc4TSD'
      });
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushnotificationE: $e');
    }
  }

static setRecyclerToken() async {
    final databaseReference = FirebaseDatabase.instance.ref(recyclersCollection);
    await databaseReference.child(currentuser!.uid).update({'push_token': '$token'});
  }
}