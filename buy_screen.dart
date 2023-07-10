import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reway/screens/pickups_screen.dart';

class PickupScreen extends StatefulWidget {
  const PickupScreen({super.key});

  @override
  State<PickupScreen> createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  @override
  Widget build(BuildContext context) {

    // final DatabaseReference dref = FirebaseDatabase.instance.ref().child('Details');
    //
    // dref.onValue.listen((event) {
    //   // Handle the data
    //   DataSnapshot snapshot = event.snapshot;
    //   print(snapshot.value);
    // }, onError: (Object o) {
    //   // Handle the error
    //   print(o.toString());
    // });


    final DatabaseReference ref = FirebaseDatabase.instance.ref().child('Details');
    var uid = FirebaseAuth.instance.currentUser!.uid;

    ref.get().then((snapshot) {
      for (final hospital in snapshot.children) {
        print(hospital.child("lat").value);
      }
    }, onError: (error) {
      print('data not found');
    });


    @override
    void initState() {
      super.initState();
    }

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
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 105, 105, 105),
            ),
          ),
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
                    const Expanded(
                      flex: 4,
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          prefixIcon: Icon(
                            Icons.search,
                            size: 32,
                          ),
                          fillColor: Color.fromARGB(255, 212, 212, 212),
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 104, 104, 104),
                            fontSize: 25,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      color: const Color.fromARGB(255, 212, 212, 212),
                      child: IconButton(
                        iconSize: 30,
                        color: const Color.fromARGB(255, 104, 104, 104),
                        onPressed: () {},
                        icon: const Icon(Icons.filter_alt),
                      ),
                    )
                  ],
                ),
              ),
//               Expanded(
//                 child: ListView.builder(
//                   physics: const BouncingScrollPhysics(),
// // shrinkWrap: true,
//                   itemBuilder: ((context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.pushNamed(context, '/info_display');
//                         },
//                         child: Container(
//                           height: 150,
//                           // decoration: BoxDecoration(
//                           //     border: Border.all(color: Colors.grey)),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               // Expanded(
//                               //   flex: 1,
//                               //   child: Padding(
//                               //     padding: const EdgeInsets.all(8.0),
//                               //     child: Column(
//                               //       crossAxisAlignment:
//                               //           CrossAxisAlignment.stretch,
//                               //       children: [
//                               //         Image.network(
//                               //           'https://blog.ipleaders.in/wp-content/uploads/2020/02/tata_communication_hq_660_100120025251.jpg',
//                               //           height: 90,
//                               //           fit: BoxFit.fill,
//                               //         ),
//                               //         const SizedBox(
//                               //           height: 10,
//                               //         ),
//                               //         RatingBar.builder(
//                               //           itemSize:
//                               //               MediaQuery.of(context).size.width /
//                               //                   22,
//                               //           initialRating: 3,
//                               //           minRating: 1,
//                               //           direction: Axis.horizontal,
//                               //           allowHalfRating: true,
//                               //           itemCount: 5,
//                               //           itemBuilder: (context, _) => const Icon(
//                               //             Icons.star,
//                               //             color: Colors.amber,
//                               //           ),
//                               //           onRatingUpdate: (rating) {
//                               //             print(rating);
//                               //           },
//                               //         ),
//                               //       ],
//                               //     ),
//                               //   ),
//                               // ),
//                               // const SizedBox(
//                               //   width: 10,
//                               // ),
//                               // Expanded(
//                               //   flex: 2,
//                               //   child: Padding(
//                               //     padding: const EdgeInsets.all(8.0),
//                               //     child: Column(
//                               //       crossAxisAlignment:
//                               //           CrossAxisAlignment.start,
//                               //       children: [
//                               //         Expanded(
//                               //           child: StreamBuilder(
//                               //             stream: ref.onValue,
//                               //             builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
//                               //               if (snapshot.connectionState == ConnectionState.waiting) {
//                               //                 return Center(child: CircularProgressIndicator());
//                               //               }
//                               //               else if (snapshot.hasData && snapshot.data!.snapshot.exists){
//                               //                 Map<dynamic, dynamic> imap = snapshot.data!.snapshot
//                               //                     .value as dynamic;
//                               //                 List<dynamic> list = [];
//                               //                 list.clear();
//                               //                 list = imap.values.toList();
//                               //                 return ListView.builder(
//                               //                     itemCount: snapshot.data!.snapshot.children.length,
//                               //                     itemBuilder: (context, index) {
//                               //                       Map thisItem = list[index];
//                               //                       return ListTile(
//                               //                         trailing: Text(thisItem['Weight']) ,
//                               //                         title: Text(thisItem['Start Date']),
//                               //                         // leading: Text(list[index]['Time']),
//                               //                         // leading: Container(
//                               //                         //   // height: 30,
//                               //                         //   // width: 30,
//                               //                         //   child: thisItem.containsKey('image')?Image.network('${thisItem['image']}') : Container(),),
//                               //                         subtitle: Text(thisItem['Address']),
//                               //                       );
//                               //                     });
//                               //               }
//                               //               else {
//                               //                 return Scaffold(
//                               //                   body: Center(child: Text('No data found')),
//                               //                 );
//                               //               }
//                               //             },
//                               //           ),
//                               //         )
//                               //
//                               //         // Text(
//                               //         //   'CYber Mobile Repairer',
//                               //         //   style: GoogleFonts.inter(
//                               //         //       fontSize: 20,
//                               //         //       fontWeight: FontWeight.w600),
//                               //         // ),
//                               //         // SizedBox(
//                               //         //   height: 7,
//                               //         // ),
//                               //         // Text('A-47 West Patel Nagar'),
//                               //         // const Text(
//                               //         //     'Description : Total - 70Kgs, 3 Refrigerators, 20 Smartphones....'),
//                               //         // SizedBox(
//                               //         //   height: 12,
//                               //         // ),
//                               //         // Text('Minimum Bid : Rs.50000',
//                               //         //     style: GoogleFonts.inter(
//                               //         //         fontSize: 14,
//                               //         //         fontWeight: FontWeight.w500)),
//                               //       ],
//                               //     ),
//                               //   ),
//                               // ),
//
//
//                               Expanded(
//                                 child: StreamBuilder(
//                                   stream: ref.onValue,
//                                   builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
//                                     if (snapshot.connectionState == ConnectionState.waiting) {
//                                       return Center(child: CircularProgressIndicator());
//                                     }
//                                     else if (snapshot.hasData && snapshot.data!.snapshot.exists){
//                                       Map<dynamic, dynamic> imap = snapshot.data!.snapshot
//                                           .value as dynamic;
//                                       List<dynamic> list = [];
//                                       list.clear();
//                                       list = imap.values.toList();
//                                       return Center(
//                                         child: ListView.builder(
//                                             itemCount: snapshot.data!.snapshot.children.length,
//                                             itemBuilder: (context, index) {
//                                               Map thisItem = list[index];
//                                               return Expanded(
//                                                   child: Row(
//                                                     mainAxisAlignment: MainAxisAlignment.start,
//                                                     children: [
//                                                       Column(
//                                                         children: [
//                                                           SizedBox(
//                                                             height: 80,
//                                                             width: 80,
//                                                             child: thisItem.containsKey('image')?Image.network('${thisItem['image']}') : Container(),),
//                                                         ],
//                                                       ),
//                                                       SizedBox(width: 10,),
//                                                       Expanded(
//                                                         child: Column(
//                                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                                           children: [
//                                                             Text(thisItem['Weight'] ?? ''),
//                                                             Text(thisItem['Time'] ?? ''),
//                                                             Text(thisItem['Address'] ?? '',
//                                                             maxLines: 2,),
//                                                           ],
//                                                         ),
//                                                       )
//                                                     ],
//                                                   ),
//                                               );
//                                               //   ListTile(
//                                               //   trailing: Text(thisItem['Weight'] ?? ''),
//                                               //   title: Text(thisItem['Time'] ?? ''),
//                                               //   leading: SizedBox(
//                                               //     height: 50,
//                                               //     width: 50,
//                                               //     child: thisItem.containsKey('image')?Image.network('${thisItem['image']}') : Container(),),
//                                               //   subtitle: Text(thisItem['Address'] ?? ''),
//                                               // );
//                                             }),
//                                       );
//                                     }
//                                     else {
//                                       return Scaffold(
//                                         body: Center(child: Text('No data found')),
//                                       );
//                                     }
//                                   },
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
              Expanded(
                child: StreamBuilder(
                  stream: ref.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData &&
                        snapshot.data!.snapshot.exists) {
                      Map<dynamic, dynamic> imap = snapshot.data!.snapshot.value as dynamic;
                      List listCheck = <dynamic>[];
                      List<dynamic> list = [];
                      list.clear();
                      if(imap.containsKey(uid)) {
                        imap.remove(uid);
                      }
                      list = imap.values.toList();

                      for (var element in list) {
                        for (var elementNew in element.entries) {
                          listCheck.add(elementNew);
                          listCheck.elementAt(0).value['image'];
                        }
                        print("List is: ${listCheck.length}");
                      }
                      return Center(
                        child: ListView.builder(
                            itemCount: listCheck.length,
                            itemBuilder: (context, index) {
                                return Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    title: const Text('Pickup'),
                                                    content:
                                                    SingleChildScrollView(
                                                      child: ListBody(
                                                        children: [
                                                          Text(
                                                              "Date : ${DateFormat("dd-MM-yy").format(DateTime.parse(listCheck[index].value['Start_Date']?? ''))} to ${DateFormat("dd-MM-yy").format(DateTime.parse(listCheck[index].value['End_Date'] ?? ''))}"),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                              "Estimated Weight : ${listCheck[index].value['Weight']?? ''}"),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            'Time : ${listCheck[index].value['Time'] ?? ''}',
                                                          ),
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                          Text(
                                                              "Address : ${listCheck[index].value['Address'] ?? ''}"),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // icon: SizedBox(
                                                    //   height: 100,
                                                    //   width: 80,
                                                    //   child: listCheck[index].value['image']
                                                    // ),
                                                    actions: [
                                                      ElevatedButton(
                                                        child:
                                                        const Text('Confirm'),
                                                        onPressed: () async {
                                                          await FirebaseDatabase.instance.ref("Pickup").child(uid).child(DateTime.now().millisecondsSinceEpoch.toString()).set({
                                                            'Start_Date' : listCheck[index].value['Start_Date'].toString(),
                                                            'End_Date' : listCheck[index].value['End_Date'].toString(),
                                                            'Weight' : listCheck[index].value['Weight'].toString(),
                                                            'Time' : listCheck[index].value['Time'].toString(),
                                                            'Address' : listCheck[index].value['Address'].toString(),
                                                            // 'image': listCheck[index].value['image'],
                                                          }
                                                          // )
                                                          //     .then((value) =>
                                                          //     Navigator.pushNamed(context, '/favorites'),
                                                          );
                                                          ref.child(listCheck[index].value['uid'].toString()).child(listCheck[index].value['dateUid']).remove().whenComplete(() =>
                                                           print("Item removed")
                                                          ).onError((error, stackTrace) =>
                                                          print("error is: $error")
                                                          );
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BuyScreen()));
                                                        },
                                                      ),
                                                      const SizedBox(
                                                        width: 0,
                                                      ),
                                                      TextButton(
                                                        child:
                                                        const Text('Cancel'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ]);
                                              });
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
                                                  height: 100,
                                                  width: 80,
                                                  child: Image.network(
                                                    '${listCheck[index].value['image']}',
                                                    fit: BoxFit.cover,
                                                  )
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
                                                    listCheck[index].value['Address'] ?? '',
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                        FontWeight.w400,
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    listCheck[index].value['Weight'] ?? '',
                                                    style: const TextStyle(),
                                                  ),
                                                  Text(listCheck[index].value['Time'] ?? ''),
                                                  Text(listCheck[index].value['Start_Date'] ??
                                                      ''),
                                                  Text(
                                                      listCheck[index].value['End_Date'] ?? ''),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                );
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
