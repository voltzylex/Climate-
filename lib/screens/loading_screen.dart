import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';

const apikey = 'f267658008c4ceed2e43cecfb2e5087f';

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
    myLocation.getCurrentLocation(); //getting data here
    print('App has been started');
  }

  Future getLocationData() async {
    Location myLocation = Location();
    
    await myLocation.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${myLocation.latitude}&lon=${myLocation.longitude}&appid=$apikey&units=metric'));

    var weatherData = await networkHelper.getData();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationScreen: weatherData,
      );
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
    // print("After hot reload or in context");
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
