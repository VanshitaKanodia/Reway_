import 'package:flutter/material.dart';
import '../custom/bottom_navbar.dart';


class InfoDisplayScreen extends StatefulWidget {
  const InfoDisplayScreen({super.key});

  @override
  State<InfoDisplayScreen> createState() => _InfoDisplayScreenState();
}

class _InfoDisplayScreenState extends State<InfoDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.network(
                    'https://thumbs.dreamstime.com/z/mobile-phone-scrap-pile-damage-46322322.jpg',
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.3),

                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.star,
                                size: 32,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:10, right:0),
                              ),
                              Text(
                                'Rs.50000                 ',
                                style: TextStyle(fontSize: 13.5),
                              ),
                              SizedBox(
                                width: 160,
                              ),
                              IconButton(
                                  onPressed: (() {
                                    Navigator.pushNamed(context, '/rating');
                                  }),
                                  icon: Icon(Icons.arrow_forward_ios)),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.fire_truck,
                                  size: 32,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:10, right:0),
                                ),
                                Text(
                                  'Pickup on 10/02/2023',
                                  style: TextStyle(fontSize: 13.5),
                                ),
                                SizedBox(
                                  width: 160,
                                ),
                                IconButton(
                                    onPressed: (() {}),
                                    icon: Icon(Icons.arrow_forward_ios)),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    // height: 300,
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.12,
                    left: 60,
                    right: 60,
                    height: MediaQuery.of(context).size.height * 0.16,
                    child: Card(
                      elevation: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                color: Color.fromARGB(171, 76, 175, 79),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text('Deal R1'),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                // ignore: sort_child_properties_last
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text('Near you'),
                                ),
                                color: Color.fromARGB(175, 255, 153, 0),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'High Tech Scrap Dealer',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  textBaseline: TextBaseline.ideographic,
                                  children: [
                                    Icon(Icons.watch),
                                    Text(
                                      '6am-9pm',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Icon(Icons.location_on),
                                    Text(
                                      '2km',
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(left: 30, right: 30, top: 400),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Items',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2),
                        ),
                        Text(
                          'View All',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.47),
                    width: MediaQuery.of(context).size.width,
                    child: Expanded(
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          padding: EdgeInsets.all(20),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 20.0,
                            mainAxisSpacing: 10.5,
                            crossAxisCount: 2,
                          ),
                          itemCount: 30,
                          itemBuilder: ((context, index) {
                            return Container(
                              height: 50,
                              color: Colors.pink,
                            );
                          })),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavbar());
  }
}
