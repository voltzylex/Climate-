import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';

Location myLocation = Location();

const apikey = 'f267658008c4ceed2e43cecfb2e5087f';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myLocation.getPermission();
    myLocation.getCurrentLocation();
    print('App has been started');
  }

  void getLocationData() async {
    latitude = myLocation.latitude;
    longitude = myLocation.longitude;
    NetworkHelper networkHelper = NetworkHelper(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apikey'));

    var weatherData = await networkHelper.getData();
    print(latitude);
    print(longitude);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen();
    }));
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('App has been deactivated');
  }

  @override
  Widget build(BuildContext context) {
    // myLocation.getCurrentLocation();
    getLocationData();
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.amber,
          size: 100.0,
        ),
      ),
    );
  }
}
