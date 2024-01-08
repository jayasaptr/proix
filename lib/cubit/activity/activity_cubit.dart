import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tesproix/model/detail_model.dart';
import 'package:tesproix/model/header_model.dart';
import 'package:tesproix/usecase/get_activity.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final GetActivity getActivity;

  static final TextEditingController codeController = TextEditingController();
  static final TextEditingController nameController = TextEditingController();

  //detail
  static final TextEditingController codeDetailController =
      TextEditingController();
  static DateTime? dateDetailController;
  static final TextEditingController timeDetailController =
      TextEditingController();
  static String? beforeDetailController;
  static final TextEditingController actionDetailController =
      TextEditingController();
  static String? afterDetailController;
  static final TextEditingController recommendActionDetailController =
      TextEditingController();

  ActivityCubit(this.getActivity) : super(ActivityInitial());

  void createHeader(String code, String name) async {
    emit(ActivityLoading());
    final result = await getActivity.createHeader(code, name);
    result.fold((l) {
      emit(HeaderError(l));
    }, (r) {
      emit(HeaderCreated(r));
    });
  }

  void createDetail(
      {String? code,
      DateTime? date,
      String? time,
      String? before,
      String? action,
      String? after,
      String? recommendAction,
      int? headerId}) async {
    emit(ActivityLoading());
    final result = await getActivity.createDetail(code!, date!, time!, before!,
        action!, after!, recommendAction!, headerId!);
    result.fold((l) {
      emit(DetailError(l));
    }, (r) {
      emit(DetailCreated(r));
    });
  }

  void getHeader() async {
    emit(ActivityLoading());
    final result = await getActivity.getHeader();
    result.fold((l) {
      emit(HeaderError(l));
    }, (r) {
      emit(GetHeader(r));
    });
  }

  void getDetail(int headerId) async {
    emit(ActivityLoading());
    final result = await getActivity.getDetail(headerId);
    result.fold((l) {
      emit(DetailError(l));
    }, (r) {
      emit(GetDetail(r));
    });
  }

  void activityStepPage(int step) {
    emit(LoadingPage());
    emit(ActivityStepPage(step));
  }
}
