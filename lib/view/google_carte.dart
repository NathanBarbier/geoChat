import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geo_chat/controller/firestore_helper.dart';
import 'package:geo_chat/view/messagerie.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../globale.dart';
import '../model/my_user.dart';

class CarteGoogle extends StatefulWidget {
  final Position location;
  const CarteGoogle({super.key, required this.location});

  @override
  State<CarteGoogle> createState() => _CarteGoogleState();
}

class _CarteGoogleState extends State<CarteGoogle> {
  Completer<GoogleMapController> completer = Completer();
  late CameraPosition camera;
  List<MyUser> otherUser = [];

  @override
  void initState() {
    camera = CameraPosition(
      target: LatLng(widget.location.latitude, widget.location.longitude),
      zoom: 14
    );

    getAllUsers();

    Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {

        me.location = GeoPoint(widget.location.latitude, widget.location.longitude);

        Map<String,dynamic> map = {
          "POSITION": me.location
        };

        FirestoreHelper().updateUser(me.id, map);
      });
    });

    super.initState();
  }

  getAllUsers() async {
    try {
      QuerySnapshot snapshot = await FirestoreHelper().cloudUsers.get();
      for (var doc in snapshot.docs) {
        MyUser user = MyUser(doc);

        if (user.id == me.id) {
          continue;
        }

        otherUser.add(user);
      }
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  Set<Marker>getMarkers() {
    Set<Marker> markers = {};
    for (var user in otherUser) {
      if (user.location == null) {
        continue;
      }

      markers.add(
          Marker(
              markerId: MarkerId(user.id),
              position: LatLng(
                  user.location!.latitude,
                  user.location!.longitude
              ),
              infoWindow: InfoWindow(title: user.fullname, snippet: ''),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return MyMessagerie(user: user);
                }));
              }
          )
      );
    }



    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: camera,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      onMapCreated: (control) async {
        String newStyle = await DefaultAssetBundle.of(context).loadString("lib/mapStyle.json");
        control.setMapStyle(newStyle);
        completer.complete(control);
      },
      markers: getMarkers(),
    );
  }
}
