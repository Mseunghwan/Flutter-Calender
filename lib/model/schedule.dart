import "package:drift/drift.dart";

 // Date Structure 만드는 부분
class Schedules extends Table {
  // PRIMARY KEY
  IntColumn get id => integer().autoIncrement()(); // integer() 을 하면 또 함수가 실행되기에 한 번 더 ()

  // 내용
  TextColumn get content => text()();

  // 일정 날짜
  DateTimeColumn get date => dateTime()();

  // 시작 시간
  IntColumn get startTime => integer()();

  // 끝 시간
  IntColumn get endTime => integer()();

  // Category Color Table ID
  IntColumn get colorId => integer()();

  // 생성날짜
  DateTimeColumn get createdAt => dateTime().clientDefault(
          () => DateTime.now(),
  )(); // 값을 안넣어 주면 현 시간 자동으로 default 로

}