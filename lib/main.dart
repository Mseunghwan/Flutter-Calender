import 'package:calender_schedular/database/drift_database.dart';
import 'package:calender_schedular/screen/home_screen.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

const DEFAULT_COLORS = [
  // 빨강
  'F44336',
  // 주황
  'FF9800',
  // 노랑
  'FFEB3B',
  // 초록
  'FCAF50',
  // 파랑
  '2196F3',
  // 남
  '3F51B5',
  // 보라
  '9C27B0'
];

void main() async {

  // 플러터 준비될 때 까지 기다려줌 --> 기존까지 왜 안했냐? runApp 실행 시 자동으로 되는 부분이기에
  // 이게 있어야 다른 코드가 실행가능
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  final database = LocalDatabase();

  // getit 클래스를 활용해 어느 파일에서든 파라미터로 넘겨주지 않아도 쉽게 사용할 수 있게 해줌!!!
  GetIt.I.registerSingleton<LocalDatabase>(database);

  final colors = await database.getCategoryColors();

  if(colors.isEmpty){
    for(String hexCode in DEFAULT_COLORS){
      await database.createCategoryColors(
        CategoryColorsCompanion(
          hexCode: Value(hexCode),
        ),
      );
    }
  }

  print('-------------------');
  print(await database.getCategoryColors());

  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'NotoSans',
    ),
    home: HomeScreen(),
  ));
}