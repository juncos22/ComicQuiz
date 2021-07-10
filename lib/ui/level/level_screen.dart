import 'package:comic_quiz/blocs/trivia/game_bloc.dart';
import 'package:comic_quiz/models/option.dart';
import 'package:comic_quiz/ui/result/result_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({Key? key}) : super(key: key);

  @override
  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  Option? respuesta;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [HexColor('F57C00'), HexColor('E18E12')])),
        child: BlocListener<GameBLoC, GameState>(
          listener: (context, state) async {
            if (state is GameFinishedState) {
              await Navigator.of(context).pushReplacementNamed(
                  ResultScreen.routeName,
                  arguments: {'score': state.result.score});
            }
            if (state is GameFailureState) {
              _showError(state.error);
            }
            if (state is QuestionAnsweredState) {
              BlocProvider.of<GameBLoC>(context).add(LoadQuestionsEvent());
            }
          },
          child: BlocBuilder<GameBLoC, GameState>(
            builder: (context, state) {
              if (state is LoadingQuestionState) {
                return SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state is QuestionLoadedState) {
                // print("Question Loaded JSON: ${state.question.toJson()}");

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 130.0,
                          height: 130.0,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            child: Image(
                              image:
                                  NetworkImage(state.question.characterImage),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          width: 200.0,
                          height: 80.0,
                          child: Text(
                            state.question.question,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true,
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: size.width - 10,
                      height: size.height * 0.5,
                      padding: EdgeInsets.all(5.0),
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Radio<Option>(
                                groupValue: this.respuesta,
                                value: state.question.options[index],
                                onChanged: (value) {
                                  _onSelectAnswer(value);
                                },
                              ),
                              onTap: () {
                                _onSelectAnswer(state.question.options[index]);
                              },
                              title: Text(state.question.options[index].option),
                            );
                          },
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: state.question.options.length),
                    )
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  void loadQuestions() {
    BlocProvider.of<GameBLoC>(context).add(LoadQuestionsEvent());
  }

  void _onSelectAnswer(Option? value) {
    this.respuesta = value;
    BlocProvider.of<GameBLoC>(context)
        .add(AnswerQuestionEvent(this.respuesta!));
  }

  void _showError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
  }
}
