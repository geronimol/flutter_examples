import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTickerCard extends StatefulWidget {
  const CountdownTickerCard({Key? key, required this.date}) : super(key: key);

  final DateTime date;

  @override
  State<CountdownTickerCard> createState() => _CountdownTickerCardState();
}

class _CountdownTickerCardState extends State<CountdownTickerCard> {
  late Timer timer;
  late Duration clockTimer;
  late DateTime now;
  int days = 0, hours = 0, minutes = 0, seconds = 0;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    clockTimer = widget.date.difference(now);

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        now = DateTime.now();
        clockTimer = widget.date.difference(now);
        if(!clockTimer.isNegative) {
          days = clockTimer.inDays;
          hours = clockTimer.inHours.remainder(24);
          minutes = clockTimer.inMinutes.remainder(60);
          seconds = clockTimer.inSeconds.remainder(60);
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 130,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildIndicator(displayText: days.toString().padLeft(2,'0'), displayIndicator: 'DAY'),
              const SizedBox(width: 5,),
              _buildIndicator(displayText: hours.toString().padLeft(2,'0'), displayIndicator: 'HR'),
              const SizedBox(width: 5,),
              _buildIndicator(displayText: minutes.toString().padLeft(2,'0'), displayIndicator: 'MIN'),
              const SizedBox(width: 5,),
              _buildIndicator(displayText: seconds.toString().padLeft(2,'0'), displayIndicator: 'SEC'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator({required String displayText, required String displayIndicator}) {
    return Column(
      children: [
        Text(displayText, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        Text(displayIndicator, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold),),
      ],
    );
  }
}