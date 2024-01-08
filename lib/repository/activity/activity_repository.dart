import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tesproix/data/activity.dart';
import 'package:tesproix/model/detail_model.dart';
import 'package:tesproix/model/header_model.dart';
import 'package:tesproix/repository/activity/base_activity_repository.dart';

class ActivityRepository implements BaseActivityRepository {
  @override
  Future<Either<String, HeaderModel>> createHeader(
      String code, String name) async {
    DatabaseActivity database = DatabaseActivity.instance;
    Database? db = await database.database;

    try {
      final result = await db!.rawInsert(
          'INSERT INTO header (code, name) VALUES (?, ?)', [code, name]);
      return Right(HeaderModel(
          id: result,
          code: code,
          name: name,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now()));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, DetailModel>> createDetail(
      String code,
      DateTime date,
      String time,
      String before,
      String action,
      String after,
      String recommendAction,
      int headerId) async {
    DatabaseActivity database = DatabaseActivity.instance;
    Database? db = await database.database;
    try {
      final result = await db!.rawInsert(
          'INSERT INTO detail (code, date, time, before, action, after, recommend_action, header_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
          [
            code,
            date.toIso8601String(),
            time,
            before,
            action,
            after,
            recommendAction,
            headerId
          ]);
      return Right(DetailModel(
          id: result,
          code: code,
          date: date,
          time: time,
          before: before,
          action: action,
          after: after,
          recommendAction: recommendAction,
          headerId: headerId,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now()));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<HeaderModel>>> getHeader() async {
    DatabaseActivity database = DatabaseActivity.instance;
    Database? db = await database.database;

    try {
      final result = await db!.rawQuery('SELECT * FROM header');
      final header = result.map((e) => HeaderModel.fromJson(e)).toList();
      return Right(header);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, DetailModel>> getDetail(int headerId) async {
    DatabaseActivity database = DatabaseActivity.instance;
    Database? db = await database.database;
    try {
      final result = await db!
          .rawQuery('SELECT * FROM detail WHERE header_id = ?', [headerId]);
      DetailModel detail = DetailModel.fromJson(result.first);
      return Right(detail);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
