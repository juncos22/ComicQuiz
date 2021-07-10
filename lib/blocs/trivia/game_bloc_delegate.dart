import 'package:flutter_bloc/flutter_bloc.dart';

class GameBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print("${{bloc, event}},\n");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print("${{bloc, transition.event}}\n");
    print("${{bloc, transition.currentState}}\n");
    print("${{bloc, transition.nextState}}\n");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print("${{bloc, error, stackTrace}}\n");
  }
}
