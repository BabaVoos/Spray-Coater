import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_palette.dart';

class TextStylesManager {
  static TextStyle font22BoldWhite = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    color: AppPalette.whiteColor,
  );

  static TextStyle font30BoldWhite = GoogleFonts.lakkiReddy(
    fontSize: 28.sp,
    color: AppPalette.whiteColor,
    letterSpacing: 5,
    fontWeight: FontWeight.bold,
  );

  static TextStyle font60BoldBlack = GoogleFonts.jockeyOne(
    fontSize: 40.sp,
    letterSpacing: 10,
    fontWeight: FontWeight.bold,
    color: AppPalette.blackColor,
  );
}
