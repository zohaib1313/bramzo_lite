import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primaryBlueColor = blueBoxSelected;

  static const grey = Color(0x33707070);
  static const lightGrey = Color(0xffC3DAF9);
  static const lightGrey2 = Color(0xffE4EFFF);
  static const lightGrey3 = Color(0xffBDD4F1);
  static const orangeText = Color(0xffFF9C37);
  static const orangeBox1 = Color(0xffF5AF48);
  static const orangeBox2 = Color(0xffFEBB5A);

  static const red = Colors.red;
  static const black = Color(0xff000000);
  static const blueBoxSelected = Color(0xff52728D);
  static const blueBoxUnSelected = Color(0xffB4CAE6);
}

class AppTextStyles {
  static final _fontBold = GoogleFonts.poppins(
    textStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        color: Colors.black,
        letterSpacing: 0.5),
  );

  static final _fontBoldMedium = GoogleFonts.poppins(
    textStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: Colors.black,
        letterSpacing: 0.5),
  );
  static final _fontNormal = GoogleFonts.poppins(
      textStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          letterSpacing: 0.5,
          fontStyle: FontStyle.normal,
          color: Colors.black));

  static TextStyle textStyleBoldSubTitleLarge =
      _fontBold.copyWith(fontSize: 28.sp, letterSpacing: 1);

  static TextStyle textStyleNormalLargeTitle =
      _fontNormal.copyWith(fontSize: 28.sp);

  static TextStyle textStyleBoldBodyMedium =
      _fontBoldMedium.copyWith(fontSize: 20.sp);
  static TextStyle textStyleNormalBodyMedium =
      _fontNormal.copyWith(fontSize: 20.sp);

  static TextStyle textStyleBoldBodySmall = _fontBold.copyWith(fontSize: 18.sp);
  static TextStyle textStyleNormalBodySmall =
      _fontNormal.copyWith(fontSize: 18.sp);

  static TextStyle textStyleBoldBodyXSmall =
      _fontBold.copyWith(fontSize: 14.sp);
  static TextStyle textStyleNormalBodyXSmall =
      _fontNormal.copyWith(fontSize: 14.sp);
}
