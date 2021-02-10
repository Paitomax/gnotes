import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnotes/src/auth/auth_repository.dart';
import 'package:gnotes/src/home/home_bloc.dart';
import 'package:gnotes/src/home/home_screen.dart';
import 'package:gnotes/src/login/login_screen.dart';
import 'package:gnotes/src/widgets/note_list/note_list_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/add_note/add_note_bloc.dart';
import 'src/auth/bloc.dart';
import 'src/login/bloc.dart';

class GNoteApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return registerBlocProviders(
      child: MaterialApp(
        title: 'GNote',
        theme: ThemeData(
          buttonColor: Colors.blue,
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial) {
              return Scaffold(
                backgroundColor: Colors.blue,
                body: Center(
                  child: Text(
                    'Gnotes',
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              );
            } else if (state is Unauthenticated) {
              return LoginScreen();
            } else if (state is Authenticated) {
              return HomeScreen();
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget registerBlocProviders({Widget child}) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      initialData: null,
      builder: (context, value) {
        if (value.data == null) return Container();

        final firebaseAuth = FirebaseAuth.instance;
        final authRepository = AuthRepository(firebaseAuth: firebaseAuth);

        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider<FirebaseAuth>(create: (_) => firebaseAuth),
            RepositoryProvider<AuthRepository>(create: (_) => authRepository),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>(
                  create: (_) => AuthBloc(authRepository, firebaseAuth)),
              BlocProvider<NoteListWidgetBloc>(
                  create: (_) => NoteListWidgetBloc(authRepository)),
              BlocProvider<HomeBloc>(
                  create: (_) =>
                      HomeBloc(BlocProvider.of<NoteListWidgetBloc>(_))),
              BlocProvider<LoginBloc>(create: (_) => LoginBloc(authRepository)),
              BlocProvider<AddNoteBloc>(
                  create: (_) => AddNoteBloc(authRepository)),
            ],
            child: child,
          ),
        );
      },
    );
  }
}
