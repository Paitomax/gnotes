import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gnotes/src/add_note/add_note_screen.dart';
import 'package:gnotes/src/widgets/note_list/models/note_model.dart';
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
      body: NoteListWidget(createMock()),
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

  List<NoteModel> createMock() {
    List<NoteModel> list = List<NoteModel>();
    list.addAll([
      NoteModel(
        'Jogar',
        'Hoje preciso jogar até o amanhecer',
        id: 1,
      ),
      NoteModel(
        'Tarefa de inglês',
        'O baguiu vai ser louco se eu não fizer essas tarefas marotas.',
        id: 1,
      ),
      NoteModel(
        'Aniversario da Line',
        'NÃO POSSO ESQUECER DE PARABENIZAR MEU AMORZÃO HOJE',
        id: 1,
      ),
      NoteModel(
        'Ihuu',
        'Cansei de escrever os coiso tudo, quero ver logo essa tela',
        id: 1,
      ),
    ]);
    return list;
  }
}
