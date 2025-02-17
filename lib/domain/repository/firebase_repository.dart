import 'package:chat_app/domain/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class FirebaseRepository {
  Future<UserCredential> createUser(
    String email,
    String password, {
    VoidCallback? onLoading,
    VoidCallback? onSuccess,
    VoidCallback? onFailure,
  });

  Future<UserCredential> loginWithEmailAndPassword(
    String email,
    String password, {
    VoidCallback? onLoading,
    VoidCallback? onSuccess,
    VoidCallback? onFailure,
  });

  CollectionReference<Map<String, dynamic>> createMessagesCollection();

  Future<void> onSendMessage(
    MessageModel messageModel, {
    VoidCallback? onLoading,
    VoidCallback? onSuccess,
    VoidCallback? onFailure,
  });

  Future<Stream<QuerySnapshot>> getMessagesStream();
}
