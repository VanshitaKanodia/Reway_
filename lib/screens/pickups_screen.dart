import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reway/screens/pickup_details.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

import '../constants/firebase_const.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({super.key});

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  late Uri link;

  @override
  Widget build(BuildContext context) {
    final DatabaseReference ref =
        FirebaseDatabase.instance.ref().child('Details');

    var uid = FirebaseAuth.instance.currentUser!.uid;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            'Pickup',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: ref.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData &&
                        snapshot.data!.snapshot.exists) {
                      var count = 0;
                      Map<dynamic, dynamic> imap =
                          snapshot.data!.snapshot.value as dynamic;
                      List listCheck = <dynamic>[];
                      List<dynamic> list = [];
                      list.clear();
                      if (imap.containsKey(uid)) {
                        imap.remove(uid);
                      }
                      list = imap.values.toList();

                      for (var element in list) {
                        for (var elementNew in element.entries) {
                          listCheck.add(elementNew);
                          listCheck.elementAt(0).value['image'];
                        }
                      }
                      return Center(
                        child: ListView.builder(
                            itemCount: listCheck.length,
                            itemBuilder: (context, index) {
                              if (listCheck[index].value['is_confirmed']) {
                                count++;
                              }
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Visibility(
                                        visible: (listCheck[index]
                                                .value['is_confirmed'] &&
                                            listCheck[index]
                                                    .value['recycler_uid'] ==
                                                currentuser!.uid),
                                        child: InkWell(
                                          onTap: () {
                                            Get.to(() => PickupDetails(
                                                  data: listCheck[index].value,
                                                ));
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: 60,
                                                    width: 60,
                                                    child: CircleAvatar(
                                                      radius: 50,
                                                      backgroundImage: NetworkImage(
                                                          '${listCheck[index].value['image']}'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      listCheck[index].value[
                                                              'Address'] ??
                                                          '',
                                                      maxLines: 2,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16),
                                                    ),
                                                    "${listCheck[index].value['Weight']}"
                                                        .replaceAll('[', '')
                                                        .replaceAll(']', '')
                                                        .text
                                                        .make(),
                                                    "${listCheck[index].value['Time']}"
                                                        .replaceAll('[', '')
                                                        .replaceAll(']', '')
                                                        .text
                                                        .make(),
                                                    Row(
                                                      children: [
                                                        Text(intl.DateFormat(
                                                                'd MMMM')
                                                            .format(DateTime.parse(
                                                                listCheck[index]
                                                                        .value[
                                                                    'Start_Date']))),
                                                        " - ".text.make(),
                                                        Text(intl.DateFormat(
                                                                'd MMMM')
                                                            .format(DateTime.parse(
                                                                listCheck[index]
                                                                        .value[
                                                                    'End_Date']))),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                            .box
                                            .rounded
                                            .color(listCheck[index]
                                                    .value['is_completed']
                                                ? Colors.green.withOpacity(0.4)
                                                : Colors.white)
                                            .make(),
                                      ),
                                      Visibility(
                                          visible: count == list.length,
                                          child: Column(
                                            children: [
                                              Divider(
                                                thickness: 1,
                                              ),
                                              "No more orders found"
                                                  .text
                                                  .make(),
                                            ],
                                          ))
                                    ],
                                  ));
                            }),
                      );
                    } else {
                      return const Scaffold(
                        body: Center(child: Text('No data found')),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
