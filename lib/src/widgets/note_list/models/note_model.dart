class NoteModel {
  int id;
  String title;
  String body;
  DateTime dateTime;

  NoteModel(this.title, this.body, {this.id, this.dateTime});
}
