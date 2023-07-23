import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:reway/screens/home.dart';
import 'package:reway/screens/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/firebase_const.dart';
import '../controllers/auth_controller.dart';
import '../services/google_auth_service.dart';
import 'link_Email_Screen.dart';
import 'link_mobile_screen.dart';
import 'login_screen.dart';

class AccountProfile extends StatefulWidget {
  AccountProfile({super.key});

  @override
  State<AccountProfile> createState() => _AccountProfileState();
}

class _AccountProfileState extends State<AccountProfile> {
  var controller = Get.put(Authcontroller());
  late User _user;
  late Uri link;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
  }

  static getuserdetails(uid) async {
    final databaseReference =
        FirebaseDatabase.instance.ref("Recyclers").child(uid);
    DatabaseEvent event = await databaseReference.once();
    return event.snapshot.value;
  }

  @override
  Widget build(BuildContext context) {
    auth.authStateChanges().listen((user) {
      currentuser = user;
    });
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.offAll(() => Home());
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Vx.gray600,
            )),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'Account',
          style: TextStyle(color: Vx.gray700),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                _googleSignIn.signOut();
                VxToast.show(
                  context,
                  msg: "Logged out successfully",
                );
                Get.offAll(() => LoginScreen());
              },
              child: "Logout".text.size(16).bold.make())
        ],
      ),
      body: FutureBuilder(
        future: getuserdetails(currentuser!.uid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.green)));
          } else {
            var data = snapshot.data;
            print(data);
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      10.heightBox,
                      data['image_url'] == '' &&
                              controller.profileImgPath.isEmpty
                          ? const CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  AssetImage("assets/image/profile.gif"),
                            )
                          : data['image_url'] != '' &&
                                  controller.profileImgPath.isEmpty
                              ? CircleAvatar(
                                  radius: 60,
                                  backgroundImage:
                                      NetworkImage(data['image_url']))
                              : CircleAvatar(
                                  radius: 60,
                                  backgroundImage: FileImage(
                                      File(controller.profileImgPath.value)),
                                ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () async {
                                await controller
                                    .selectImagefromGallery(context);
                                if (controller
                                    .profileImgPath.value.isNotEmpty) {
                                  await controller.uplaodProfileImage();
                                } else {
                                  controller.profileImagelink =
                                      data['image_url'];
                                }
                                controller.storeimage();
                                setState(() {
                                  VxToast.show(context, msg: "Profile Updated");
                                });
                              },
                              icon: Icon(
                                Icons.photo_size_select_actual_rounded,
                                color: Vx.gray600,
                              )),
                          5.widthBox,
                          IconButton(
                              onPressed: () async {
                                await controller.selectImagefromCamera(context);
                                if (controller
                                    .profileImgPath.value.isNotEmpty) {
                                  await controller.uplaodProfileImage();
                                } else {
                                  controller.profileImagelink =
                                      data['image_url'];
                                }
                                controller.storeimage();
                                setState(() {
                                  VxToast.show(context, msg: "Profile Updated");
                                });
                              },
                              icon: Icon(
                                Icons.camera,
                                color: Vx.gray600,
                              ))
                        ],
                      ),
                      data['Username'] == null
                          ? "Username Not Set"
                              .text
                              .semiBold
                              .gray800
                              .size(18)
                              .make()
                          : "${data['Username']}"
                              .text
                              .semiBold
                              .gray800
                              .size(18)
                              .make(),
                      10.heightBox,
                      data['Email'] == null
                          ? "Email Not Set".text.gray800.size(16).make()
                          : "${data['Email']}".text.gray800.size(16).make(),
                      10.heightBox,
                      Divider(
                        thickness: 6,
                      ),
                      ListTile(
                        splashColor: Colors.green,
                        onTap: () {
                          controller.linkWithGoogle(context).then((value) {
                            controller.storeGoogleData(
                                context: context, email: googleEmail);
                          });
                        },
                        trailing: Icon(Icons.arrow_forward_ios_outlined),
                        title: const Text(
                          'Link your Google Account',
                          style: TextStyle(
                              color: Vx.gray600,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      ListTile(
                        splashColor: Colors.green,
                        onTap: () {
                          Get.to(() => LinkMobileScreen(),
                              transition: Transition.rightToLeft);
                        },
                        trailing: Icon(Icons.arrow_forward_ios_outlined),
                        title: const Text(
                          'Link your Phone Number',
                          style: TextStyle(
                              color: Vx.gray600,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      ListTile(
                        splashColor: Colors.green,
                        onTap: () {
                          Get.to(() => LinkEmailScreen(),
                              transition: Transition.rightToLeft);
                        },
                        trailing: Icon(Icons.arrow_forward_ios_outlined),
                        title: const Text(
                          'Link your Username and password',
                          style: TextStyle(
                              color: Vx.gray600,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Column(
                        children: [
                          "Visit us at".text.gray500.size(18).semiBold.make(),
                          5.heightBox,
                          Image.asset(
                            "assets/image/imgbg.png",
                            width: 80,
                          ).onTap(() async {
                            link = Uri.parse("https://www.reway.tech/");
                            if (await canLaunchUrl(link)) {
                              launchUrl(link);
                            }
                          }),
                          20.heightBox,
                          "OR".text.gray500.size(16).semiBold.make(),
                          20.heightBox
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          "Contact Us:-"
                              .text
                              .semiBold
                              .size(16)
                              .color(Vx.gray500)
                              .make(),
                          IconButton(
                              onPressed: () async {
                                link = Uri.parse(
                                    "https://twitter.com/Reway_ewaste?t=lg9Owp-C46D9ZPzJsg0Qqw&s=09");
                                if (await canLaunchUrl(link)) {
                                  launchUrl(link);
                                }
                              },
                              icon: Image.asset(
                                "assets/image/twitter.png",
                                width: context.screenWidth * 0.060,
                              )),
                          IconButton(
                              onPressed: () async {
                                link = Uri.parse(
                                    "https://www.linkedin.com/company/reway-technologies/");
                                if (await canLaunchUrl(link)) {
                                  launchUrl(link);
                                }
                              },
                              icon: Image.asset(
                                "assets/image/link.png",
                                width: context.screenWidth * 0.060,
                                color: Vx.blue600,
                              )),
                          IconButton(
                              onPressed: () async {
                                link = Uri.parse("tel:+917290908877");
                                if (await canLaunchUrl(link)) {
                                  launchUrl(link);
                                }
                              },
                              icon: Image.asset(
                                "assets/image/tele.png",
                                width: context.screenWidth * 0.060,
                                color: Colors.green,
                              )),
                          IconButton(
                              onPressed: () async {
                                link = Uri.parse("mailto: reway.ewm@gmail.com");
                                if (await canLaunchUrl(link)) {
                                  launchUrl(link);
                                }
                              },
                              icon: Icon(
                                Icons.mail,
                                color: Vx.gray600,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
