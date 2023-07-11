import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/CurrentResponseModel.dart';

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({super.key});

  static const String routeName = 'Forecast';

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
            )
          ],
        ),
      ),
    );
  }
}
