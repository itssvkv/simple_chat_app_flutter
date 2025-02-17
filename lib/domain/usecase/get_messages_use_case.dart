import 'package:chat_app/domain/repository/firebase_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetMessagesUseCase {
  GetMessagesUseCase(this.firebaseRepository);
  FirebaseRepository firebaseRepository;

  Future<Stream<QuerySnapshot>> invoke() {
    return firebaseRepository.getMessagesStream();
  }
}
