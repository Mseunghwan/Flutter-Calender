import 'package:calender_schedular/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {

  // 플러터 준비될 때 까지 기다려줌 --> 기존까지 왜 안했냐? runApp 실행 시 자동으로 되는 부분이기에
  // 이게 있어야 다른 코드가 실행가능
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'NotoSans',
    ),
    home: HomeScreen(),
  ));
}