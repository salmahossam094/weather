import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HourlyForeCast extends StatelessWidget {
  String temp;
  String timet;
  String iconId;

  HourlyForeCast(this.temp, this.timet, this.iconId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 155.h,
      width: 70.w,
      decoration: BoxDecoration(
          color: Colors.white30, borderRadius: BorderRadius.circular(30.r)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            temp,
            style: GoogleFonts.overpass(
                fontSize: 18.sp,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          ),
          SizedBox(
            height: 23.h,
          ),
          Image.network('http://openweathermap.org/img/w/$iconId.png'),
          SizedBox(
            height: 7.h,
          ),
          Text(
            timet,
            style: GoogleFonts.overpass(
                fontSize: 18.sp,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}
