import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class BuyScreen extends StatefulWidget {
  const BuyScreen({super.key});

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {

  @override
  Widget build(BuildContext context) {
    final DatabaseReference ref = FirebaseDatabase.instance.ref().child('Pickup').child(FirebaseAuth.instance.currentUser!.uid);
    @override

    void initState(){
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
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       Navigator.pushNamed(context, '/map_screen');
          //     },
          //     icon: Icon(
          //       Icons.location_pin,
          //     ),
          //     color: Color.fromARGB(255, 105, 105, 105),
          //   )
          // ],
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 105, 105, 105),
            ),
          ),
          title: Text(
            'Scheduled Pickups',
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
                      flex: 4,
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          prefixIcon: Icon(
                            Icons.search,
                            size: 32,
                          ),
                          fillColor: Color.fromARGB(255, 212, 212, 212),
                          hintText: 'Search Recyclers',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 104, 104, 104),
                            fontSize: 25,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      color: Color.fromARGB(255, 212, 212, 212),
                      child: IconButton(
                        iconSize: 30,
                        color: Color.fromARGB(255, 104, 104, 104),
                        onPressed: () {},
                        icon: Icon(Icons.filter_alt),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: ref.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    else if (snapshot.hasData && snapshot.data!.snapshot.exists){
                      Map<dynamic, dynamic> imap = snapshot.data!.snapshot
                          .value as dynamic;
                      List<dynamic> list = [];
                      list.clear();
                      list = imap.values.toList();
                      return Center(
                        child: ListView.builder(
                            itemCount: snapshot.data!.snapshot.children.length,
                            itemBuilder: (context, index) {
                              Map thisItem = list[index];
                              return Row(
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
                                          // child: Image.network(
                                          //   '${thisItem[index].value['image']}',
                                          //   fit: BoxFit.cover,
                                          // )
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
                                          thisItem['Address'] ?? '',
                                          maxLines: 2,
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight.w400,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          thisItem['Weight'] ?? '',
                                          style: const TextStyle(),
                                        ),
                                        Text(thisItem['Time'] ?? ''),
                                        Text(thisItem['Start_Date'] ??
                                            ''),
                                        Text(
                                            thisItem['End_Date'] ?? ''),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                      );
                    }
                    else {
                      return Scaffold(
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

