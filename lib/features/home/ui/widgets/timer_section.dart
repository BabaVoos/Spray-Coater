import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:spray_coater/core/services/timer_services.dart';
import 'package:spray_coater/core/theme/text_styles_manager.dart';
import 'package:spray_coater/features/home/ui/widgets/timer_widget.dart';

class TimerSection extends StatelessWidget {
  const TimerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final timersService = Provider.of<TimerService>(context);

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TimerWidget(
            duration: timersService.remainingTime,
            totalDuration:
                timersService.activeSteps.isNotEmpty
                    ? timersService
                        .activeSteps[timersService.currentStepIndex]
                        .duration
                    : Duration.zero, // Default if no steps exist
          ),
          SizedBox(height: 30.h),
          Text(
            timersService.stepName != null && timersService.stepName!.isNotEmpty
                ? timersService.stepName!
                : 'Step ${timersService.currentStepIndex + 1}',
            style: TextStylesManager.font30BoldWhite,
          ),
          if (timersService.isLooping) ...[
            SizedBox(height: 20.h),
            Text(
              'Cycle ${timersService.loopCount}',
              style: TextStylesManager.font30BoldWhite.copyWith(
                fontSize: 20.sp,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
