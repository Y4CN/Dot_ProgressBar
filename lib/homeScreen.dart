import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation doubleAnimation;
  late int endDataTime;
  late int sec;

  @override
  void initState() {
    super.initState();
    sec = 10;
    endDataTime = DateTime.now().millisecondsSinceEpoch + 1000 * sec;
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: sec - 1));
    doubleAnimation =
        Tween<double>(begin: 0, end: 100).animate(animationController);
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Center(
            child: AnimatedBuilder(
              animation: doubleAnimation,
              builder: (context, child) => CircularSeekBar(
                width: double.infinity,
                height: 250,
                progress: doubleAnimation.value,
                barWidth: 10,
                minProgress: 0,
                maxProgress: 100,
                animDurationMillis: 100,
                startAngle: 180,
                sweepAngle: 360,
                strokeCap: StrokeCap.butt,
                progressColor: Colors.red,
                dashWidth: 1,
                dashGap: 2,
                animation: true,
              ),
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) => SizedBox(
                width: 290,
                height: 290,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  semanticsValue: 'salam',
                  semanticsLabel: 'Hello',
                  value: doubleAnimation.value / 100,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          Positioned(
            child: Center(
              child: CountdownTimer(
                onEnd: () {
                  animationController.stop();
                },
                endWidget: const Text(
                  'The End',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                // endTime: DateTime.now().millisecondsSinceEpoch + 1000 * 10,
                controller: CountdownTimerController(
                  endTime: endDataTime,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
