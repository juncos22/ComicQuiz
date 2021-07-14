import 'package:comic_quiz/blocs/trivia/game_bloc.dart';
import 'package:comic_quiz/ui/level/level_screen.dart';
import 'package:comic_quiz/ui/menu/menu_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  static const String routeName = '/result';
  ResultScreen({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 118.0,
              height: 118.0,
              child: CircleAvatar(
                child: Image(
                  image: AssetImage((this.score > 50)
                      ? 'assets/img/congrat.png'
                      : 'assets/img/sad.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Text(
              this.score > 50
                  ? 'Felicidades! Has \nalcanzado tu mejor \npuntuacion!'
                  : 'Que lastima! \nTe falta un largo camino \npara convertirte \nen fan.',
              textAlign: TextAlign.center,
              style: TextStyle(color: HexColor('212121'), fontSize: 18.0),
            ),
            SizedBox(
              height: 48.0,
            ),
            Text(
              'Puntuacion: ${this.score}%',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: HexColor('212121'),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 38.0,
            ),
            Text(
              'Tu nivel es:',
              textAlign: TextAlign.center,
              style: TextStyle(color: HexColor('212121'), fontSize: 15.0),
            ),
            SizedBox(
              height: 11.0,
            ),
            (this.score > 50)
                ? Text(
                    'Comic Fan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: HexColor('F57C00'),
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text(
                    'Comic Noob',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            SizedBox(
              height: 24.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  child: Text(
                    'Reintentar?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: HexColor('536DFE'),
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    await Navigator.pushReplacementNamed(
                        context, LevelScreen.routeName);
                  },
                ),
                BlocListener<GameBLoC, GameState>(
                  listener: (context, state) {
                    if (state is GameStartedState) {
                      Navigator.of(context)
                          .pushReplacementNamed(LevelScreen.routeName);
                    }
                  },
                  child: TextButton(
                    child: Text(
                      'Volver al Menu',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: HexColor('536DFE'),
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context)
                          .pushReplacementNamed(MenuScreen.routeName);
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
