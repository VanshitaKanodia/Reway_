import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PickupScreen extends StatefulWidget {
  const PickupScreen({super.key});

  @override
  State<PickupScreen> createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref().child('Details');
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
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/map_screen');
              },
              icon: const Icon(
                Icons.location_pin,
              ),
              color: const Color.fromARGB(255, 105, 105, 105),
            )
          ],
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
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
// shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/info_display');
                        },
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Expanded(
                              //   flex: 1,
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: Column(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.stretch,
                              //       children: [
                              //         Image.network(
                              //           'https://blog.ipleaders.in/wp-content/uploads/2020/02/tata_communication_hq_660_100120025251.jpg',
                              //           height: 90,
                              //           fit: BoxFit.fill,
                              //         ),
                              //         const SizedBox(
                              //           height: 10,
                              //         ),
                              //         RatingBar.builder(
                              //           itemSize:
                              //               MediaQuery.of(context).size.width /
                              //                   22,
                              //           initialRating: 3,
                              //           minRating: 1,
                              //           direction: Axis.horizontal,
                              //           allowHalfRating: true,
                              //           itemCount: 5,
                              //           itemBuilder: (context, _) => const Icon(
                              //             Icons.star,
                              //             color: Colors.amber,
                              //           ),
                              //           onRatingUpdate: (rating) {
                              //             print(rating);
                              //           },
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(
                              //   width: 10,
                              // ),
                              // Expanded(
                              //   flex: 2,
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: Column(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       children: [
                              //         Expanded(
                              //           child: StreamBuilder(
                              //             stream: ref.onValue,
                              //             builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                              //               if (snapshot.connectionState == ConnectionState.waiting) {
                              //                 return Center(child: CircularProgressIndicator());
                              //               }
                              //               else if (snapshot.hasData && snapshot.data!.snapshot.exists){
                              //                 Map<dynamic, dynamic> imap = snapshot.data!.snapshot
                              //                     .value as dynamic;
                              //                 List<dynamic> list = [];
                              //                 list.clear();
                              //                 list = imap.values.toList();
                              //                 return ListView.builder(
                              //                     itemCount: snapshot.data!.snapshot.children.length,
                              //                     itemBuilder: (context, index) {
                              //                       Map thisItem = list[index];
                              //                       return ListTile(
                              //                         trailing: Text(thisItem['Weight']) ,
                              //                         title: Text(thisItem['Start Date']),
                              //                         // leading: Text(list[index]['Time']),
                              //                         // leading: Container(
                              //                         //   // height: 30,
                              //                         //   // width: 30,
                              //                         //   child: thisItem.containsKey('image')?Image.network('${thisItem['image']}') : Container(),),
                              //                         subtitle: Text(thisItem['Address']),
                              //                       );
                              //                     });
                              //               }
                              //               else {
                              //                 return Scaffold(
                              //                   body: Center(child: Text('No data found')),
                              //                 );
                              //               }
                              //             },
                              //           ),
                              //         )
                              //
                              //         // Text(
                              //         //   'CYber Mobile Repairer',
                              //         //   style: GoogleFonts.inter(
                              //         //       fontSize: 20,
                              //         //       fontWeight: FontWeight.w600),
                              //         // ),
                              //         // SizedBox(
                              //         //   height: 7,
                              //         // ),
                              //         // Text('A-47 West Patel Nagar'),
                              //         // const Text(
                              //         //     'Description : Total - 70Kgs, 3 Refrigerators, 20 Smartphones....'),
                              //         // SizedBox(
                              //         //   height: 12,
                              //         // ),
                              //         // Text('Minimum Bid : Rs.50000',
                              //         //     style: GoogleFonts.inter(
                              //         //         fontSize: 14,
                              //         //         fontWeight: FontWeight.w500)),
                              //       ],
                              //     ),
                              //   ),
                              // ),


                              Expanded(
                                flex: 2,
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
                                      return ListView.builder(
                                          itemCount: snapshot.data!.snapshot.children.length,
                                          itemBuilder: (context, index) {
                                            Map thisItem = list[index];
                                            return ListTile(
                                              trailing: Text(thisItem['Weight']) ,
                                              title: Text(thisItem['Start Date']),
                                              // leading: Text(list[index]['Time']),
                                              leading: Container(
                                                // height: 30,
                                                // width: 30,
                                                child: thisItem.containsKey('image')?Image.network('${thisItem['image']}') : Container(),),
                                              subtitle: Text(thisItem['Address']),
                                            );
                                          });
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
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
