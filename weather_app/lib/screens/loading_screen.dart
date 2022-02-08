import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getPosition() async {
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
      return await Geolocator.getCurrentPosition(
          forceAndroidLocationManager: false,
          desiredAccuracy: LocationAccuracy.best);
    }

    Position position = await _determinePosition();

    Location location = Location();
    location.getCurrentLocation();
    print('latitude: ${position.latitude}');
    print('longitude : ${position.longitude}');
    print(position);
  }

  void getData() async {
    var response = await http.get(Uri.parse(
        'https://api.openweathermap.org/geo/1.0/direct?q=London&limit=5&appid=b70c4fa4180775f57382edd3aae0ebdc'));
    if (response.statusCode == 200) {
      String data = response.body;

      var name = jsonDecode(response.body)[0]['name'];
      print(name);

      var lat = jsonDecode(response.body)[0]['lat'];
      print(lat);

      var temp = jsonDecode(response.body)[0]['temp'];
      print(temp);

      var condition = jsonDecode(response.body)[0]['condition'];
      print(condition);

      var city = jsonDecode(response.body)[0]['city'];
      print(city);

      print('Response status: ${response.statusCode}');
      //  print('Response body: ${response.body}');
    } else if (response.statusCode >= 400) {
      print('Response status: ${response.statusCode}');
      print('error fetching code');
    } else {
      print('server or other error');
    }
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
