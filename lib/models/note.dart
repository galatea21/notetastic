import 'package:cloud_firestore/cloud_firestore.dart';
class Note {
  String id;
  String title;
  String content;
	String hexColor;
	List<String> timestamp = [];

  Note({
    this.title = "Untitled",
    this.content,
  }) {
		hexColor = "0xFFFFFFFF";
		timestamp.add(DateTime.now().toString());
	}

	Note.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
		id = documentSnapshot.id;
		title = documentSnapshot.get("title") as String;
		content = documentSnapshot.get("content") as String;
		hexColor = documentSnapshot.get("hexColor") as String;
		timestamp = documentSnapshot.get("timestamp") as List<String>;
	}
}
