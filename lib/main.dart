import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:wheather_app/services/weather_api.dart';
import 'package:wheather_app/widgets/additional_information.dart';
// import 'package:wheather_app/widgets/additional_information.dart';
import 'package:wheather_app/widgets/current_weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'model/weather_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Api',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool isLoading=false;
  final _cityTextController=TextEditingController();
  final _dataService=DetaService();
  WeatherResponse? _response=null;
  // final String city="ahmedabad";


  Widget appBarTitle=new Text("Weather App");
  Icon actionIcon=new Icon(Icons.search);
  Icon curruntLoc=new Icon(CupertinoIcons.location_circle);


  Future<void> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print('Lat: ${position.latitude} , Long: ${position.longitude}');
    final response=await _dataService.getWeather(position);
    setState(()=>_response=response);
  }
  // Future<void> GetAddressFromLatLong(Position position)async {
  //   List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
  //   print(placemarks);
  //   Placemark place = placemarks[0];
  //   Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  //   setState(()  {
  //   });
  // }
  //

  Future<void> _search() async {
    final response=await _dataService.getCityWeather(_cityTextController.text);
    setState(()=>_response=response);
    print(_response!.systemInfo!.country);
  }

  _sear(){
    print("data is not null");
  }
  @override
  Widget build(BuildContext context) {

    final city=TextFormField(

      autofocus: false,
      controller:_cityTextController,
      keyboardType: TextInputType.name,

      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "City",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),

    );


    final submitButton=Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,

      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          _search();
          _cityTextController.clear();
        },
        child: Text("Submit",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
      ),
    );

    final submitButton1=Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,

      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
           _getGeoLocationPosition();
           //Position position = await

        },
        child: isLoading?CircularProgressIndicator(color: Colors.blue): Text("Current-Location",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
      ),
    );
    return Scaffold(
      // backgroundColor: Color(0xFFf9f9f9),
        appBar: new AppBar(
          title: appBarTitle,
          actions: [
            new IconButton(
                onPressed: (){
                  _getGeoLocationPosition();
                },
                icon: curruntLoc,
            ),
            new IconButton(
              onPressed: (){
                setState(() {
                  if(this.actionIcon.icon==Icons.search){
                    this.actionIcon=new Icon(Icons.close);
                    this.curruntLoc=new Icon(Icons.clear);

                    this.appBarTitle=new TextField(
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                      decoration: new InputDecoration(
                        prefixIcon: new IconButton(
                            onPressed: (){
                              _search();
                              _cityTextController.clear();
                            },
                            icon: new Icon(Icons.search,color: Colors.white),

                        ),
                        hintText: "Search city......",
                        hintStyle: new TextStyle(color: Colors.white),
                      ),
                      controller: _cityTextController,
                    );

                  }
                  else{
                    this.actionIcon=new Icon(Icons.search);
                    this.curruntLoc=new Icon(CupertinoIcons.location_circle);
                    this.appBarTitle=new Text("Weather");
                  }
                });
              },
              icon: actionIcon,
            )
          ],
        ),

        body: FutureBuilder(
          future: _response==null?_getGeoLocationPosition():_sear(),
          builder: (context, snapshot) {
            return Column(
              children: <Widget>[
                _response!=null?
                  Column(
                    children: [
                      Image.network('${_response!.iconUrl}'),
                      const SizedBox(height: 2,),
                      Text('${_response!.weatherInfo!.main}',
                        style: const TextStyle(
                            fontSize: 20
                        ),
                      ),
                      currentWeather('${_response!.tempInfo!.temperatur}','${_response!.cityName}','${_response!.weatherInfo!.description}','${_response!.systemInfo!.country}'),
                      additionalInformation('${_response!.weatherInfo!.main}', '${_response!.weatherInfo!.description}')
                    ],
                  )

                :Center(
                  child: CircularProgressIndicator(),
                ),


                // city,
                // SizedBox(height: 10),
                // submitButton,
                // SizedBox(height: 10),
                // submitButton1,
                // SizedBox(height: 10),



              ],
            );
          },
        )
    );
  }
}
