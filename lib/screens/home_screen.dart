// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reway/constants/firebase_const.dart';
import 'package:reway/screens/suggestion_screen.dart';
import 'package:reway/services/firebase_messaging_services.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/list.dart';
import '../constants/strings.dart';
import '../custom/customdialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static getuserdetails(uid) async {
    final databaseReference =
        FirebaseDatabase.instance.ref("Recyclers").child(uid);
    DatabaseEvent event = await databaseReference.once();
    return event.snapshot.value;
  }

  @override
  Widget build(BuildContext context) {
    FirebaseMessages.setRecyclerToken();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            "assets/image/rew.png",
            width: 140,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder(
          future: getuserdetails(currentuser!.uid),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var data = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Divider(
                        thickness: 1,
                        color: Colors.green,
                      ),
                      20.heightBox,
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                              color: Vx.gray600,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                          children: [
                            TextSpan(text: "Welcome to the\n"),
                            TextSpan(
                                text: "REWAY",
                                style: TextStyle(color: Colors.green)),
                            TextSpan(text: " online marketplace\n\n"),
                            TextSpan(
                                text: ' The ultimate platform empowering\n',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Vx.gray600)),
                            TextSpan(
                                text: ' Recyclers',
                                style: TextStyle(color: Colors.green)),
                            TextSpan(
                                text:
                                    ' like you to optimize your electronic waste recycling business.',
                                style:
                                    TextStyle(fontWeight: FontWeight.normal)),
                            TextSpan(
                                text:
                                    '\n\nMake the most of this opportunity\n to grow your business, enhance your reputation, \nand make a ',
                                style:
                                    TextStyle(fontWeight: FontWeight.normal)),
                            TextSpan(
                                text: 'Positive',
                                style: TextStyle(color: Colors.green)),
                            TextSpan(
                                text: " impact on the \nenvironment. ",
                                style:
                                    TextStyle(fontWeight: FontWeight.normal)),
                            TextSpan(
                                text: '\n\n 4 STEPS towards building a',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            TextSpan(
                                text: '\nGreener Future',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                      20.heightBox,
                      VxSwiper.builder(
                          viewportFraction: 0.54,
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 160,
                          autoPlayInterval: Duration(seconds: 5),
                          enlargeCenterPage: true,
                          itemCount: imglist.length,
                          itemBuilder: ((context, index) {
                            return Image.asset(
                              imglist[index],
                              fit: BoxFit.cover,
                            )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 8))
                                .make();
                          })),
                      TextButton(
                          onPressed: () {
                            if (data['Email'] == null &&
                                data['Username'] != null &&
                                data['phone_no'] != null) {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => customdialog1(context,
                                      text: "Google account"));
                            } else if (data['Email'] != null &&
                                data['Username'] == null &&
                                data['phone_no'] != null) {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => customdialog1(context,
                                      text: "username/password"));
                            } else if (data['Email'] == null &&
                                data['Username'] == null &&
                                data['phone_no'] != null) {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => customdialog1(context,
                                      text: "username/Google account"));
                            } else if (data['Email'] != null &&
                                data['Username'] != null &&
                                data['phone_no'] == null) {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => customdialog1(context,
                                      text: "Phone Number"));
                            } else if (data['Email'] != null &&
                                data['Username'] == null &&
                                data['phone_no'] == null) {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => customdialog1(context,
                                      text: "Phone Number/Username"));
                            } else if (data['Email'] == null &&
                                data['Username'] != null &&
                                data['phone_no'] == null) {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => customdialog1(context,
                                      text: "Phone Number/Google account"));
                            } else if (data['Email'] != null &&
                                data['Username'] != null &&
                                data['phone_no'] != null) {
                              Get.to(() => SuggestionScreen(
                                    data: data,
                                  ));
                            }
                          },
                          child: Text(
                            'Have a suggestion or query? Click here!',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue.withOpacity(0.8)),
                          )),
                      20.heightBox,
                      Text(
                        "Features of this App",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          color: Vx.gray700,
                          fontSize: 18,
                        ),
                      ),
                      Divider(
                        thickness: 0.6,
                        color: Vx.gray400,
                      ),
                      Container(
                        height: 500,
                        width: context.screenWidth,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: textlist.length,
                            itemBuilder: (context, index) {
                              final item = textlist[index];
                              final title = titleList[index];
                              return Card(
                                child: ExpansionTile(
                                  childrenPadding: EdgeInsets.all(12),
                                  title: "${title}".text.make(),
                                  children: [
                                    Text(
                                        item, // Set the text for each expansion tile
                                        style: TextStyle(fontSize: 16))
                                  ],
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
