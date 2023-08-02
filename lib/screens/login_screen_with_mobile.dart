import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:reway/services/firebase_messaging_services.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/firebase_const.dart';
import '../controllers/auth_controller.dart';
import '../services/google_auth_service.dart';

class LoginWithMobile extends StatefulWidget {
  const LoginWithMobile({Key? key}) : super(key: key);

  @override
  State<LoginWithMobile> createState() => _LoginWithMobileState();
}

class _LoginWithMobileState extends State<LoginWithMobile> {
  var controller = Get.put(Authcontroller());
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    auth.authStateChanges().listen((user) {
      currentuser = user;
    });
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Image.asset('assets/image/Rewaysamplelogogreen.png',
                      height: 275, width: 275, alignment: Alignment.topCenter),
                ),
                "Login With Phone Number"
                    .text
                    .bold
                    .color(Vx.green700)
                    .size(16)
                    .make(),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 45,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 20),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your Number";
                              } else if (value.length < 10) {
                                return "Number should be of 10 digits";
                              }
                              return null;
                            },
                            controller: controller.mobileController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Vx.gray400,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Vx.gray400,
                                  )),
                              prefixIcon: const Icon(
                                Icons.call,
                                color: Colors.green,
                              ),
                              labelText: "Phone Number",
                              prefixText: "+91",
                              hintText: "Enter your phone number",
                              labelStyle: const TextStyle(
                                color: Vx.gray600,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        30.heightBox,
                        Obx(
                          () => Visibility(
                            visible: controller.isOtpSent.value,
                            child: Text(
                              "Enter Otp",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Obx(
                          () => Visibility(
                            visible: controller.isOtpSent.value,
                            child: SizedBox(
                              height: 80,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: context.screenWidth - 230,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter your Number";
                                          } else if (value.length < 10) {
                                            return "Number should be of 10 digits";
                                          }
                                          return null;
                                        },
                                        controller: controller.otpcontroller,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: const BorderSide(
                                                color: Vx.gray400,
                                              )),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: const BorderSide(
                                                color: Vx.gray400,
                                              )),
                                          labelStyle: const TextStyle(
                                            color: Vx.gray600,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                if (controller.isOtpSent.value == false) {
                                  controller.isOtpSent.value = true;
                                  await controller.sendOtp();
                                } else {
                                  await controller
                                      .verifyOtp(context)
                                      .then((value) {
                                    return controller.storePhoneData(context);
                                  }).then((value) {
                                    VxToast.show(context,
                                        msg: "Logged in with Phone Number");
                                  }).then((value) {
                                    FirebaseMessages.setRecyclerToken();
                                  });
                                }
                              } on FirebaseAuthException catch (e) {
                                VxToast.show(context, msg: e.toString());
                              }
                            },
                            child: Obx(
                              () => Padding(
                                padding: EdgeInsets.all(10.0),
                                child: controller.isOtpSent.value
                                    ? Text(
                                        'Continue',
                                        style: TextStyle(fontSize: 15),
                                      )
                                    : Text(
                                        'Send OTP',
                                        style: TextStyle(fontSize: 15),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                              onPressed: () async {
                                signInWithGoogle(context, () {
                                  Navigator.pushNamed(context, '/home');
                                }).then((value) {
                                  controller.storeGoogleData(
                                      context: context, email: googleEmail);
                                }).then((value) {
                                  FirebaseMessages.setRecyclerToken();
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  fixedSize: const Size(60, 60)),
                              child: Image.network(
                                  'http://pngimg.com/uploads/google/google_PNG19635.png',
                                  fit: BoxFit.cover),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            const Text('or'),
                            const SizedBox(
                              width: 40,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/');
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                fixedSize: const Size(60, 60),
                              ),
                              child: const FaIcon(
                                FontAwesomeIcons.circleUser,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 113, 113, 113)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/second');
                              },
                              child: const Text('Sign Up',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 29, 93, 158))),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
