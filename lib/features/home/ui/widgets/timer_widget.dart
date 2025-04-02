import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spray_coater/core/theme/app_palette.dart';
import 'package:spray_coater/core/theme/text_styles_manager.dart';

class TimerWidget extends StatelessWidget {
  final Duration duration;
  final Duration totalDuration;

  const TimerWidget({
    super.key,
    required this.duration,
    required this.totalDuration,
  });

  @override
  Widget build(BuildContext context) {
    String formatDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "$twoDigitMinutes:$twoDigitSeconds";
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 0.6.sw,
          height: 0.6.sw,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppPalette.blackColor,
              boxShadow: [
                BoxShadow(
                  color: AppPalette.primaryColor,
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Center(
              child: Text(
                formatDuration(duration),
                style: TextStylesManager.font60BoldBlack.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        CircularProgressIndicator(
          constraints: BoxConstraints.expand(width: 0.6.sw, height: 0.6.sw),
          strokeWidth: 5,
          value:
              totalDuration.inSeconds > 0
                  ? duration.inSeconds / totalDuration.inSeconds
                  : 0,
          backgroundColor: AppPalette.greyColor,

          valueColor: AlwaysStoppedAnimation<Color>(AppPalette.primaryColor),
        ),
      ],
    );
  }
}
