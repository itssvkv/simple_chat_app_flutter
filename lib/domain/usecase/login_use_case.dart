import 'package:chat_app/domain/repository/firebase_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginUseCase {
  LoginUseCase(this.firebaseRepository);
  final FirebaseRepository firebaseRepository;
  Future<UserCredential> invoke(
          {required String email,
          required String password,
          VoidCallback? onLoading,
          VoidCallback? onSuccess,
          VoidCallback? onFailure}) =>
      firebaseRepository.loginWithEmailAndPassword(
        email,
        password,
        onLoading: onLoading,
        onSuccess: onSuccess,
        onFailure: onFailure,
      );
}
