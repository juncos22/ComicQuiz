import 'package:comic_quiz/blocs/account/account_bloc.dart';
import 'package:comic_quiz/screens/congrat_screen.dart';
import 'package:comic_quiz/screens/fail_screen.dart';
import 'package:comic_quiz/screens/level_screen.dart';
import 'package:comic_quiz/screens/login_screen.dart';
import 'package:comic_quiz/screens/register_screen.dart';
import 'package:comic_quiz/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ComicQuiz());
}

class ComicQuiz extends StatelessWidget {
  const ComicQuiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountBloc>(
      create: (_) => AccountBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ComicQuiz',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        routes: {
          'login': (_) => LoginScreen(),
          'register': (_) => RegisterScreen(),
          'level': (_) => LevelScreen(),
          'congrat': (_) => CongratScreen(),
          'fail': (_) => FailScreen()
        },
        home: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            if (state is AuthenticatedState) {
              return LevelScreen();
            }
            return SplashScreen();
          },
        ),
      ),
    );
  }
}
