// ignore_for_file: avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:velocity_x/velocity_x.dart';

import '../constants/firebase_const.dart';
import '../controllers/link_controller.dart';
import '../utils/style_constants.dart';

class LinkEmailScreen extends StatefulWidget {
  const LinkEmailScreen({super.key});

  @override
  State<LinkEmailScreen> createState() => _LinkEmailScreenState();
}

class _LinkEmailScreenState extends State<LinkEmailScreen> {
  var controller = Get.put(LinkController());

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
        appBar: AppBar(),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        'Link Your Email',
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
                              Icons.mail,
                              color: Colors.green,
                            ),
                            hintStyle: kHintStyle,
                            hintText: 'Enter your email address',
                            labelText: 'Email',
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
                      ],
                    ),
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
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: () async {
                          try {
                            await controller
                                .linkWithEmailPass(
                                    context,
                                    emailcontroller.text,
                                    passwordcontroller.text)
                                .then((value) {
                              return controller.storeUserData(
                                email: emailcontroller.text,
                                password: passwordcontroller.text,
                                name: CompNamecontroller.text,
                              );
                            }).then((value) {
                              VxToast.show(context,
                                  msg: "Email Linked With Account");
                              Get.back();
                            });
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              return VxToast.show(context,
                                  msg: 'The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              return VxToast.show(context,
                                  msg:
                                      'The account already exists for that email.');
                            } else {
                              VxToast.show(context, msg: e.toString());
                            }
                          }
                        },
                        child: Text(
                          'Continue',
                          style: TextStyle(fontSize: 22.5),
                        ),
                      ),
                    ),
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
