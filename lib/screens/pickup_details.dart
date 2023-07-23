import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reway/constants/firebase_const.dart';
import 'package:reway/screens/home.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';

import '../custom/custom_button.dart';

class PickupDetails extends StatefulWidget {
  var data;
  PickupDetails({super.key, this.data});

  @override
  State<PickupDetails> createState() => _PickupDetailsState();
}

class _PickupDetailsState extends State<PickupDetails> {
  static getUserdetails(uid) async {
    final databaseReference = FirebaseDatabase.instance.ref("Users").child(uid);
    DatabaseEvent event = await databaseReference.once();
    return event.snapshot.value;
  }

  late Uri link;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: "Details".text.bold.make(),
      ),
      bottomNavigationBar: widget.data['is_completed']
          ? Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 18),
              child: Container(
                child:
                    "              This order has been marked complete by you"
                        .text
                        .make(),
              ),
            )
          : SizedBox(
              width: context.screenWidth,
              height: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    padding: EdgeInsets.all(12),
                  ),
                  onPressed: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => Dialog(
                                child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                "Confirm"
                                    .text
                                    .bold
                                    .size(18)
                                    .color(Vx.gray800)
                                    .make(),
                                const Divider(),
                                10.heightBox,
                                "Are you sure you want to mark this order as completed?\n This will mean that you have succesfully completed all the requirements of the user who placed the order"
                                    .text
                                    .size(16)
                                    .color(Vx.gray800)
                                    .make(),
                                10.heightBox,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    customButton(
                                        color: Colors.green,
                                        onPress: () async {
                                          await FirebaseDatabase.instance
                                              .ref("Details")
                                              .child(widget.data['uid'])
                                              .child(widget.data['dateUid'])
                                              .update({'is_completed': true});
                                          Get.offAll(() => Home());
                                          VxToast.show(context,
                                              msg: "Order marked as complete");
                                        },
                                        textColor: Colors.white,
                                        title: "Yes"),
                                    customButton(
                                        color: Colors.green,
                                        onPress: () {
                                          Navigator.pop(context);
                                        },
                                        textColor: Colors.white,
                                        title: "No"),
                                  ],
                                ),
                              ],
                            )
                                    .box
                                    .color(Vx.gray100)
                                    .padding(const EdgeInsets.all(12))
                                    .roundedSM
                                    .make()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Complete your pickup",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  )),
            ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(color: Vx.gray200),
                height: 200,
                width: context.screenWidth,
                child: Image.network(
                  widget.data['image'],
                  fit: BoxFit.contain,
                )),
            20.heightBox,
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        "Time:".text.bold.black.size(18).make(),
                        5.widthBox,
                        ("${widget.data['Time']}"
                                .replaceAll("[", '')
                                .replaceAll("]", ''))
                            .text
                            .size(18)
                            .make()
                      ],
                    ),
                  ),
                  20.heightBox,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        "Weight:".text.bold.black.size(18).make(),
                        5.widthBox,
                        ("${widget.data['Weight']}"
                                .replaceAll("[", '')
                                .replaceAll("]", ''))
                            .text
                            .size(18)
                            .make()
                      ],
                    ),
                  ),
                  20.heightBox,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        children: [
                          "Scheduled Date:".text.bold.black.size(18).make(),
                          5.widthBox,
                          //"${data['Start_Date']}"
                          (intl.DateFormat('d MMMM')
                                  .format(DateTime.parse(widget.data['Date'])))
                              .text
                              .size(18)
                              .make(),
                        ],
                      ),
                    ),
                  ),
                  20.heightBox,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      children: [
                        "Address:".text.bold.black.size(18).make(),
                        5.widthBox,
                        ("${widget.data['Address']}").text.size(18).make()
                      ],
                    ),
                  ),
                  FutureBuilder(
                      future: getUserdetails(widget.data['uid']),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          var data = snapshot.data;
                          return  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Wrap(
                                    children: [
                                      "Company Details: "
                                          .text
                                          .bold
                                          .black
                                          .size(18)
                                          .make(),
                                      5.widthBox,
                                      ("${data['comp_name']}")
                                          .text
                                          .size(18)
                                          .make(),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        link = Uri.parse(("tel:+91" +
                                            "${data['phone_no']}"));
                                        if (await canLaunchUrl(link)) {
                                          launchUrl(link);
                                        }
                                      },
                                      icon: Icon(
                                        Icons.call,
                                        color: Colors.green,
                                      ))
                                ],
                              ),
                            ),
                          );
                        }
                      }),
                  10.heightBox,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          padding: EdgeInsets.all(12),
                        ),
                        onPressed: () async {
                          link = Uri.parse(widget.data["Address Link"]);
                          if (await canLaunchUrl(link)) {
                            launchUrl(link);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on),
                            20.widthBox,
                            Text(
                              "Location",
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
