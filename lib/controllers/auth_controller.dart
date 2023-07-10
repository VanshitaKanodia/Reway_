import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';
import '../constants/firebase_const.dart';

class Authcontroller extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  var mobileController = TextEditingController();
  TextEditingController otpcontroller = TextEditingController();
  var ischecked = false.obs;
  String googleEmail = '';
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

  verifyOtp(context) async {
    String otp = "";

    otp = otpcontroller.text;

    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: otp);

      //getting user
      final User? user =
          (await auth.signInWithCredential(phoneAuthCredential)).user;
    } catch (e) {
      print(e);
    }
  }

//signup method
  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: "${email}@email.com", password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        VxToast.show(context, msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        VxToast.show(context,
            msg: 'The account already exists for that email.');
      } else {
        VxToast.show(context, msg: e.toString());
      }
    }
    return userCredential;
  }

  //storing data method

  storeUserData({name, password, email}) async {
    final databaseReference =
        FirebaseDatabase.instance.ref(recyclersCollection);

    await databaseReference.child(currentuser!.uid).update({
      'Recycler_Name': name,
      'password': password,
      'Username': email,
      'id': currentuser!.uid,
    });
  }

  Future<UserCredential?> loginWithEmailPass({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: "${emailController.text}@email.com",
          password: passController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  Future<void> linkWithGoogle(BuildContext context) async {
    try {
      // Sign in with Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      googleEmail = googleUser.email;

      User? user = _auth.currentUser;
      if (user != null) {
        await user.linkWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        VxToast.show(context, msg: 'account-exists-with-different-credential');
        // Handle account merging here, if needed
        // You may want to prompt the user to link the accounts manually
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${e.message}')),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  storePhoneData(context) async {
    final databaseReference =
        FirebaseDatabase.instance.ref(recyclersCollection);

    Map<String, dynamic> updatedData = {
      'phone_no': mobileController.text,
      'id': currentuser!.uid,
    };
    await databaseReference.child(currentuser!.uid).update(updatedData);
  }

  storeGoogleData({context, email}) async {
    final databaseReference =
        FirebaseDatabase.instance.ref(recyclersCollection);

    Map<String, dynamic> updatedData = {
      'Email': email,
    };
    await databaseReference.child(currentuser!.uid).update(updatedData);
  }
}
