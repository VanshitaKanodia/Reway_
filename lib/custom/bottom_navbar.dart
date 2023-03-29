import 'package:flutter/material.dart';

//test commit
class BottomNavbar extends StatefulWidget {
  const BottomNavbar({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.home),
                  onPressed: (() {
                    Navigator.pushNamed(context, '/home');
                    // Navigator.pushNamed(context, '/home');
                  }),
                ),
              ),
              const Text('Home'),
            ],
          ),
          const Divider(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.list_alt),
                  onPressed: (() {
                    Navigator.pushNamed(context, '/my_orders');
                  }),
                ),
              ),
              const Text('Pickups'),
            ],
          ),
          const Divider(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.money),
                  onPressed: (() {
                    Navigator.pushNamed(context, '/favorites');
                  }),
                ),
              ),
              const Text('Auctions'),
            ],
          ),
          const Divider(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.inbox_outlined),
                  onPressed: (() {
                    Navigator.pushNamed(context, '/inbox');
                  }),
                ),
              ),
              const Text('Inbox'),
            ],
          ),
          const Divider(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.account_box_sharp),
                  onPressed: (() {
                    Navigator.pushNamed(context, '/account_profile');
                  }),
                ),
              ),
              const Text('Account'),
            ],
          ),
        ],
      ),
    );
  }
}
