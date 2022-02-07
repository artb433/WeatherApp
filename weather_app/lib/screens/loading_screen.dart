import 'package:flutter/material.dart';
import 'package:weather_app/services/location.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getPosition() async {
    Location location = Location();
    location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
  }

  void getData() async {
    var response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  // Future<Position> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     await Geolocator.openLocationSettings();
  //     return Future.error('Location services are disabled.');
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //   return await Geolocator.getCurrentPosition();
  // }

  @override
  void initState() {
    super.initState();
    // getPosition();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    getPosition();
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            getPosition();
          },
          child: const Text('Get location'),
        ),
      ),
    );
  }
}
