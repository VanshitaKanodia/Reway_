import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reway/constants/firebase_const.dart';
import 'package:reway/screens/home.dart';
import 'package:reway/services/firebase_messaging_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

class PickupScreen extends StatefulWidget {
  const PickupScreen({super.key});

  @override
  State<PickupScreen> createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  static getUserdetails(uid) async {
    final databaseReference = FirebaseDatabase.instance.ref("Users").child(uid);
    DatabaseEvent event = await databaseReference.once();
    return event.snapshot.value;
  }

  @override
  Widget build(BuildContext context) {
    late Uri link;
    final DatabaseReference ref =
        FirebaseDatabase.instance.ref().child('Details');
    var uid = FirebaseAuth.instance.currentUser!.uid;

    ref.get().then((snapshot) {
      for (final hospital in snapshot.children) {
        print(hospital.child("lat").value);
      }
    }, onError: (error) {
      print('data not found');
    });

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
            'Buy',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Vx.gray200,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Vx.gray600,
                          ),
                          hintText: "Search Recyclers",
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            color: Vx.gray600,
                          ),
                          labelStyle: TextStyle(fontSize: 14),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 18.0),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Vx.gray200,
                          borderRadius: BorderRadius.circular(18)),
                      height: 40,
                      width: 40,
                      child: IconButton(
                        color: Color.fromARGB(255, 104, 104, 104),
                        onPressed: () {},
                        icon: Icon(Icons.filter_alt),
                      ),
                    ).box.rounded.make()
                  ],
                ),
              ),
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
                              if (listCheck[index].value['is_confirmed'] ==
                                  true) {
                                count++;
                              }
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Visibility(
                                        visible: !listCheck[index]
                                            .value['is_confirmed'],
                                        child: FutureBuilder(
                                            future: getUserdetails(
                                                listCheck[index].value['uid']),
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              } else {
                                                var data = snapshot.data;
                                                return Slidable(
                                                  endActionPane: ActionPane(
                                                      motion: StretchMotion(),
                                                      children: [
                                                        SlidableAction(
                                                          backgroundColor:
                                                              Colors.blue,
                                                          label:
                                                              "${data['comp_name']}",
                                                          onPressed:
                                                              (context) {},
                                                          icon: (Icons
                                                              .location_city_rounded),
                                                        ),
                                                        SlidableAction(
                                                          backgroundColor:
                                                              Colors.green,
                                                          label: "Call",
                                                          onPressed:
                                                              (context) async {
                                                            link = Uri.parse(
                                                                ("tel:+91" +
                                                                    "${data['phone_no']}"));
                                                            if (await canLaunchUrl(
                                                                link)) {
                                                              launchUrl(link);
                                                            }
                                                          },
                                                          icon: (Icons.call),
                                                        )
                                                      ]),
                                                  child: FutureBuilder(
                                                      future: getUserdetails(
                                                          listCheck[index]
                                                              .value['uid']),
                                                      builder: (context,
                                                          AsyncSnapshot
                                                              snapshot) {
                                                        if (!snapshot.hasData) {
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                        } else {
                                                          var data =
                                                              snapshot.data;
                                                          return InkWell(
                                                            onTap: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                        title: const Text(
                                                                            'Pickup'),
                                                                        content:
                                                                            SingleChildScrollView(
                                                                          child:
                                                                              ListBody(
                                                                            children: [
                                                                              Text("Date : ${DateFormat("dd-MM-yy").format(DateTime.parse(listCheck[index].value['Date'] ?? ''))}"),
                                                                              const SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                              TextButton(
                                                                                onPressed: () async {
                                                                                  link = Uri.parse(listCheck[index].value['Order_list']);
                                                                                  if (await canLaunchUrl(link)) {
                                                                                    launchUrl(link, mode: LaunchMode.externalApplication);
                                                                                  }
                                                                                },
                                                                                child: Text(
                                                                                  "Order List : ${listCheck[index].value['Order_list_name']}",
                                                                                  selectionColor: Colors.black,
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                              Text(
                                                                                'Time : ${listCheck[index].value['Time']}'.replaceAll('[', '').replaceAll(']', ''),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 15,
                                                                              ),
                                                                              Text("Address : ${listCheck[index].value['Address'] ?? ''}"),
                                                                              const SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        actions: [
                                                                          ElevatedButton(
                                                                            child:
                                                                                const Text('Confirm'),
                                                                            onPressed:
                                                                                () async {
                                                                              await FirebaseDatabase.instance.ref("Details").child(listCheck[index].value['uid']).child(listCheck[index].value['dateUid'].toString()).update({
                                                                                'is_confirmed': true,
                                                                                'recycler_uid': currentuser!.uid.toString(),
                                                                              }).then((value) {
                                                                                Get.to(() => Home());
                                                                                VxToast.show(context, msg: "Order Confirmed");
                                                                              }).then((value) {
                                                                                FirebaseMessages.setRecyclerToken();
                                                                              });
                                                                              Navigator.of(context).pop();
                                                                              FirebaseMessages.sendNotification(title: "Confirmed!", token: data['push_token'], msg: "Your Pickup was confirmed!");
                                                                            },
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                0,
                                                                          ),
                                                                          TextButton(
                                                                            child:
                                                                                const Text('Cancel'),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                          ),
                                                                        ]);
                                                                  });
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  height: 60,
                                                                  width: 60,
                                                                  child:
                                                                      CircleAvatar(
                                                                    radius: 50,
                                                                    backgroundImage:
                                                                        NetworkImage(
                                                                            '${listCheck[index].value['image']}'),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Expanded(
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        listCheck[index].value['Address'] ??
                                                                            '',
                                                                        maxLines:
                                                                            2,
                                                                        style: const TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontSize: 16),
                                                                      ),
                                                                      // "${listCheck[index].value['Weight']}"
                                                                      //     .replaceAll(
                                                                      //         '[', '')
                                                                      //     .replaceAll(
                                                                      //         ']', '')
                                                                      //     .text
                                                                      //     .make(),
                                                                      "${listCheck[index].value['Time']}"
                                                                          .replaceAll(
                                                                              '[',
                                                                              '')
                                                                          .replaceAll(
                                                                              ']',
                                                                              '')
                                                                          .text
                                                                          .make(),
                                                                      Row(
                                                                        children: [
                                                                          Text(intl.DateFormat('d MMMM')
                                                                              .format(DateTime.parse(listCheck[index].value['Date']))),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }
                                                      }),
                                                );
                                              }
                                            }),
                                      ),
                                      Visibility(
                                          visible: count == listCheck.length,
                                          child: "No Orders found"
                                              .text
                                              .color(Vx.black)
                                              .make())
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
