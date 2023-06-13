part of 'manage_cubit.dart';

@immutable
abstract class ManageState {}

class ManageInitial extends ManageState {}

class LoginSucces extends ManageState {}

class ChangeSuccess extends ManageState {
  bool? result;
  ChangeSuccess(this.result);
}

class ChangeLoading extends ManageState {}

class ChangeFailed extends ManageState {
  final String message;
  ChangeFailed(this.message);
}

class UpdateFailed extends ManageState {
  final String message;
  UpdateFailed(this.message);
}

class UpdateSuccess extends ManageState {
  final bool? result;
  UpdateSuccess(this.result);
}

class UpdateLoading extends ManageState {}

class LoginLoading extends ManageState {}

class LogoutLoading extends ManageState {}

class LogoutSuccess extends ManageState {
  bool? status;
  LogoutSuccess(this.status);
}

class LogoutFailed extends ManageState {
  String message;
  LogoutFailed(this.message);
}

class LoginFailed extends ManageState {
  final String message;
  LoginFailed(this.message);
}

class ProfileLoading extends ManageState {}

class ProfileFailed extends ManageState {
  final String message;
  ProfileFailed(this.message);
}

class ProfileSucccess extends ManageState {
  final ProfileModel? profileModel;
  ProfileSucccess(this.profileModel);
}
