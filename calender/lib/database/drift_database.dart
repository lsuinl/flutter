import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import '../model/category_color.dart';
import '../model/why.dart';
import 'package:path/path.dart' as p;

part 'drift_database.g.dart';

@DriftDatabase(
  tables:[
    Schedules,
    CategoryColors,
  ],
)
//아어렵다
class LocalDatabase extends _$LocalDatabase{
  LocalDatabase() : super(_openConnection());
  //생성쿼리(스케쥴데이터에
  Future<int> createSchedule(SchedulesCompanion data)=>
      into(schedules).insert(data); //into는 id int값을 반환한다. 써먹어도 되고 안해도되고

  Future<int> createCategoryColor(CategoryColorsCompanion data) =>
      into(categoryColors).insert(data);
  //값 불러오는 쿼리
  Future<List<CategoryColor>> getCategoryColors()=>
      select(categoryColors).get();

  @override
  //테이블의상태가 변경될 때마다 버전 up
  int get schemaVersion =>1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path,'db.sqlite'));
    return NativeDatabase(file);
  });
}
