import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  OtpVerificationScreenState createState() => OtpVerificationScreenState();
}

class OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
              'Please enter the code sent to 9874569899 ',
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
              onPressed: () {},
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
      length: 5,
      keyboardType: TextInputType.number,
      controller: otpController,
      textInputAction: TextInputAction.next,
      showCursor: true,
      validator: (s) {
        print('validating code: $s');
        print(otpController.text);
      },
      onCompleted: null,
    );
  }
}
