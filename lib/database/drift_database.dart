import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import '../model/category_color.dart';
import '../model/schedule.dart';
import 'package:path/path.dart' as p;
// import --> private 값들은 불러올 수 없음
part 'drift_database.g.dart';
// part 키워드? import와 유사하지만 더 넓은 기능,
// private 값 까지 다 불러올 수 있음, 그니까 파트는 같은 파일 코드인데 다른데 넣어놓은거 불러오는 느낌
// .g는 파일 자동생성하게

@DriftDatabase(
  tables: [
    Schedules,
    CategoryColors,
  ]
)
// 이런 골뱅이로 시작하는 걸 decorator라고 함 , 생성한 데이터 베이스 내 테이블을 리스트 안에
class LocalDatabase extends _$LocalDatabase{
  LocalDatabase() : super(_openConnection());

  Future<int> createSchedule(SchedulesCompanion data) => into(schedules).insert(data);
  // insert는 insert한 값의 primary key를 리턴 -- 써도되고 안써도 상관없음

  Future<int> createCategoryColors(CategoryColorsCompanion data) => into(categoryColors).insert(data);

  Future<List<CategoryColor>> getCategoryColors() => select(categoryColors).get();

  Stream<List<Schedule>> watchSchedules()=>
      select(schedules).watch(); // 계속 지속적으로 업데이트 된 값 불러올 수 있음



  @override
  int get schemaVersion => 1;
  // 데이터베이스 버전이라고 생각하면 됨 - 구조 바뀔 때 마다 올려줘야
}

// 연결해주기
LazyDatabase _openConnection(){
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    // 이 앱 전용 폴더를 불러옴

    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);

  });
}