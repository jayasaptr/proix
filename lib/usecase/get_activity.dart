import 'package:dartz/dartz.dart';
import 'package:tesproix/model/detail_model.dart';
import 'package:tesproix/model/header_model.dart';
import 'package:tesproix/repository/activity/base_activity_repository.dart';

class GetActivity {
  final BaseActivityRepository repository;

  GetActivity({required this.repository});

  Future<Either<String, List<HeaderModel>>> getHeader() async {
    return await repository.getHeader();
  }

  Future<Either<String, DetailModel>> getDetail(int headerId) async {
    return await repository.getDetail(headerId);
  }

  Future<Either<String, HeaderModel>> createHeader(
      String code, String name) async {
    return await repository.createHeader(code, name);
  }

  Future<Either<String, DetailModel>> createDetail(
      String code,
      DateTime date,
      String time,
      String before,
      String action,
      String after,
      String recommendAction,
      int headerId) async {
    return await repository.createDetail(code, date, time, before, action,
        after, recommendAction, headerId);
  }
}
