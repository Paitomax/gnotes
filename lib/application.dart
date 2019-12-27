import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnotes/src/home/home_bloc.dart';
import 'package:gnotes/src/login/login_screen.dart';
import 'package:gnotes/src/widgets/note_list/note_list_bloc.dart';

class GNoteApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteListWidgetBloc>(create: (_) => NoteListWidgetBloc()),
        BlocProvider<HomeBloc>(
            create: (_) =>
                HomeBloc(BlocProvider.of<NoteListWidgetBloc>(_))),
      ],
      child: MaterialApp(
        title: 'GNote',
        theme: ThemeData(
          buttonColor: Colors.blue,
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
