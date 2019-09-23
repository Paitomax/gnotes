import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gnotes/src/widgets/note_list/models/note_model.dart';
import 'package:gnotes/src/widgets/note_list/note_list_widget.dart';

class GNoteApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GNote',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GNotes"),
      ),
      body: NoteListWidget(createMock()),
    );
  }

  List<NoteModel> createMock() {
    List<NoteModel> list = List<NoteModel>();
    list.addAll([
      NoteModel(1, 'Jogar', 'Hoje preciso jogar até o amanhecer'),
      NoteModel(2, 'Tarefa de inglês', 'O baguiu vai ser louco se eu não fizer essas tarefas marotas.'),
      NoteModel(3, 'Aniversario da Line', 'NÃO POSSO ESQUECER DE PARABENIZAR MEU AMORZÃO HOJE'),
      NoteModel(4, 'Ihuu', 'Cansei de escrever os coiso tudo, quero ver logo essa tela'),
    ]);
    return list;
  }
}
