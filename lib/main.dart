import 'package:comic_quiz/blocs/account/authentication_bloc.dart';
import 'package:comic_quiz/blocs/account/authentication_bloc_delegate.dart';
import 'package:comic_quiz/blocs/trivia/game_bloc_delegate.dart';
import 'package:comic_quiz/data/account_data.dart';
import 'package:comic_quiz/data/result_data.dart';
import 'package:comic_quiz/data/trivia_data.dart';
import 'package:comic_quiz/repository/account_repo.dart';
import 'package:comic_quiz/repository/result_repo.dart';
import 'package:comic_quiz/repository/trivia_repo.dart';
import 'package:comic_quiz/ui/menu/menu_screen.dart';
import 'package:comic_quiz/ui/profile/profile_screen.dart';
import 'package:comic_quiz/ui/result/result_screen.dart';
import 'package:comic_quiz/ui/level/level_screen.dart';
import 'package:comic_quiz/ui/login/login_screen.dart';
import 'package:comic_quiz/ui/register/register_screen.dart';
import 'package:comic_quiz/ui/splash/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/trivia/game_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = AuthenticationBlocDelegate();
  Bloc.observer = GameBlocDelegate();

  runApp(ComicQuiz());
}

class ComicQuiz extends StatelessWidget {
  ComicQuiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBLoC>(
          create: (_) => AuthenticationBLoC(AccountRepo(AccountData())),
        ),
        BlocProvider<GameBLoC>(
          create: (_) => GameBLoC(TriviaRepo(TriviaData()),
              AccountRepo(AccountData()), ResultRepo(ResultData())),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ComicQuiz',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          fontFamily: 'ComicNeue',
        ),
        onGenerateRoute: (settings) {
          if (settings.name == ResultScreen.routeName) {
            final args = settings.arguments as Map<String, int>;

            return MaterialPageRoute(
              builder: (context) => ResultScreen(score: args['score'] as int),
            );
          } else if (settings.name == ProfileScreen.routeName) {
            final args = settings.arguments as Map<String, User?>;
            return MaterialPageRoute(
              builder: (context) => ProfileScreen(
                user: args['user'],
              ),
            );
          }
        },
        routes: {
          'login': (_) => LoginScreen(),
          'register': (_) => RegisterScreen(),
          'level': (_) => LevelScreen(),
          'menu': (_) => MenuScreen(),
          'profile': (_) => ProfileScreen(),
          'main': (_) => ComicQuiz(),
        },
        home: BlocBuilder<AuthenticationBLoC, AuthenticationState>(
          builder: (context, state) {
            if (state is AccountStateChanged) {
              if (state.user != null) {
                return MenuScreen(
                  user: state.user,
                );
              }
              return SplashScreen();
            }
            return SplashScreen();
          },
        ),
      ),
    );
  }
}
