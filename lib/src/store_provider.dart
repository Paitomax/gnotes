import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gnotes/src/models/note.dart';
import 'package:gnotes/src/models/user.dart';

class StoreProvider {
  static addUser(User user) async {
    var firestore = FirebaseFirestore.instance;
    firestore.collection("users").doc(user.id).get().then((doc) {
      if (!doc.exists) {
        firestore.collection("users").doc(user.id).update(user.toJson());
      }
    });
  }

  static Future<User> getUser(String id) async {
    var firestore = FirebaseFirestore.instance;
    firestore.collection("users").doc(id).get().then((doc) {
      if (!doc.exists) {
        return User.fromJson(doc.data());
      } else
        return null;
    });
    return null;
  }

  static Future<List<Note>> getUserNotes(String uid) async {
    var result = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('notes')
        .snapshots()
        .first;
    List<Note> notes = List<Note>();
    result.docs.forEach((doc) {
      Note note = Note.fromJson(doc.data());
      note.id = doc.id;
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

  static Future<bool> addUserNote(String uid, Note note) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection('notes')
          .add(note.toJson());
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> updateUserNote(String uid, Note note) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection('notes')
          .doc(note.id)
          .update(note.toJson());
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> deleteUserNote(String uid, String noteId) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection('notes')
          .doc(noteId)
          .delete();
      return true;
    } catch (error) {
      return false;
    }
  }
}
