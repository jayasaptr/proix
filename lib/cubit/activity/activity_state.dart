part of 'activity_cubit.dart';

sealed class ActivityState {}

final class ActivityInitial extends ActivityState {}

final class ActivityLoading extends ActivityState {}

final class HeaderCreated extends ActivityState {
  final HeaderModel header;

  HeaderCreated(this.header);
}

final class HeaderError extends ActivityState {
  final String message;

  HeaderError(this.message);
}

final class DetailCreated extends ActivityState {
  final DetailModel detail;

  DetailCreated(this.detail);
}

final class DetailError extends ActivityState {
  final String message;

  DetailError(this.message);
}

final class GetHeader extends ActivityState {
  final List<HeaderModel> header;

  GetHeader(this.header);
}

final class GetDetail extends ActivityState {
  final DetailModel detail;

  GetDetail(this.detail);
}

final class ActivityStepPage extends ActivityState {
  final int step;

  ActivityStepPage(this.step);
}

final class LoadingPage extends ActivityState {
  LoadingPage();
}


final class CreateDetail extends ActivityState {
  final DetailModel detail;

  CreateDetail(this.detail);
}
