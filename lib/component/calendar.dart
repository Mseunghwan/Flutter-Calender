import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../const/colors.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime? selectedDay;
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final defaultBoxDeco = BoxDecoration(
    borderRadius: BorderRadius.circular(6),
    color: Colors.grey[200],
    );

    final defaultTextStyle = TextStyle(
      color: Colors.grey[600],
      fontWeight: FontWeight.w700,
    );

    return TableCalendar(
      locale: 'ko_KR',
        focusedDay: focusedDay,
        firstDay: DateTime(1800),
        lastDay: DateTime(3000),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
        )
      ),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        defaultDecoration: defaultBoxDeco,
        weekendDecoration: defaultBoxDeco,
        selectedDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: PRIMARY_COLOR,
            width: 1,
          ),
        ),
        outsideDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
        ),
        defaultTextStyle: defaultTextStyle,
        weekendTextStyle: defaultTextStyle,
        selectedTextStyle: defaultTextStyle.copyWith(
          color: PRIMARY_COLOR,
        ),
      ),
      onDaySelected: (DateTime selectedDay, DateTime focusedDay){
          print(selectedDay);

        setState(() {
          this.selectedDay = selectedDay;
          this.focusedDay = selectedDay;
        });
      },

      selectedDayPredicate: (DateTime date){
        if(selectedDay == null){
          return false;
        }

        return date.year == selectedDay!.year &&
        date.month == selectedDay!.month &&
        date.day == selectedDay!.day; // 그냥 date == selectedDay하면 시, 분, 초도 같아야하기에

      },

    );
  }
}
