import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siskom_tv_dosen/models/profile_model.dart';
import 'package:siskom_tv_dosen/services/auth_service.dart';
part 'manage_state.dart';

class ManageCubit extends Cubit<ManageState> {
  ManageCubit() : super(ManageInitial());

  void login(String email, String password) async {
    try {
      emit(LoginLoading());
      await AuthService().loginProfile(email: email, password: password);
      emit(LoginSucces());
    } catch (e) {
      emit(LoginFailed(
          'Terjadi kesalahan silahkan periksa email dan password yang anda masukkan'));
    }
  }

  void logout() async {
    try {
      emit(LogoutLoading());
      bool? result = await AuthService().logout();
      emit(LogoutSuccess(result));
    } catch (e) {
      emit(LogoutFailed('Terjadi kesalahan periksa koneksi internet anda'));
    }
  }

  void getProfile() async {
    try {
      emit(ProfileLoading());
      ProfileModel? profileModel = await AuthService().getProfile();
      emit(ProfileSucccess(profileModel));
    } catch (e) {
      emit(ProfileFailed('Terjadi kesalahan periksa koneksi internet anda'));
      // rethrow;
    }
  }

  void changeName(String name) async {
    try {
      emit(UpdateLoading());
      bool? result = await AuthService().changeName(name);
      emit(UpdateSuccess(result));
    } catch (e) {
      emit(
        UpdateFailed(
            'Terjadi Kesalahan silahkan periksa koneksi internet anda'),
      );
    }
  }

  void changeStatus(String status) async {
    try {
      emit(ChangeLoading());
      bool? result = await AuthService().changeStatus(status);
      emit(ChangeSuccess(result));
    } catch (e) {
      emit(
        ChangeFailed(
            'Terjadi Kesalahan silahkan periksa koneksi internet anda'),
      );
    }
  }
}
