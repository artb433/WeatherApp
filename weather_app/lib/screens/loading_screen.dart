import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // void getPosition() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.low);
  //   print(position);
  // }

  @override
  void initState() {
    // TODO: implement initState

    Future<Position> _determinePosition() async {
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return Future.error('Location services are disabled.');
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      return await Geolocator.getCurrentPosition();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: Center(
        //   // ignore: deprecated_member_use
        //   child: RaisedButton(
        //     onPressed: () async {
        //       //getPosition();
        //       Position position = await _determinePosition();
        //       print(position);
        //       //Get the current location
        //     },
        //     child: const Text('Get Location'),
        //   ),
        // ),
        );
  }
}
