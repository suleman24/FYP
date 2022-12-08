import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class googlemaps extends StatefulWidget {
  const googlemaps({Key? key}) : super(key: key);

  @override
  State<googlemaps> createState() => _googlemapsState();
}

class _googlemapsState extends State<googlemaps> {
  static final LatLng _kMapCenter =
  LatLng(30.030997, 72.314343);

  static final CameraPosition _kInitialPosition =
  CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Google Maps'),
        ),
        body: GoogleMap(
        initialCameraPosition: _kInitialPosition,
      ),
      ),
    );
  }
}
