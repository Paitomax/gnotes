import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/note_model.dart';

class NoteListWidget extends StatefulWidget {
  List<NoteModel> items;

  NoteListWidget(this.items);

  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (BuildContext context, int index) {
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
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                )
              ],
            ),
          ),
          onTap: () => Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Cliquei no item $index"))),
        );
      },
    );
  }
}
