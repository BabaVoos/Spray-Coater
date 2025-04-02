import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:spray_coater/core/services/timer_services.dart';
import 'package:spray_coater/features/home/ui/widgets/app_button.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final timersService = Provider.of<TimerService>(context, listen: true);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        spacing: 20.w,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AppButton(
            text: timersService.isTimerRunning ? 'Stop' : 'Start',
            onPressed:
                timersService.isTimerRunning
                    ? timersService.stopTimer
                    : timersService.activeSteps.isNotEmpty
                    ? timersService.startTimer
                    : null,
          ),
          AppButton(
            text: 'Reset',
            onPressed:
                timersService.activeSteps.isNotEmpty
                    ? timersService.resetTimer
                    : null,
          ),
          AppButton(
            text: timersService.isLooping ? 'Stop Loop' : 'Loop',
            onPressed:
                timersService.activeSteps.isNotEmpty
                    ? timersService.toggleLoop
                    : null,
          ),
        ],
      ),
    );
  }
}
