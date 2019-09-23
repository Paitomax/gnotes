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
    return ListView.separated(
      itemCount: widget.items.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  widget.items[index].title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: Text(
                  widget.items[index].title,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                ),
              )
            ],
          ),
          onTap: () => Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Cliquei no item $index"))),
        );
      },
    );
  }
}
