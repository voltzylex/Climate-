import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;

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
          'https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=f267658008c4ceed2e43cecfb2e5087f'),
    );
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
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
    return Scaffold(
      body: Center(),
    );
  }
}
