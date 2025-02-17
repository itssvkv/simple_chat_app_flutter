import 'package:chat_app/data/network/firebase_repository_impl.dart';
import 'package:chat_app/domain/repository/firebase_repository.dart';
import 'package:chat_app/domain/usecase/signup_use_case.dart';
import 'package:chat_app/presentation/signup/signup_cubit/signup_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupScreenState> {
  SignupCubit() : super(SignupInitState()) {
    signupUseCase = SignupUseCase(firebaseRepository);
  }

  static SignupCubit get(BuildContext context) => BlocProvider.of(context);
  bool isButtonLoading = false;
  bool isShowPassword = false;

  String email = '';
  String password = '';
  String rePassword = '';

  late SignupUseCase signupUseCase;
  FirebaseRepository firebaseRepository = FirebaseRepositoryImpl();
  void onButtonPressed() {
    isButtonLoading = !isButtonLoading;
    emit(SignupButtonState());
  }

  void onShowPasswordClick() {
    isShowPassword = !isShowPassword;
    emit(SignupPasswordTextFieldState());
  }

  void onEmailChanged(String email) {
    this.email = email;
    emit(SignupEmailValueState());
    print(this.email);
  }

  void onPasswordChanged(String password) {
    this.password = password;
    emit(SignupPasswordValueState());
    print(this.password);
  }

  void onRePasswordChanged(String password) {
    rePassword = password;
    emit(SignupRePasswordValueState());
    print(rePassword);
  }

  void createUser() {
    signupUseCase
        .invoke(
            email: email,
            password: password,
            onLoading: () {
              isButtonLoading = true;
              emit(SignupButtonState());
            },
            onSuccess: () {
              isButtonLoading = false;
              emit(SignupCreateUserSuccess());
            },
            onFailure: () {
              isButtonLoading = false;
              emit(SignupCreateUserFailed());
            })
        .then(
      (value) {
        print(value);
      },
    );
  }
}
