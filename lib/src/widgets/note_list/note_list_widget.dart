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
  List<String> selectionIndex = [];
  bool selectionMode = false;

  selectCard(Note note) {
    if (selectionIndex.contains(note.id))
      selectionIndex.remove(note.id);
    else
      selectionIndex.add(note.id);

    selectionMode = selectionIndex.length > 0;
    setState(() {});
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
      itemCount: widget.items.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == widget.items.length) {
          return SizedBox(
            height: 80,
          );
        }

        Note item = widget.items[index];
        return itemWithTitle(item);
      },
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      mainAxisSpacing: 2.0,
      crossAxisSpacing: 2.0,
    );
  }

  isSelected(Note note) {
    if (!selectionMode)
      return false;
    else
      return selectionIndex.contains(note.id);
  }

  Widget itemWithTitle(Note item) {
    return GestureDetector(
      child: Card(
        shape: isSelected(item)
            ? RoundedRectangleBorder(
                side: BorderSide(width: 2),
                borderRadius: BorderRadius.all(Radius.circular(8)))
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
        elevation: 0.3,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _dateWidget(item),
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
      onTap: () {
        if (selectionMode)
          selectCard(item);
        else
          goToAddNoteScreen(item);
      },
      onLongPress: () {
        selectCard(item);
      },
    );
  }

  String _dateString(DateTime dt1, DateTime dt2) {
    DateTime dt = dt2.isAfter(dt1) ? dt2 : dt1;
    return "${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}";
  }

  Widget _dateWidget(Note item) {
    return Container(
      alignment: Alignment.topRight,
      child: Text(
        _dateString(item.createTime, item.lastTimeUpdated),
        textAlign: TextAlign.right,
        style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w400,
            letterSpacing: 1,
            color: Colors.blue),
      ),
    );
  }
}
