import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherInfo extends StatelessWidget {
  String date;
  String temp;
  String image;

  WeatherInfo(
      {required this.date,
      required this.temp,
      required this.image,
      required this.mood,
      required this.windSpeed,
      required this.hum,
      super.key});

  String mood;
  String windSpeed;
  String hum;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          date,
          style: GoogleFonts.overpass(
              fontSize: 18.sp,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
        SizedBox(
          height: 12.h,
        ),
        Text(
          '$temp °C',
          style: GoogleFonts.overpass(
              fontSize: 80.sp,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
        SizedBox(
          height: 15.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'http://openweathermap.org/img/w/$image.png',
            ),
            SizedBox(
              width: 6.w,
            ),
            Text(
              mood ,
              style: GoogleFonts.overpass(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ],
        ),
        SizedBox(
          height: 27.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              FontAwesomeIcons.wind,
              color: Colors.white,
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              'Wind',
              style: GoogleFonts.overpass(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
            SizedBox(
              width: 23.w,
            ),
            Container(
              width: 1.5.w,
              color: Colors.white,
              height: 20.h,
            ),
            SizedBox(
              width: 23.w,
            ),
            Text(
              '$windSpeed km/h',
              style: GoogleFonts.overpass(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            )
          ],
        ),
        SizedBox(
          height: 16.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.water_drop_outlined,
              color: Colors.white,
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              'Hum',
              style: GoogleFonts.overpass(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
            SizedBox(
              width: 30.w,
            ),
            Container(
              width: 1.5.w,
              color: Colors.white,
              height: 20.h,
            ),
            SizedBox(
              width: 20.w,
            ),
            Text(
              '$hum %',
              style: GoogleFonts.overpass(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            )
          ],
        )
      ],
    );
  }
}
