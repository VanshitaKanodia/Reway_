import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reway/constants/firebase_const.dart';
import 'package:reway/controllers/auth_controller.dart';
import 'package:reway/screens/home.dart';
import 'package:reway/services/firebase_messaging_services.dart';
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

var certificate;

class _PickupDetailsState extends State<PickupDetails> {
  int points = -1;
  var sellerUserid;
  var controller = Get.find<Authcontroller>();

  static getUserdetails(uid) async {
    final databaseReference = FirebaseDatabase.instance.ref("Users").child(uid);
    DatabaseEvent event = await databaseReference.once();
    return event.snapshot.value;
  }

  static getRecyclerdetails(uid) async {
    final databaseReference =
        FirebaseDatabase.instance.ref("Recyclers").child(uid);
    DatabaseEvent event = await databaseReference.once();
    return event.snapshot.value;
  }

  Future<String> uploadFile(String filename, File file) async {
    final ref =
        FirebaseStorage.instance.ref().child("certificate/$filename.pdf");
    final uploadTask = ref.putFile(file);
    await uploadTask.whenComplete(() {});
    final Downloadlink = await ref.getDownloadURL();

    return Downloadlink;
  }

  void selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      String fileName = result.files[0].name;
      File file = File(result.files[0].path!);
      final downloadLink = await uploadFile(fileName, file);
      certificate = downloadLink;
      final databaseReference =
          FirebaseDatabase.instance.ref(recyclersCollection);

      Map<String, dynamic> updatedData = {
        'certificate': downloadLink,
      };
      await databaseReference.child(currentuser!.uid).update(updatedData);

      print(downloadLink);
      VxToast.show(context, msg: "Certificate uploaded Successfully");
    }
  }

  late Uri link;

  @override
  Widget build(BuildContext context) {
    List<String> orderItem = [];
    if (widget.data['Order_list_name'] == "") {
      List<Object?> orderList = widget.data['Order_list'];
      List<String> items = orderList.map((item) => item.toString()).toList();
      orderItem = items;
    }

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
          : FutureBuilder(
              future: getUserdetails(widget.data['uid']),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  var dataOne = snapshot.data;
                  controller.isindividual.value =
                      dataOne['type'] == 'INDIVIDUAL' ? true : false;

                  return SizedBox(
                    width: context.screenWidth,
                    height: 60,
                    child: FutureBuilder(
                        future: getRecyclerdetails(widget.data['recycler_uid']),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            var recyclerData = snapshot.data;
                            return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0)),
                                  padding: EdgeInsets.all(12),
                                ),
                                onPressed: () {
                                  if (!controller.isindividual.value) {
                                    if (certificate == null) {
                                      VxToast.show(context,
                                          msg: "Upload Certificate First");
                                      return;
                                    }
                                  }
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
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  customButton(
                                                      color: Colors.green,
                                                      onPress: () async {
                                                        await FirebaseDatabase
                                                            .instance
                                                            .ref("Details")
                                                            .child(widget
                                                                .data['uid'])
                                                            .child(widget.data[
                                                                'dateUid'])
                                                            .update({
                                                          'is_completed': true
                                                        });
                                                        FirebaseMessages.sendNotification(
                                                            title:
                                                                "Order Completed!",
                                                            msg:
                                                                "Your Order has been completed",
                                                            token: recyclerData[
                                                                'push_token']);
                                                        if (points >= 0) {
                                                          if (orderItem.contains(
                                                              "Smartphone")) {
                                                            points =
                                                                points + 50;
                                                          }
                                                          if (orderItem.contains(
                                                              "Headphones / Earphones")) {
                                                            points =
                                                                points + 20;
                                                          }
                                                          if (orderItem.contains(
                                                              "Laptop / Desktop")) {
                                                            points =
                                                                points + 500;
                                                          }
                                                          if (orderItem
                                                              .contains(
                                                                  "CPU/GPU")) {
                                                            points =
                                                                points + 600;
                                                          }
                                                          if (orderItem.contains(
                                                              "Iron Press")) {
                                                            points =
                                                                points + 20;
                                                          }
                                                          if (orderItem.contains(
                                                              "Refrigerator")) {
                                                            points =
                                                                points + 1000;
                                                          }
                                                          if (orderItem.contains(
                                                              "Washing Machine")) {
                                                            points =
                                                                points + 700;
                                                          }
                                                          if (orderItem.contains(
                                                              "Microwave Oven")) {
                                                            points =
                                                                points + 650;
                                                          }

                                                          await FirebaseDatabase
                                                              .instance
                                                              .ref(
                                                                  usercollection)
                                                              .child(
                                                                  sellerUserid)
                                                              .update({
                                                            'points': points
                                                          });

                                                          // FirebaseMessages.sendNotification(
                                                          //     title:
                                                          //         "50 Points Credited!",
                                                          //     msg:
                                                          //         "For successfull order completion",
                                                          //     token: recyclerData[
                                                          //         'push_token']);
                                                        }

                                                        Get.offAll(
                                                            () => Home());

                                                        VxToast.show(context,
                                                            msg:
                                                                "Order marked as complete");
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
                                                  .padding(
                                                      const EdgeInsets.all(12))
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
                                ));
                          }
                        }),
                  );
                }
              }),
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
                  Visibility(
                    visible: widget.data['description'] != null,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          children: [
                            "Order Description:"
                                .text
                                .bold
                                .black
                                .size(18)
                                .make(),
                            5.widthBox,
                            ("${widget.data['description']}"
                                    .replaceAll("[", '')
                                    .replaceAll("]", ''))
                                .text
                                .size(18)
                                .make()
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: widget.data['description'] != null,
                      child: 20.heightBox),
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
                        "Quoted price:".text.bold.black.size(18).make(),
                        5.widthBox,
                        ("Rs. ${widget.data['selected_quotation_price']}")
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
                      child: widget.data['Order_list_name'] != ''
                          ? Wrap(
                              children: [
                                "Order List:".text.bold.black.size(18).make(),
                                5.widthBox,
                                ("${widget.data['Order_list_name']}")
                                    .text
                                    .size(18)
                                    .make()
                                    .onTap(() async {
                                  link = Uri.parse(widget.data['Order_list']);
                                  if (await canLaunchUrl(link)) {
                                    launchUrl(link,
                                        mode: LaunchMode.externalApplication);
                                  }
                                })
                              ],
                            )
                          : SizedBox(
                              height: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Items:-",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Wrap(
                                    children: orderItem
                                        .map((item) => Wrap(
                                              children: [
                                                Text(item,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                Text(
                                                    ', '), // Add comma after each item
                                              ],
                                            ))
                                        .toList(),
                                  )
                                ],
                              )),
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
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        children: [
                          "Address:".text.bold.black.size(18).make(),
                          5.widthBox,
                          ("${widget.data['Address']}").text.size(18).make()
                        ],
                      ),
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

                          points = data['points'];
                          sellerUserid = data['id'];
                          return Padding(
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
                                      ("${data['Company_name']} ")
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
                  Builder(builder: (context) {
                    return Obx(
                      () => Visibility(
                        visible: !controller.isindividual.value,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                padding: EdgeInsets.all(12),
                              ),
                              onPressed: () {
                                selectFile();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Upload Certificate",
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              )),
                        ),
                      ),
                    );
                  }),
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
