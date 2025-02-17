import 'package:chat_app/data/network/firebase_repository_impl.dart';
import 'package:chat_app/domain/model/message_model.dart';
import 'package:chat_app/domain/repository/firebase_repository.dart';
import 'package:chat_app/domain/usecase/get_messages_use_case.dart';
import 'package:chat_app/domain/usecase/send_message_use_case.dart';
import 'package:chat_app/presentation/home/home_cubit/home_screen_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeScreenState> {
  HomeCubit() : super(HomeInitState()) {
    sendMessageUseCase = SendMessageUseCase(firebaseRepository);
    getMessagesUseCase = GetMessagesUseCase(firebaseRepository);
    getAllMessages();
  }
  static HomeCubit get(BuildContext context) => BlocProvider.of(context);
  bool isButtonLoading = false;
  bool isShowPassword = false;
  VoidCallback? onNavigateToHomeScreen;
  String message = '';
  String email = '';
  Stream<QuerySnapshot<Object?>>? messagesStream;
  FirebaseRepository firebaseRepository = FirebaseRepositoryImpl();
  late SendMessageUseCase sendMessageUseCase;
  late GetMessagesUseCase getMessagesUseCase;

  List<MessageModel> messages = [];

  void onMessageSent(String message) {
    this.message = message;
    emit(HomeMessageValueState());
  }

  void setEmail(String email) {
    this.email = email;
  }

  void onSendMessageClicked() {
    MessageModel messageModel = MessageModel(
      message: message,
      id: email,
      currentTime: DateTime.now(),
    );
    sendMessageUseCase.invoke(
      messageModel,
      onLoading: () {},
      onFailure: () {},
      onSuccess: () {},
    );
    onMessageSent('');
    emit(HomeSendButtonState());
  }

  void getAllMessages() {
    print('zipy');
    emit(HomeIsLoadingMessages());
    getMessagesUseCase.invoke().then(
      (value) {
        messagesStream = value;
        emit(HomeGetMessagesSuccess());
      },
    ).catchError((error) {
      print(error.toString());
      emit(HomeGetMessagesFailed());
    });
  }
}
