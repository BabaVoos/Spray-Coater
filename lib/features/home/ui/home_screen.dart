import 'package:flutter/material.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:spray_coater/features/home/ui/widgets/control_buttons.dart';
import 'package:spray_coater/features/home/ui/widgets/timer_section.dart';
import 'package:spray_coater/features/home/ui/widgets/timers_list.dart';
import 'package:spray_coater/core/theme/app_palette.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.backgroundColor,
      body: Column(
        children: [
          TimersList(),
          SizedBox(height: 50.h),
          TimerSection(),
          ControlButtons(),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }
}
