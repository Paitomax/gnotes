import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gnotes/src/add_note/add_note_screen.dart';
import 'package:gnotes/src/models/note.dart';
import 'package:gnotes/src/widgets/note_list/note_list_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GNotes"),
      ),
      body: Text(""), //NoteListWidget(createMock()),
      floatingActionButton: FloatingActionButton(
          tooltip: "Adicionar novo",
          child: Icon(Icons.add),
          onPressed: goToAddNoteScreen),
    );
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
