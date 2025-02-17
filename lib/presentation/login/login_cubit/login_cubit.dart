import 'package:chat_app/data/network/firebase_repository_impl.dart';
import 'package:chat_app/domain/repository/firebase_repository.dart';
import 'package:chat_app/domain/usecase/login_use_case.dart';
import 'package:chat_app/presentation/login/login_cubit/login_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginScreenState> {
  LoginCubit() : super(LoginInitState()) {
    loginUseCase = LoginUseCase(firebaseRepository);
  }
  static LoginCubit get(BuildContext context) => BlocProvider.of(context);
  bool isButtonLoading = false;
  bool isShowPassword = false;
  VoidCallback? onNavigateToHomeScreen;
  String email = '';
  String password = '';

  late LoginUseCase loginUseCase;
  FirebaseRepository firebaseRepository = FirebaseRepositoryImpl();

  void onButtonPressed() {
    isButtonLoading = !isButtonLoading;
    emit(LoginButtonState());
  }

  void onShowPasswordClick() {
    isShowPassword = !isShowPassword;
    emit(LoginPasswordTextFieldState());
  }

  void onEmailChanged(String email) {
    this.email = email;
    emit(LoginEmailValueState());
    print(this.email);
  }

  void onPasswordChanged(String password) {
    this.password = password;
    emit(LoginPasswordValueState());
    print(this.password);
  }

  void loginWithEmailAndPassword() {
    loginUseCase
        .invoke(
            email: email,
            password: password,
            onLoading: () {
              isButtonLoading = true;
              emit(LoginButtonState());
            },
            onSuccess: () {
              isButtonLoading = false;
              onNavigateToHomeScreen!();
              emit(LoginCreateUserSuccess());
            },
            onFailure: () {
              isButtonLoading = false;
              emit(LoginCreateUserFailed());
            })
        .then(
      (value) {
        print(value);
      },
    );
  }
}
