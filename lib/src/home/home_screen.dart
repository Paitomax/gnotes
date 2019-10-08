import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnotes/src/add_note/add_note_screen.dart';
import 'package:gnotes/src/auth_manager.dart';
import 'package:gnotes/src/home/home_bloc.dart';
import 'package:gnotes/src/home/home_event.dart';
import 'package:gnotes/src/home/home_state.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text("GNotes"),
      ),
      body: BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is ErrorHomeState) {
            return Container(alignment: Alignment.center, child: Text(state.error));
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
    );
  }

  Widget _circularProgress(){
    return Container(alignment: Alignment.center,child: CircularProgressIndicator());
  }

  goToAddNoteScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddNoteScreen();
    }));
  }

//  List<Note> createMock() {
//    List<Note> list = List<Note>();
//    list.addAll([
//      Note(
//        'Jogar',
//        'Hoje preciso jogar até o amanhecer',
//        DateTime.now(),
//        DateTime.now(),
//        id: "1",
//      ),
//      Note(
//        'Tarefa de inglês',
//        'O baguiu vai ser louco se eu não fizer essas tarefas marotas.',
//        DateTime.now(),
//        DateTime.now(),
//        id: "1",
//      ),
//      Note(
//        'Aniversario da Line',
//        'NÃO POSSO ESQUECER DE PARABENIZAR MEU AMORZÃO HOJE',
//        DateTime.now(),
//        DateTime.now(),
//        id: "1",
//      ),
//      Note(
//        'Ihuu',
//        'Cansei de escrever os coiso tudo, quero ver logo essa tela',
//        DateTime.now(),
//        DateTime.now(),
//        id: "1",
//      ),
//    ]);
//    return list;
//  }
}
