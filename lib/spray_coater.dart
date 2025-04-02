import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spray_coater/features/home/ui/home_screen.dart';

class SprayCoater extends StatelessWidget {
  const SprayCoater({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder:
          (context, child) => const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
          ),
    );
  }
}
