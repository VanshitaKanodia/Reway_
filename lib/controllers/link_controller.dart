import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/firebase_const.dart';

class LinkController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  var mobileController = TextEditingController();
  var otpcontroller = TextEditingController();
  var ischecked = false.obs;
  var isOtpSent = false.obs;
  var formKey = GlobalKey<FormState>();

  get firestore => null;

  late final PhoneVerificationCompleted phoneVerificationCompleted;
  late final PhoneVerificationFailed phoneVerificationFailed;
  late PhoneCodeSent phoneCodeSent;
  String verificationID = "";

  sendOtp() async {
    phoneVerificationCompleted = (PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
    };
    phoneVerificationFailed = (FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }
    };
    phoneCodeSent = (String verificationId, int? resendToken) {
      verificationID = verificationId;
    };

    try {
      String phoneNumber = "+91${mobileController.text.toString()}";
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print(e.toString());
    }
  }

  //link mobiole number

  Future<void> linkWithPhoneNumber(BuildContext context) async {
    String otp = "";

    otp = otpcontroller.text;

    // Sign in with phone number
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId:
          verificationID, // Pass the verificationId from the OTP verification process
      smsCode: otp,
    );

    // Link phone number credential to the current user account
    User? user = _auth.currentUser;

    if (user != null) {
      await user.linkWithCredential(credential);
      Navigator.pop(context);
      update();
    }
  }

  //link Email and Password with the existing Account
  Future<void> linkWithEmailPass(
      BuildContext context, String email, String password) async {
    // Sign in with email/password
    final AuthCredential credential = EmailAuthProvider.credential(
      email: "${email}@email.com",
      password: password,
    );

    // Link email/password credential to the current user account
    User? user = _auth.currentUser;
    if (user != null) {
      await user.linkWithCredential(credential);
    }
  }

  storeUserData({name, password, email}) async {
    final databaseReference = FirebaseDatabase.instance.ref(recyclersCollection);

    await databaseReference.child(currentuser!.uid).update({
      'Recycler_Name': name,
      'password': password,
       'image_url':'',
      'Username': email,
      'id': currentuser!.uid,
    });
  }

  storePhoneData(context) async {
    final databaseReference = FirebaseDatabase.instance.ref(recyclersCollection);

    Map<String, dynamic> updatedData = {
      'phone_no': mobileController.text,
       'image_url':'',
      'id': currentuser!.uid,
    };
    await databaseReference.child(currentuser!.uid).update(updatedData);
  }

  storeGoogleData({context, email}) async {
    final databaseReference = FirebaseDatabase.instance.ref(recyclersCollection);

    Map<String, dynamic> updatedData = {
       'image_url':'',
      'Email': email,
    };
    await databaseReference.child(currentuser!.uid).update(updatedData);
  }
}
