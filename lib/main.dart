import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:spray_coater/core/services/timer_services.dart';
import 'package:spray_coater/spray_coater.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(
    ChangeNotifierProvider(
      create: (context) => TimerService(),
      child: SprayCoater(),
    ),
  );
}
