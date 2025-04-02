import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:spray_coater/core/theme/app_palette.dart';
import 'package:spray_coater/core/services/timer_services.dart';
import 'package:spray_coater/features/home/ui/widgets/timers_list_item.dart';

class TimersList extends StatelessWidget {
  const TimersList({super.key});

  @override
  Widget build(BuildContext context) {
    final timersService = Provider.of<TimerService>(context);

    return SizedBox(
      height: 120.h,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppPalette.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.r),
            bottomRight: Radius.circular(30.r),
          ),
          boxShadow: [
            BoxShadow(
              color: AppPalette.primaryColor,
              spreadRadius: 2,
              blurRadius: 10,
              blurStyle: BlurStyle.outer,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              6,
              (index) => TimersListItem(
                isActive: timersService.activeSteps.any(
                  (step) => step.index == index,
                ),
                timerDuration:
                    timersService.activeSteps
                        .firstWhere(
                          (step) => step.index == index,
                          orElse:
                              () => TimerStep(
                                index: index,
                                name: 'Step ${index + 1}',
                                duration: Duration.zero,
                              ),
                        )
                        .duration,
                timerName:
                    timersService.activeSteps
                        .firstWhere(
                          (step) => step.index == index,
                          orElse:
                              () => TimerStep(
                                index: index,
                                name: 'Step ${index + 1}',
                                duration: Duration.zero,
                              ),
                        )
                        .name,
                index: index,
                onStepAdded: (TimerStep step) {
                  timersService.addStep(step);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
