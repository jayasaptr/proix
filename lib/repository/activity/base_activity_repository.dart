import 'package:dartz/dartz.dart';
import 'package:tesproix/model/detail_model.dart';
import 'package:tesproix/model/header_model.dart';

abstract class BaseActivityRepository {
  Future<Either<String, HeaderModel>> createHeader(String code, String name);
  Future<Either<String, DetailModel>> createDetail(
      String code,
      DateTime date,
      String time,
      String before,
      String action,
      String after,
      String recommendAction,
      int headerId);

  Future<Either<String, List<HeaderModel>>> getHeader();
  Future<Either<String, DetailModel>> getDetail(int headerId);

}
