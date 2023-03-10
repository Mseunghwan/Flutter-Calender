import 'package:flutter/material.dart';

import '../const/colors.dart';

class ScheduleCard extends StatelessWidget {
  // 24h
  final int startTime;
  final int endTime;
  final String content;
  final Color color;

  const ScheduleCard({
    required this.startTime,
    required this.endTime,
    required this.content,
    required this.color,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: PRIMARY_COLOR,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IntrinsicHeight(
          // IntrinsicHeight -- 가장 높은 위젯이 차지하는 만큼만 제한 - stretch 해도 내용이 안사라지게
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Time(
                startTime: startTime,
                endTime: endTime,
              ),
              SizedBox(width: 16,),
              Expanded(
                child: _Content(
                  content: content,
                ),
              ),
            SizedBox(width: 16,),
            _Category(color: color),
            ],
          ),
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  final int startTime;
  final int endTime;

  const _Time({
    required this.startTime,
    required this.endTime,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: PRIMARY_COLOR,
      fontSize: 16,
    );


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${startTime.toString().padLeft(2, '0')}:00',
        style: textStyle,),
      Text(
        '${endTime.toString().padLeft(2, '0')}:00',
      style: textStyle.copyWith(
        fontSize: 10,
      ),),
      ],
    );
  }
}


class _Content extends StatelessWidget {
  final String content;

  const _Content({required this.content,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(content,);
  }
}

class _Category extends StatelessWidget {
  final Color color;
  const _Category({required this.color,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      width: 16,
      height: 16,
    );
  }
}
