import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gnotes/src/models/note.dart';
import 'package:gnotes/src/models/user.dart';

class StoreProvider {
  static addUser(User user) async {
    var firestore = Firestore.instance;
    firestore.collection("users").document(user.id).get().then((doc) {
      if (!doc.exists) {
        firestore.collection("users").document(user.id).setData(user.toJson());
      }
    });
  }

  static Future<User> getUser(String id) async {
    var firestore = Firestore.instance;
    firestore.collection("users").document(id).get().then((doc) {
      if (!doc.exists) {
        return User.fromJson(doc.data);
      } else
        return null;
    });
    return null;
  }

  static Future<List<Note>> getUserNotes(String uid) async {
    var result = await Firestore.instance
        .collection("users")
        .document(uid)
        .collection('notes')
        .getDocuments();
    List<Note> notes = List<Note>();
    result.documents.forEach((doc) {
      Note note = Note.fromJson(doc.data);
      note.id = doc.documentID;
      notes.add(note);
    });
    notes.sort((a, b) {
      if (a.lastTimeUpdated.isAfter(b.lastTimeUpdated))
        return 0;
      else
        return 1;
    });

    return notes;
  }

  static Future<bool> addUpdateUserNote(String uid, Note note) async {
    try {
      await Firestore.instance
          .collection("users")
          .document(uid)
          .collection('notes')
          .document(note.id)
          .setData(note.toJson(), merge: true);
      return true;
    } catch (error) {
      return false;
    }
  }
}
