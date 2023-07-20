import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geo_chat/controller/permission_gps.dart';
import 'package:geo_chat/view/google_carte.dart';
import 'package:lottie/lottie.dart';

class MyMapView extends StatefulWidget {
  const MyMapView({super.key});

  @override
  State<MyMapView> createState() => _MyMapViewState();
}

class _MyMapViewState extends State<MyMapView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
      future: PermissionGps().init(),
      builder: (context, snap) {
        if(snap.data == null) {
          return Container(
            child: Center(
              child: Lottie.asset("assets/mainAnimation.json")
            ),
          );
        } else {
          Position location = snap.data!;
          return CarteGoogle(location: location);
        }
      }
    );
  }
}
