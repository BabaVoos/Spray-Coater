import 'dart:async';
import 'package:flutter/material.dart';

class TimerStep {
  final int index;
  final String name;
  final Duration duration;

  TimerStep({required this.index, required this.name, required this.duration});
}

class TimerService extends ChangeNotifier {
  final List<TimerStep> _activeSteps = [];
  int _currentStepIndex = 0;
  bool _isTimerRunning = false;
  Duration _remainingTime = Duration.zero;
  Timer? _timer;
  bool _isLooping = false;
  int _loopCount = 1;

  List<TimerStep> get activeSteps => List.unmodifiable(_activeSteps);
  bool get isTimerRunning => _isTimerRunning;
  bool get isLooping => _isLooping;
  int get currentStepIndex => _currentStepIndex;
  Duration get remainingTime => _remainingTime;
  String? get stepName =>
      _activeSteps.isNotEmpty ? _activeSteps[_currentStepIndex].name : null;
  int get loopCount => _loopCount;

  void addStep(TimerStep step) {
    final index = _activeSteps.indexWhere((s) => s.index == step.index);
    if (index != -1) {
      _activeSteps[index] = step;
    } else {
      _activeSteps.add(step);
    }
    notifyListeners();
  }

  void startTimer() {
    if (_activeSteps.isEmpty || _isTimerRunning) return;
    _isTimerRunning = true;

    if (_remainingTime.inSeconds == 0 ||
        currentStepIndex >= activeSteps.length) {
      _currentStepIndex = 0;
      _remainingTime = activeSteps[currentStepIndex].duration;
    }
    notifyListeners();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds > 0) {
        _remainingTime -= const Duration(seconds: 1);
        notifyListeners();
      } else {
        _moveToNextStep();
      }
    });
  }

  void _moveToNextStep() {
    _timer?.cancel();
    if (_currentStepIndex < _activeSteps.length - 1) {
      _currentStepIndex++;
      _remainingTime = _activeSteps[_currentStepIndex].duration;
    } else if (_isLooping) {
      _loopCount++;
      _currentStepIndex = 0;
      _remainingTime = _activeSteps[_currentStepIndex].duration;
    } else {
      _isTimerRunning = false;
      notifyListeners();
      return;
    }
    notifyListeners();
    _startCountdown();
  }

  void stopTimer() {
    _timer?.cancel();
    _isTimerRunning = false;
    notifyListeners();
  }

  void resetTimer() {
    stopTimer();
    _activeSteps.clear();
    _currentStepIndex = 0;
    _remainingTime = Duration.zero;
    _isLooping = false;
    _loopCount = 1;
    notifyListeners();
  }

  void toggleLoop() {
    _isLooping = !_isLooping;
    notifyListeners();
  }
}
