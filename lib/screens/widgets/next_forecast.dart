import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NextForecast extends StatelessWidget {
  String date;
  String image;
  String temp;

  NextForecast(
      {required this.image, required this.temp, required this.date, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
        ' ${temp}°C',
          style: GoogleFonts.overpass(
              fontSize: 18.sp,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
        Image.network('http://openweathermap.org/img/w/$image.png',scale: 0.7,),
        Text(
          date,
          style: GoogleFonts.overpass(
              fontSize: 18.sp,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        )
      ],
    );
  }
}
