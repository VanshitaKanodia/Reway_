import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/firebase_const.dart';
import '../controllers/auth_controller.dart';
import '../services/google_auth_service.dart';
import 'link_Email_Screen.dart';
import 'link_mobile_screen.dart';
import 'login_screen.dart';

class AccountProfile extends StatefulWidget {
  const AccountProfile({super.key});

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

  @override
  Widget build(BuildContext context) {
    auth.authStateChanges().listen((user) {
      currentuser = user;
    });
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            100.heightBox,
            SizedBox(
              width: context.screenWidth - 160,
              child: MaterialButton(
                padding: const EdgeInsets.all(10),
                color: Vx.gray100,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  'Link your Google Account',
                  style: TextStyle(color: Vx.gray600, fontSize: 15),
                ),
                onPressed: () {
                  controller.linkWithGoogle(context).then((value) {
                    controller.storeGoogleData(
                        context: context, email: googleEmail);
                  });
                },
              ),
            ).box.outerShadowLg.make(),
            20.heightBox,
            SizedBox(
              width: context.screenWidth - 160,
              child: MaterialButton(
                padding: const EdgeInsets.all(10),
                color: Vx.gray100,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  'Link your Phone Number',
                  style: TextStyle(color: Vx.gray600, fontSize: 15),
                ),
                onPressed: () {
                  Get.to(() => LinkMobileScreen());
                },
              ),
            ).box.outerShadowLg.make(),
            20.heightBox,
            SizedBox(
              width: context.screenWidth - 160,
              child: MaterialButton(
                padding: const EdgeInsets.all(10),
                color: Vx.gray100,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  'Link your Username and password',
                  style: TextStyle(color: Vx.gray600, fontSize: 15),
                ),
                onPressed: () {
                  Get.to(() => LinkEmailScreen());
                },
              ),
            ).box.outerShadowLg.make(),
            20.heightBox,
            // Text('Name: ${_user.displayName}'),
            SizedBox(
              width: context.screenWidth - 160,
              child: MaterialButton(
                padding: const EdgeInsets.all(10),
                color: Vx.gray100,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  'LOG OUT',
                  style: TextStyle(color: Vx.gray600, fontSize: 15),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  _googleSignIn.signOut();
                  VxToast.show(
                    context,
                    msg: "Logged out successfully",
                  );
                  Get.offAll(() => LoginScreen());
                },
              ),
            ).box.outerShadowLg.make(),
            Spacer(),

            Column(
              children: [
                "Visit us at".text.gray500.size(18).semiBold.make(),
                5.heightBox,
                // IconButton(
                //     onPressed: () async {
                //       link = Uri.parse("https://www.reway.tech/");
                //       if (await canLaunchUrl(link)) {
                //         launchUrl(link);
                //       }
                //     },
                //     icon: Image.asset(
                //       "assets/image/img.png",
                //       width: 80,
                //       // color: Vx.blue600,
                //     )),
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
                "Contact Us:-".text.semiBold.size(16).color(Vx.gray500).make(),
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
    );
  }
}
