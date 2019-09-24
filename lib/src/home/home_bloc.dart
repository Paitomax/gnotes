import 'package:bloc/bloc.dart';
import 'package:gnotes/src/home/home_event.dart';
import 'package:gnotes/src/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeUninitialized();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) {
    return null;
  }
}
