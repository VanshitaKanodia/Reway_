import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:reway/screens/login_screen_with_mobile.dart';

class OtpVerificationScreen extends StatefulWidget {
  final mobileNumber;
  const OtpVerificationScreen({super.key, this.mobileNumber});

  @override
  OtpVerificationScreenState createState() => OtpVerificationScreenState();
}

class OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  var code = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Verification"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              'Phone Number Verification',
              style:
              GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Please enter the code sent to +91 ${widget.mobileNumber} ',
              style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.4)),
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(child: darkRoundedPinPut()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't receive the code? ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 113, 113, 113)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Resend',
                        style: TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 29, 93, 158))),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try
                {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: LoginWithMobile.verify, smsCode: code);

                  // Sign the user in (or link) with the credential
                  await _auth.signInWithCredential(credential);
                  Navigator.pushNamed(context, '/home');
                  print('Correct otp');
                }
                catch(e)
                {
                  print('Wrong otp');
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'VERIFY AND LOGIN',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  Widget darkRoundedPinPut() {
    return Pinput(
      onChanged: (value)
      {
        code = value;
      },
      length: 6,
      keyboardType: TextInputType.number,
      controller: otpController,
      textInputAction: TextInputAction.next,
      showCursor: true,
      onCompleted: null,
    );
  }
}
