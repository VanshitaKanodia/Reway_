import 'package:flutter/material.dart';

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
                            const Icon(
                              Icons.star,
                              size: 32,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10, right: 0),
                            ),
                            const Text(
                              'Rs.50000                 ',
                              style: TextStyle(fontSize: 13.5),
                            ),
                            const SizedBox(
                              width: 160,
                            ),
                            IconButton(
                                onPressed: (() {
                                  Navigator.pushNamed(context, '/rating');
                                }),
                                icon: const Icon(Icons.arrow_forward_ios)),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(
                                Icons.fire_truck,
                                size: 32,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10, right: 0),
                              ),
                              const Text(
                                'Pickup on 10/02/2023',
                                style: TextStyle(fontSize: 13.5),
                              ),
                              const SizedBox(
                                width: 160,
                              ),
                              IconButton(
                                  onPressed: (() {}),
                                  icon: const Icon(Icons.arrow_forward_ios)),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
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
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              color: const Color.fromARGB(171, 76, 175, 79),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text('Deal R1'),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              // ignore: sort_child_properties_last
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text('Near you'),
                              ),
                              color: const Color.fromARGB(175, 255, 153, 0),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'High Tech Scrap Dealer',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
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
                                  const Icon(Icons.watch),
                                  const Text(
                                    '6am-9pm',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  const Icon(Icons.location_on),
                                  const Text(
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
                  margin: const EdgeInsets.only(left: 30, right: 30, top: 400),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Items',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2),
                      ),
                      const Text(
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
                        physics: const ScrollPhysics(),
                        padding: const EdgeInsets.all(20),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }
}
