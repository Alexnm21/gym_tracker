import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gym_tracker/config/app_theme.dart';

class ChronometerButton extends StatelessWidget {
  const ChronometerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.white,
      style: IconButton.styleFrom(backgroundColor: AppTheme.primary,),
      onPressed: () {
        // Mostrar el diálogo con el cronómetro
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const CronometroDialog();
          },
        );
      },
      icon: const Icon(Icons.timer),
    );
  }
}

class CronometroDialog extends StatefulWidget {
  const CronometroDialog({super.key});

  @override
  _CronometroDialogState createState() => _CronometroDialogState();
}

class _CronometroDialogState extends State<CronometroDialog> {
  late Stopwatch _stopwatch;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(const Duration(milliseconds: 30), _updateTimer);
  }

  void _updateTimer(Timer timer) {
    if (_stopwatch.isRunning) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Cronómetro'),
      content: Column(
        children: [
          Text(
            _formatTime(_stopwatch.elapsed),
            style: const TextStyle(fontSize: 36),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_stopwatch.isRunning) {
                _stopwatch.stop();
              } else {
                _stopwatch.start();
              }
            },
            child: Text(_stopwatch.isRunning ? 'Pausar' : 'Reanudar'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _stopwatch.reset();
            },
            child: const Text('Reiniciar'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el diálogo
            },
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  String _formatTime(Duration duration) {
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}.${(duration.inMilliseconds % 1000).toString().padLeft(3, '0')}';
  }
}