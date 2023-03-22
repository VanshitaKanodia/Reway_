// ignore_for_file: unused_import, unused_element, depend_on_referenced_packages, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../utils/maps_constants.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  String location = 'home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: FlutterMap(
              options: MapOptions(
                minZoom: 5,
                maxZoom: 18,
                zoom: 13,
                center: AppConstants.myLocation,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      'https://api.mapbox.com/styles/v1/vasuk14/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}',
                  additionalOptions: {
                    'mapStyleId': AppConstants.mapBoxStyleId,
                    'accessToken': AppConstants.mapBoxAccessToken,
                  },
                ),
                MarkerLayerOptions(markers: [
                  Marker(
                      point: AppConstants.myLocation,
                      builder: (context) {
                        return GestureDetector(
                          onTap: () {},
                          child: Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUtaEAIaXW0jktXeKuM3ljNt9o1boZpcSBWFBpxv4&s',
                          ),
                        );
                      })
                ]),
              ],
            ),
          ),
          Positioned(
              top: 20,
              left: 10,
              child: IconButton(
                  onPressed: (() {
                    Navigator.pop(context);
                  }),
                  icon: Icon(Icons.arrow_back_ios))),
        ],
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Location',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(suffixIcon: Icon(Icons.note_alt)),
                ),
                SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: Text('Home',style: TextStyle(fontSize: 10),),
                        value: 'home',
                        groupValue: location,
                        onChanged: (value) {
                          setState(() {
                            location = value.toString();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: Text('Work',style: TextStyle(fontSize: 10),),
                        value: 'work',
                        groupValue: location,
                        onChanged: (value) {
                          setState(() {
                            location = value.toString();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: Text('Others',style: TextStyle(fontSize: 10),),
                        value: 'others',
                        groupValue: location,
                        onChanged: (value) {
                          setState(() {
                            location = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        'Confirm',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
