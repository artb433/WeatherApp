import 'package:flutter/material.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  const LocationScreen({Key? key, this.locationWeather}) : super(key: key);

  //double temperature = weatherData['main']['temp'];
  // double condition=jsonDecode(weatherData)['weather'][0]['id'];
  // String cityName=jsonDecode(locationWeather)['name'];

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double? temperature;
  int? condition;
  String? country;
  void updateUI(dynamic weatherData) {
    temperature = jsonDecode(weatherData)['main']['temp'];
    condition = jsonDecode(weatherData)['weather'][0]['id'];
    country = jsonDecode(weatherData)['name'];
  }
  // Future getPosition() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.low);
  // }

//  temperature = weatherData['main']['temp'];
//  condition = weatherData['weather'][0]['id'];
// cityName = weatherData['name'];

// temperature= jsonDecode(locationWeather)['main']['temp'];
// condition = jsonDecode(data)['weather'][0]['id'];
// cityName = jsonDecode(data)['name'];

  @override
  Widget build(BuildContext context) {
    updateUI(widget.locationWeather);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '☀️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "It's 🍦 time in $country!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// var temp = jsonDecode(data)['main']['temp'];
// var condition = jsonDecode(data)['weather'][0]['id'];
//var country = jsonDecode(data)['name'];
  