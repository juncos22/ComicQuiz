import 'package:comic_quiz/blocs/account/authentication_bloc.dart';
import 'package:comic_quiz/blocs/trivia/game_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({Key? key, this.user}) : super(key: key);
  final User? user;

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  void initState() {
    super.initState();
    this._loadResult(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Stack(alignment: Alignment.center, children: [
        Container(
          width: 312.0,
          height: 269.0,
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Card(
            color: HexColor('536DFE'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60.0,
                ),
                Text(
                  '${(this.widget.user?.displayName != null) ? this.widget.user?.displayName : this.widget.user?.email}',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.0,
                ),
                BlocBuilder<GameBLoC, GameState>(
                  builder: (context, state) {
                    if (state is GameFailureState) {
                      return this._showError(context, state.error);
                    }
                    if (state is LoadingResultState) {
                      return Container(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is ResultLoadedState) {
                      if (state.result != null) {
                        return Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Score',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      '${state.result?.score}%',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 77.0,
                              ),
                              Container(
                                margin: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Played at',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      '${state.result?.playedAt}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Text(
                          'No has jugado el juego todavia...\nComienza a sumar puntos!',
                          style: TextStyle(fontSize: 18.0),
                          textAlign: TextAlign.center,
                        );
                      }
                    }
                    return Container();
                  },
                ),
                SizedBox(
                  height: 24.0,
                ),
                Container(
                  width: 154.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border:
                          Border.all(color: HexColor('FF9800'), width: 1.0)),
                  child: TextButton(
                    onPressed: () => this._requestLogout(context),
                    child: Text(
                      'Cerrar Sesion',
                      style: TextStyle(
                        color: HexColor('FF9800'),
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: (size.height / 2) - (size.height * 0.3),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: (this.widget.user?.photoURL != null)
                ? Image(
                    width: 110.0,
                    height: 110.0,
                    fit: BoxFit.fill,
                    image: NetworkImage(this.widget.user?.photoURL as String),
                  )
                : Image(
                    width: 110.0,
                    height: 110.0,
                    fit: BoxFit.fill,
                    image: AssetImage('assets/icon/icon.png'),
                  ),
          ),
        ),
      ]),
    );
  }

  Widget _showError(BuildContext context, String error) {
    return Card(
      child: ListTile(
        leading: Icon(
          Icons.error,
          color: Colors.red,
        ),
        title: Text(
          error,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  void _loadResult(BuildContext context) {
    BlocProvider.of<GameBLoC>(context).add(RetrieveResultEvent());
  }

  void _requestLogout(BuildContext context) {
    BlocProvider.of<AuthenticationBLoC>(context).add(RequestLogoutEvent());
  }
}
