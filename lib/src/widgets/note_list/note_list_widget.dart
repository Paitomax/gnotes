import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gnotes/src/add_note/add_note_screen.dart';
import 'package:gnotes/src/widgets/note_list/note_list_bloc.dart';
import 'package:gnotes/src/widgets/note_list/note_list_event.dart';
import 'package:gnotes/src/widgets/note_list/note_list_state.dart';

import '../../models/note.dart';

class NoteListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteListWidget> {
  NoteListWidgetBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<NoteListWidgetBloc>(context);
    _bloc.add(NoteListWidgetFetchNotesEvent());

    super.initState();
  }

  goToAddNoteScreen(Note note) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddNoteScreen(note: note);
    }));
    BlocProvider.of<NoteListWidgetBloc>(context)
        .add(NoteListWidgetFetchNotesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cuts = (width / 300.0).floor();

    return BlocBuilder(
      bloc: _bloc,
      builder: (context, state) {
        if (state is NoteListWidgetLoadingState) {
          return _circularProgress();
        } else if (state is ErrorNoteListWidgetState) {
          return Container(
            alignment: Alignment.center,
            child: Text(state.error),
          );
        } else if (state is NoteListWidgetLoadedState) {
          return _buildGridView(state.notes, [], false, cuts);
        } else if (state is NoteListWidgetSelectionChangedState) {
          bool selectionMode = state.listNoteIdSelection.isEmpty == false;
          return _buildGridView(
            state.notes,
            state.listNoteIdSelection,
            selectionMode,
            cuts,
          );
        } else
          return Container();
      },
    );
  }

  _buildGridView(
    List<Note> notes,
    List<String> notesIdSelected,
    bool selectionMode,
    int cuts,
  ) {
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      crossAxisCount: cuts,
      itemCount: notes.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == notes.length) {
          return SizedBox(
            height: 80,
          );
        }
        Note item = notes[index];

        bool selected = notesIdSelected.contains(item.id);
        return itemWithTitle(item, selected, selectionMode);
      },
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      mainAxisSpacing: 2.0,
      crossAxisSpacing: 2.0,
    );
  }

  Widget itemWithTitle(Note item, bool selected, bool selectionMode) {
    return GestureDetector(
      child: Card(
        shape: selected
            ? RoundedRectangleBorder(
                side: BorderSide(width: 2),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              )
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
        elevation: 0.3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              _dateWidget(item),
              Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                  left: 8,
                  right: 8,
                  bottom: 8,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Visibility(
                      visible: item.title.isNotEmpty,
                      child: Text(
                        item.title,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: item.body.isNotEmpty,
                      child: Text(
                        item.body,
                        textAlign: TextAlign.left,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        if (selectionMode)
          _bloc.add(NoteListWidgetSelectionChangedEvent(item.id));
        else
          goToAddNoteScreen(item);
      },
      onLongPress: () {
        _bloc.add(NoteListWidgetSelectionChangedEvent(item.id));
      },
    );
  }

  String _dateString(DateTime dt1, DateTime dt2) {
    DateTime dt = dt2.isAfter(dt1) ? dt2 : dt1;
    return "${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year} - ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
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
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _circularProgress() {
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }
}
