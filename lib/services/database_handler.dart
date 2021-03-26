import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/note.dart';

class DatabaseHandler {
  final FirebaseFirestore firestore;

  DatabaseHandler({this.firestore});

  Stream<List<Note>> getNoteStream({String uid}) {
    try {
      return firestore
          .collection("testDb")
          .doc(uid)
          .collection("notes")
          .snapshots()
          .map((query) {
        List<Note> returnVal;
        for (final QueryDocumentSnapshot doc in query.docs) {
          returnVal.add(Note.fromDocumentSnapshot(documentSnapshot: doc));
        }
        return returnVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addNote({String uid, Note note}) async {
    try {
      firestore.collection("testDb").doc(uid).collection("notes").add({
        "title": note.title,
        "content": note.content,
        "hexColor": note.hexColor,
        "timestamp": note.timestamp,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateNote({String uid, Note note, String noteId}) async {
    try {
      firestore
          .collection("testDb")
          .doc(uid)
          .collection("notes")
          .doc(noteId)
          .update({
        "title": note.title,
        "content": note.content,
        "hexColor": note.hexColor,
        "timestamp": note.timestamp,
      });
    } catch (e) {
      rethrow;
    }
  }
}
