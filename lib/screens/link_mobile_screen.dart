import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:velocity_x/velocity_x.dart';

import '../constants/firebase_const.dart';

import '../controllers/link_controller.dart';

class LinkMobileScreen extends StatefulWidget {
  const LinkMobileScreen({Key? key}) : super(key: key);

  @override
  State<LinkMobileScreen> createState() => _LinkMobileScreenState();
}

class _LinkMobileScreenState extends State<LinkMobileScreen> {
  var controller = Get.put(LinkController());
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    auth.authStateChanges().listen((user) {
      currentuser = user;
    });
    final node = FocusScope.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Image.asset('assets/image/Rewaysamplelogogreen.png',
                      height: 275, width: 275, alignment: Alignment.topCenter),
                ),
                "Link Phone Number"
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
                              child:Row(
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
                              //   if (controller.isOtpSent.value == false) {
                              //     controller.isOtpSent.value = true;
                              //     await controller.sendOtp();
                              //   } else {
                              //     await controller.linkWithPhoneNumber(context);
                              //   }
                              // },
                              try {
                                if (controller.isOtpSent.value == false) {
                                  controller.isOtpSent.value = true;
                                  await controller.sendOtp();
                                } else {
                                  await controller
                                      .linkWithPhoneNumber(context)
                                      .then((value) {
                                    return controller.storePhoneData(context);
                                  }).then((value) {
                                    VxToast.show(context,
                                        msg: "Phone Number Linked");
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
