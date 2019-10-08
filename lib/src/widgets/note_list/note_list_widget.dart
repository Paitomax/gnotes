import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gnotes/src/add_note/add_note_screen.dart';

import '../../models/note.dart';

class NoteListWidget extends StatefulWidget {
  final List<Note> items;

  NoteListWidget(this.items);

  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteListWidget> {
  getNoteCardItem(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.fromLTRB(4, 8, 4, 0),
        elevation: 1,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
              child: Text(
                widget.items[index].title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
              child: Text(
                widget.items[index].body,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              ),
            )
          ],
        ),
      ),
      onTap: () => goToAddNoteScreen(widget.items[index]),
    );
  }

  goToAddNoteScreen(Note note) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddNoteScreen(note: note);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      crossAxisCount: 2,
      itemCount: widget.items.length,
      itemBuilder: (BuildContext context, int index) {
        Note item = widget.items[index];
        bool hasTitle = item.title != null;

        if (hasTitle)
          return itemWithTitle(item);
        else
          return itemWithoutTitle(item);
      },
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      mainAxisSpacing: 2.0,
      crossAxisSpacing: 2.0,
    );
  }

  Widget itemWithTitle(Note item) {
    return GestureDetector(
      child: Card(
        elevation: 0.3,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                item.title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                item.body,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
      onTap: () => goToAddNoteScreen(item),
    );
  }

  Widget itemWithoutTitle(Note item) {
    return GestureDetector(
        child: Card(
      elevation: 0.3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          children: <Widget>[
            Text(
              item.body,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    ),
      onTap: () => goToAddNoteScreen(item),
    );
  }
}
