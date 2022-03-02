import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//const apiKey = 'b70c4fa4180775f57382edd3aae0ebdc';
const apiKey = 'b70c4fa4180775f57382edd3aae0ebdc';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;

  Future getPosition() async {
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

    // Location location = Location();
    // location.getCurrentLocation();
    latitude = position.latitude;
    longitude = position.longitude;
    print(position);
    // print(
    //     'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    getData();
  }

  Future getData() async {
    var response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey'));
    //print( 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    if (response.statusCode == 200) {
      String data = response.body;
      //print(data);

      // var temp = jsonDecode(data)['main']['temp'];
      // print(temp);

      // var condition = jsonDecode(data)['weather'][0]['id'];
      // print(condition);

      // var country = jsonDecode(data)['name'];
      // print(country);

      print('Response status: ${response.statusCode}');
      // Nooooooooooooooooooooooooooooooooooooooooooooottttttttttttttttttttttttteeeeeeeee
      //print('Response body: ${response.body}');
    } else if (response.statusCode >= 400) {
      print('Response status: ${response.statusCode}');
      print('error fetching code');
    } else {
      print('server or other error');
    }

    var weatherData = await getData();
    //print('weather data is $weatherData');

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LocationScreen(
                locationWeather: weatherData,
              )),
    );
    return response;
  }

  @override
  void initState() {
    super.initState();
    // getPosition();
  }

  @override
  Widget build(BuildContext context) {
    //getData();
    getPosition();
    return const Scaffold(
      body: Center(
        child: SpinKitWanderingCubes(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
