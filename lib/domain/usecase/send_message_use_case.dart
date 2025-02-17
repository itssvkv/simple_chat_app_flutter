import 'package:chat_app/domain/model/message_model.dart';
import 'package:chat_app/domain/repository/firebase_repository.dart';
import 'package:flutter/material.dart';

class SendMessageUseCase {
  SendMessageUseCase(this.firebaseRepository);
  final FirebaseRepository firebaseRepository;

  Future<void> invoke(
    MessageModel messageModel, {
    VoidCallback? onLoading,
    VoidCallback? onSuccess,
    VoidCallback? onFailure,
  }) =>
      firebaseRepository.onSendMessage(
        messageModel,
        onLoading: onLoading,
        onFailure: onFailure,
        onSuccess: onSuccess,
      );
}
