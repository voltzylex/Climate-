import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Location myLocation = Location();

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    myLocation.getPermission();
    myLocation.getCurrentLocation();

    print('App has been deactivated');
  }

  void getData() async {
    http.Response response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=28.47852941693939&lon=77.34365728683741&appid=f267658008c4ceed2e43cecfb2e5087f#'),
    );

    if (response.statusCode == 200) {
      String data = response.body;
      var decodeData = jsonDecode(data);
      var id = decodeData["weather"][0]["id"];
      var temprature = decodeData["main"]["temp"];
      var city = decodeData["name"];
      var latitude = decodeData["coord"]['lat'];
      var longitude = decodeData["coord"]['lon'];

      print(id);
      print(temprature);
      print(city);
      print(latitude);
      print(longitude);
    } else {
      print(response.statusCode);
    }
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('App has been deactivated');
  }

  @override
  Widget build(BuildContext context) {
    getData();
    myLocation.getCurrentLocation();
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
            ),
          ],
        ),
      ),
    );
  }
}
