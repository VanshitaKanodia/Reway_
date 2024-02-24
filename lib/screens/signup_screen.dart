// ignore_for_file: avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reway/services/firebase_messaging_services.dart';

import 'package:velocity_x/velocity_x.dart';
import '../constants/firebase_const.dart';

import '../controllers/auth_controller.dart';
import '../utils/style_constants.dart';
import 'home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var controller = Get.put(Authcontroller());

  final databaseReference = FirebaseDatabase.instance.ref('details');
  bool val = false;
  bool selectedScreen = true;
  @override
  Widget build(BuildContext context) {
    auth.authStateChanges().listen((user) {
      currentuser = user;
    });
    var CompNamecontroller = TextEditingController();
    var emailcontroller = TextEditingController();
    var passwordcontroller = TextEditingController();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/image/img.png',
                  height: 100,
                  width: 100,
                  // fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Container(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedScreen = false;
                        });
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 24,
                            color: selectedScreen ? Colors.green : Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextField(
                          controller: CompNamecontroller,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.business,
                              color: Colors.green,
                            ),
                            hintStyle: kHintStyle,
                            hintText: 'Enter name of business/company',
                            labelText: 'Company/Business Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          height: 27,
                        ),
                        TextField(
                          controller: emailcontroller,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.green,
                            ),
                            hintStyle: kHintStyle,
                            hintText: 'Enter your Username',
                            labelText: 'Username',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          height: 27,
                        ),
                        TextField(
                          controller: passwordcontroller,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.key,
                              color: Colors.green,
                            ),
                            hintStyle: kHintStyle,
                            hintText: 'Enter your password',
                            labelText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          height: 27,
                        ),
                        20.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            "already have an account? ".text.size(16).make(),
                            "Login".text.bold.size(16).blue400.make().onTap(() {
                              Get.back();
                            })
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0, left: 10, right: 0, bottom: 9),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(
                        () => Checkbox(
                          value: controller.ischecked.value,
                          onChanged: (value) {
                            controller.ischecked.value = value ?? false;
                          },
                        ),
                      ),
                      const Text(
                        'I agree with the ',
                        style: TextStyle(fontSize: 15),
                      ),
                      const Text(
                        'T&C ',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 24, 121, 37)),
                      ),
                      const Text(
                        'and ',
                        style: TextStyle(fontSize: 15),
                      ),
                      const Text(
                        'Privacy Policy',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 24, 121, 37)),
                      ),
                    ],
                  ),
                ),
              ),
              30.heightBox,
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                        child: Obx(
                      () => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            backgroundColor: controller.ischecked.value
                                ? Colors.green
                                : Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    controller.ischecked.value ? 12 : 1))),
                        onPressed: () async {
                          if (controller.ischecked.value) {
                            try {
                              await controller
                                  .signupMethod(
                                      context: context,
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text)
                                  .then((value) {
                                return controller.storeUserData(
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text,
                                  name: CompNamecontroller.text,
                                );
                              }).then((value) {
                                VxToast.show(context,
                                    msg: "User Registered, Signed In");
                                Get.offAll(() => Home());
                              }).then((value) {
                                FirebaseMessages.setRecyclerToken();
                              });
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                return VxToast.show(context,
                                    msg: 'The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                return VxToast.show(context,
                                    msg:
                                        'The account already exists for that Username.');
                              }
                            }
                          } else {
                            return VxToast.show(context,
                                msg:
                                    "Please agree to our T&C and Privacy Policy ");
                          }
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 22.5),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
