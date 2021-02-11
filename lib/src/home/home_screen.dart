import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnotes/src/add_note/add_note_screen.dart';
import 'package:gnotes/src/auth/bloc.dart';
import 'package:gnotes/src/home/home_bloc.dart';
import 'package:gnotes/src/strings.dart';
import 'package:gnotes/src/widgets/note_list/note_list_bloc.dart';
import 'package:gnotes/src/widgets/note_list/note_list_event.dart';
import 'package:gnotes/src/widgets/note_list/note_list_state.dart';
import 'package:gnotes/src/widgets/note_list/note_list_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const deleteValue = 'deletar';
  static const exitValue = 'sair';

  @override
  void initState() {
    super.initState();
  }

  List<PopupMenuEntry<String>> getMenuItems(bool selectionMode) {
    if (selectionMode) {
      return [
        PopupMenuItem<String>(
          value: deleteValue,
          child: Text(Strings.delete),
        ),
      ];
    } else {
      return [
        PopupMenuItem<String>(
          value: exitValue,
          child: Text(Strings.exit),
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<NoteListWidgetBloc>(context),
        builder: (context, state) {
          bool selectionMode = false;
          if (state is NoteListWidgetSelectionChangedState) {
            selectionMode = state.selectionCount > 0;
          }

          return WillPopScope(
            onWillPop: () async {
              if (selectionMode) {
                BlocProvider.of<NoteListWidgetBloc>(context)
                    .add(NoteListWidgetClearSelectionEvent());
                return false;
              }
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(Strings.appName),
                actions: <Widget>[
                  PopupMenuButton<String>(
                    onSelected: _onMenuSelected,
                    itemBuilder: (BuildContext context) {
                      return getMenuItems(selectionMode);
                    },
                  ),
                ],
              ),
              body: BlocBuilder(
                bloc: BlocProvider.of<HomeBloc>(context),
                builder: (context, state) {
                  return NoteListWidget();
                },
              ),
              floatingActionButton: FloatingActionButton(
                tooltip: Strings.addNew,
                child: Icon(Icons.add),
                onPressed: _goToAddNoteScreen,
              ),
            ),
          );
        });
  }

  void _onMenuSelected(String value) {
    if (value == exitValue) {
      BlocProvider.of<AuthBloc>(context).add(AuthLoggedOut());
    } else if (value == deleteValue) {
      BlocProvider.of<NoteListWidgetBloc>(context)
          .add(DeleteSelectedNotesEvent());
    }
  }

  void _goToAddNoteScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return AddNoteScreen();
      }),
    );
    BlocProvider.of<NoteListWidgetBloc>(context).add(
      NoteListWidgetFetchNotesEvent(),
    );
  }
}
