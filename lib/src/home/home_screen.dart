import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnotes/src/add_note/add_note_screen.dart';
import 'package:gnotes/src/auth_manager.dart';
import 'package:gnotes/src/home/home_bloc.dart';
import 'package:gnotes/src/home/home_event.dart';
import 'package:gnotes/src/home/home_state.dart';
import 'package:gnotes/src/login/login_screen.dart';
import 'package:gnotes/src/models/note.dart';
import 'package:gnotes/src/widgets/note_list/note_list_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc _bloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    _bloc.dispatch(HomeFetchNotesEvent(AuthManager.loggedUser.uid));

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("GNotes"),
          actions: <Widget>[
            PopupMenuButton<String>(
                onSelected: onMenuSelected,
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: "sair",
                      child: Text("Sair"),
                    ),
                  ];
                }),
          ],
        ),
        body: BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            if (state is ErrorHomeState) {
              return Container(
                  alignment: Alignment.center, child: Text(state.error));
            } else if (state is LoadingHomeState) {
              return _circularProgress();
            } else if (state is LoadedHomeState) {
              return NoteListWidget(state.notes);
            } else {
              return _circularProgress();
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
            tooltip: "Adicionar novo",
            child: Icon(Icons.add),
            onPressed: goToAddNoteScreen),
      ),
    );
  }

  onMenuSelected(String value) {
    if (value == "sair") {
      AuthManager.signOutGoogle();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (context) {
          return LoginScreen();
        },
      ), (Route<dynamic> route) => false);
    }
  }

  Widget _circularProgress() {
    return Container(
        alignment: Alignment.center, child: CircularProgressIndicator());
  }

  goToAddNoteScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddNoteScreen();
    }));
  }
}
