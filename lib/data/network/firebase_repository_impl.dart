import 'package:chat_app/domain/model/message_model.dart';
import 'package:chat_app/domain/repository/firebase_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  @override
  Future<UserCredential> createUser(
    String email,
    String password, {
    VoidCallback? onLoading,
    VoidCallback? onSuccess,
    VoidCallback? onFailure,
  }) async {
    try {
      onLoading!();
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        onSuccess!();
        return value;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        onFailure!();
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        onFailure!();
      }
    } catch (e) {
      print(e);
      onFailure!();
    }
    throw Exception('Failed to create user');
  }

  @override
  Future<UserCredential> loginWithEmailAndPassword(
    String email,
    String password, {
    VoidCallback? onLoading,
    VoidCallback? onSuccess,
    VoidCallback? onFailure,
  }) async {
    try {
      onLoading!();
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        onSuccess!();
        return value;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        onFailure!();
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        onFailure!();
      }
    } catch (e) {
      print(e);
      onFailure!();
    }
    throw Exception('Failed to create user');
  }

  @override
  CollectionReference<Map<String, dynamic>> createMessagesCollection() {
    return FirebaseFirestore.instance.collection('messages');
  }

  @override
  Future<void> onSendMessage(
    MessageModel messageModel, {
    VoidCallback? onLoading,
    VoidCallback? onSuccess,
    VoidCallback? onFailure,
  }) {
    onLoading!();
    return createMessagesCollection().add({
      'message': messageModel.message,
      'id': messageModel.id,
      'currentTime': messageModel.currentTime,
    }).then((value) {
      onSuccess!();
      print(value);
    }).catchError((e) {
      onFailure!();
      print(e.toString());
    });
  }

  @override
  Future<Stream<QuerySnapshot>> getMessagesStream() async {
    return FirebaseFirestore.instance
        .collection('messages')
        .orderBy('currentTime')
        .snapshots();
  }
}
