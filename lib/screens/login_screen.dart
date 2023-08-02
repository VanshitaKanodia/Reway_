import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:reway/services/firebase_messaging_services.dart';
import 'package:reway/services/google_auth_service.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/firebase_const.dart';
import '../controllers/auth_controller.dart';
import '../custom/exit_dialog.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

//
class _LoginScreenState extends State<LoginScreen> {
  var controller = Get.put(Authcontroller());
  @override
  Widget build(BuildContext context) {
    auth.authStateChanges().listen((user) {
      currentuser = user;
    });
    final _formKey = GlobalKey<FormState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: WillPopScope(
        onWillPop: () async {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => exitDialog(context));
          return false;
        },
        child: Scaffold(
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
                        height: 275, width: 285, alignment: Alignment.center),
                  ),
                  FaIcon(
                    FontAwesomeIcons.circleUser,
                    size: 55,
                    color: Color.fromARGB(255, 24, 121, 37).withOpacity(0.8),
                  ),
                  10.heightBox,
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: controller.emailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your username";
                                } else if (value.length < 6) {
                                  return "Username cannot be less than 6 characters";
                                }
                                return null;
                              },
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
                                  Icons.person,
                                  color: Colors.green,
                                ),
                                labelText: "Username",
                                hintText: "Enter your Username",
                                labelStyle: const TextStyle(
                                  color: Vx.gray600,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            10.heightBox,
                            TextFormField(
                              controller: controller.passController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your Password";
                                } else if (value.length < 6) {
                                  return "password cannot be less than 6 digits";
                                }
                                return null;
                              },
                              obscureText: true,
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
                                  Icons.key,
                                  color: Colors.green,
                                ),
                                labelText: "Password",
                                hintText: "Enter your Password",
                                labelStyle: const TextStyle(
                                  color: Vx.gray600,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: ElevatedButton(
                                onPressed: () async {
                                  await controller
                                      .loginWithEmailPass(context: context)
                                      .then((value) {
                                    if (value != null) {
                                      VxToast.show(context, msg: "Logged in");
                                      Get.offAll(() => Home());
                                    }
                                  }).then((value) {
                                    FirebaseMessages.setRecyclerToken();
                                  });
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'LOG IN',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                            20.heightBox,
                            " Other Login Options:-".text.size(16).make(),
                            10.heightBox,
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  OutlinedButton(
                                    onPressed: () async {
                                      signInWithGoogle(context, () {
                                        Navigator.pushNamed(context, '/home');
                                      }).then((value) {
                                        controller.storeGoogleData(
                                            context: context,
                                            email: googleEmail);
                                      }).then((value) {
                                        FirebaseMessages.setRecyclerToken();
                                      });
                                      ;
                                    },
                                    style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        fixedSize: const Size(60, 60)),
                                    child: Image.asset(
                                        "assets/image/google.png",
                                        fit: BoxFit.cover),
                                  ),
                                  const SizedBox(
                                    width: 40,
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/login_with_mobile');
                                    },
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                      fixedSize: const Size(60, 60),
                                    ),
                                    child: const FaIcon(
                                      FontAwesomeIcons.mobileScreenButton,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 113, 113, 113)),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pushNamed(context, '/second');
                                    },
                                    child: const Text('Sign Up',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color.fromARGB(
                                                255, 29, 93, 158))),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
