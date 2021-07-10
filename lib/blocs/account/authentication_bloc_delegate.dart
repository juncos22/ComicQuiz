import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print({bloc, event});
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print({bloc, transition.event});
    print({bloc, transition.currentState});
    print({bloc, transition.nextState});
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print({bloc, error, stackTrace});
  }
}
