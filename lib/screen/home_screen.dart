import 'package:calender_schedular/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:table_calendar/table_calendar.dart';

import '../component/calendar.dart';
import '../component/schedule_bottom_sheet.dart';
import '../component/schedule_card.dart';
import '../component/today_banner.dart';
import '../database/drift_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime(
    DateTime
        .now()
        .year,
    DateTime
        .now()
        .month,
    DateTime
        .now()
        .day,
  );
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: renderFloatingActionButton(),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              selectedDay: selectedDay,
              focusedDay: focusedDay,
              onDaySelected: onDaySelected,),
            SizedBox(height: 8),
            TodayBanner(
              selectedDay: selectedDay,
              scheduleCount: 3,
            ),
            SizedBox(height: 8),
            _ScheduleList(),
          ],
        ),
      ),
    );
  }

  FloatingActionButton renderFloatingActionButton() {
    return FloatingActionButton(onPressed: () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true, // 디폴트 최대 크기가 화면 반이기에 늘려주는
        builder: (_){
          return ScheduleBottomSheet(selectedDate: selectedDay,);
        },
      );
    },
      backgroundColor: PRIMARY_COLOR,
      child: Icon(
        Icons.add,
      ),);
  }


  onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    print(selectedDay);

    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }
}

class _ScheduleList extends StatelessWidget {
  const _ScheduleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: StreamBuilder<List<Schedule>>(
          stream: GetIt.I<LocalDatabase>().watchSchedules(),
          builder: (context, snapshot) {
            print(snapshot.data);
            return ListView.separated(
                itemCount: 3,
                separatorBuilder: (context, index) {
                  // 각 아이템 사이에 들어가는 빌더
                  return SizedBox(height: 8,);
                },
                itemBuilder: (context, index) {
                  return ScheduleCard(
                    startTime: 3,
                    endTime: 10,
                    content: '프로그래밍 공부하기',
                    color: Colors.red,
                  );
                });
          }
        ),
      ),
    );
  }
}
