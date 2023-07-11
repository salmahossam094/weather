import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:weather_app/models/CurrentResponseModel.dart';
import 'package:weather_app/remote/api_manager.dart';
import 'package:weather_app/screens/widgets/weather_info.dart';

import '../screens/weather_forecast.dart';

class HomeLayout extends StatefulWidget {
  HomeLayout({super.key});

  static const String routeName = 'HomeLayout';

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  Location location = Location();

  PermissionStatus? permissionStatus;

  bool isServiceEnable = false;

  LocationData? locationData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    CurrentResponseModel? responseModel;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF47b8e3),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            locationData != null
                ? FutureBuilder<CurrentResponseModel>(
                    future: ApiManager().getCurrentWeather(locationData!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        ));
                      }
                      if (snapshot.hasError) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: Text('${snapshot.error}'),
                        );
                      }
                      var res = snapshot.data!;
                      responseModel = res;
                      var date = DateFormat('dd-MMM-yyyy').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              (res.dt ?? 0) * 1000));
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 52.h,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  res.name ?? '',
                                  style: GoogleFonts.overpass(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.sp),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 66.h,
                            ),
                            Center(
                              child: Container(
                                  width: 320.w,
                                  height: 320.h,
                                  decoration: BoxDecoration(
                                      color: Colors.white30,
                                      borderRadius:
                                          BorderRadius.circular(30.r)),
                                  child: WeatherInfo(
                                      date: date,
                                      temp: res.main!.temp.toString(),
                                      image: res.weather![0].icon ?? '',
                                      mood: res.weather![0].main ?? '',
                                      windSpeed: res.wind!.speed.toString(),
                                      hum: res.main!.humidity.toString())),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : const Center(child: CircularProgressIndicator())
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(40.0),
          child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, WeatherForecast.routeName,
                    arguments: responseModel);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: Text(
                'Forecast report',
                style: GoogleFonts.overpass(
                  color: const Color(0xFF444E72),
                  fontSize: 18.sp,
                ),
              )),
        ),
      ),
    );
  }

  Future<bool> isPermissionGranted() async {
    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      return permissionStatus == PermissionStatus.granted;
    }
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> isServiceEnabled() async {
    isServiceEnable = await location.serviceEnabled();
    if (!isServiceEnable) {
      isServiceEnable = await location.requestService();
    }
    return isServiceEnable;
  }

  Future<void> getCurrentLocation() async {
    bool permission = await isPermissionGranted();
    if (!permission) return;
    bool service = await isServiceEnabled();
    if (!service) return;
    locationData = await location.getLocation();

    setState(() {});
    // location.onLocationChanged.listen((event) {
    //   locationData = event;
    //   setState(() {
    //
    //   });
    // });
  }
}
