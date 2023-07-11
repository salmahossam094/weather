import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/CurrentResponseModel.dart';
import 'package:weather_app/screens/widgets/hourly_forecast.dart';
import 'package:weather_app/screens/widgets/next_forecast.dart';

import '../models/ForecastModel.dart';
import '../remote/api_manager.dart';

class WeatherForecast extends StatefulWidget {
  WeatherForecast({super.key});

  static const String routeName = 'Forecast';

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)?.settings.arguments as CurrentResponseModel;
    var date = DateFormat('dd-MMM-yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch((args.dt ?? 0) * 1000));
    return Scaffold(
      backgroundColor: const Color(0xFF47b8e3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(args.name ?? ''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 49.h,
            ),
            Row(
              children: [
                Text(
                  'Today',
                  style: GoogleFonts.overpass(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
                Spacer(),
                Text(
                  date,
                  style: GoogleFonts.overpass(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                )
              ],
            ),
            FutureBuilder<ForecastModel>(
              future: ApiManager()
                  .getForecast(lat: args.coord!.lat!, lon: args.coord!.lon!),
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
                var data = snapshot.data;
                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  HourlyForeCast(
                                      data!.list![index].main!.temp.toString(),
                                      data.list![index].dtTxt!
                                          .substring(10, 16),
                                      data.list![index].weather![0].icon ?? ''),
                                  SizedBox(width: 12.w)
                                ],
                              ),
                            );
                          },
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      Text(
                        'Next Forecast',
                        style: GoogleFonts.overpass(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemBuilder: (context, index)
                        {  var date1 = DateFormat('dd-MMM-yyyy').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                (data.list![index].dt ?? 0) * 1000));
                           return NextForecast(
                            image: data.list![index].weather![0].icon!,
                            temp: data.list![index].main!.feelsLike.toString(),
                            date: date1);},
                        itemCount: data!.cnt!.toInt(),
                        scrollDirection: Axis.vertical,
                      ))
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
