import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({super.key});

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  @override
  Widget build(BuildContext context) {
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
            'Auctions',
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
                  itemCount: 10,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/info_display');
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.width / 2.56,
                          width: MediaQuery.of(context).size.width / 1.56,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Image.asset(
                                        'assets/image/img_1.png',
                                        height:
                                            MediaQuery.of(context).size.width /
                                                3.62,
                                        fit: BoxFit.fill,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      RatingBar.builder(
                                        itemSize:
                                            MediaQuery.of(context).size.width /
                                                22,
                                        initialRating: 3,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hi-Tech Scrap Dealer',
                                        style: GoogleFonts.inter(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text('A-47 West Patel Nagar'),
                                      const Text(
                                          'Description : Total - 70Kgs, 3 Refrigerators, 20 Smartphones....'),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text('Minimum Bid : Rs.50000',
                                          style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              ),
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
