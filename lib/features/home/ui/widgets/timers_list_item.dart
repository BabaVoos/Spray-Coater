import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spray_coater/core/services/timer_services.dart';
import '../../../../core/theme/app_palette.dart';

class TimersListItem extends StatefulWidget {
  final bool isActive;
  final int index;
  final Function(TimerStep) onStepAdded;
  final String timerName;
  final Duration timerDuration;

  const TimersListItem({
    super.key,
    this.isActive = false,
    required this.index,
    required this.onStepAdded,
    required this.timerName,
    required this.timerDuration,
  });

  @override
  _TimersListItemState createState() => _TimersListItemState();
}

class _TimersListItemState extends State<TimersListItem> {
  late Duration _selectedTime;
  late TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: _showCupertinoSheet,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Icon(
            widget.isActive ? Icons.timer : Icons.timer_outlined,
            color:
                widget.isActive ? AppPalette.whiteColor : AppPalette.greyColor,
            size: widget.isActive ? 30.r : 25.r,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _nameController.text = widget.timerName;
  }

  Widget _buildCupertinoSheet() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          height: .7.sh,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              TextField(
                cursorColor: AppPalette.primaryColor,
                controller: _nameController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: "Step Name",
                  labelStyle: TextStyle(color: AppPalette.primaryColor),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppPalette.primaryColor,
                      width: 2,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppPalette.primaryColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.ms,
                  initialTimerDuration: _selectedTime,
                  onTimerDurationChanged:
                      (newTime) => setState(() => _selectedTime = newTime),
                ),
              ),
              SizedBox(height: 20.h),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.h),
                  backgroundColor: AppPalette.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                onPressed: () {
                  if (_selectedTime == Duration.zero) return;
                  widget.onStepAdded(
                    TimerStep(
                      index: widget.index,
                      name: _nameController.text,
                      duration: _selectedTime,
                    ),
                  );
                  _nameController.clear();
                  _selectedTime = Duration.zero;
                  Navigator.pop(context);
                },
                child: Text(
                  "Save",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCupertinoSheet() {
    _nameController.text = widget.timerName;
    _selectedTime = widget.timerDuration;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _buildCupertinoSheet(),
    );
  }
}
