import 'package:comic_quiz/blocs/account/authentication_bloc.dart';
import 'package:comic_quiz/ui/level/level_screen.dart';
import 'package:comic_quiz/ui/login/login_screen.dart';
import 'package:comic_quiz/ui/menu/components/menu_button.dart';
import 'package:comic_quiz/ui/profile/profile_screen.dart';
import 'package:comic_quiz/ui/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);
  static const String routeName = 'menu';

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
            colors: [HexColor('F57C00'), HexColor('E18E12')],
          ),
        ),
        child: BlocBuilder<AuthenticationBLoC, AuthenticationState>(
          builder: (context, state) {
            if (state is AccountStateChanged) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 113.0,
                    height: 105.0,
                    child: CircleAvatar(
                      child: Image(image: AssetImage('assets/icon/icon.png')),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  (state.user != null)
                      ? Text(
                          (state.user?.displayName != null)
                              ? 'Bienvenido/a de nuevo ${state.user?.displayName}'
                              : 'Bienvenido/a de nuevo ${state.user?.email}',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                          softWrap: true,
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          'Bienvenido/a a ComicQuiz!',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                  SizedBox(
                    height: 20.0,
                  ),
                  (state.user != null)
                      ? Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MenuButton(
                                title: 'Comenzar a Jugar',
                                backgrounColor: HexColor('536DFE'),
                                fontWeight: FontWeight.bold,
                                onPressed: () => _goToLevel(context),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              MenuButton(
                                  title: 'Observar mi Perfil',
                                  backgrounColor: HexColor('FF9800'),
                                  borderColor: HexColor('F57C00'),
                                  fontWeight: FontWeight.normal,
                                  onPressed: () async =>
                                      await Navigator.of(context).pushNamed(
                                        ProfileScreen.routeName,
                                      )),
                            ],
                          ),
                        )
                      : Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MenuButton(
                                  title: 'Ingresar con mi cuenta',
                                  backgrounColor: HexColor('FF9800'),
                                  borderColor: HexColor('F57C00'),
                                  fontWeight: FontWeight.normal,
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed(LoginScreen.routeName)),
                              SizedBox(
                                height: 20.0,
                              ),
                              MenuButton(
                                  title: 'Registrarme',
                                  backgrounColor: HexColor('FF9800'),
                                  borderColor: HexColor('F57C00'),
                                  fontWeight: FontWeight.normal,
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed(RegisterScreen.routeName)),
                            ],
                          ),
                        ),
                  SizedBox(
                    height: 20.0,
                  ),
                  MenuButton(
                      title: 'Salir',
                      backgrounColor: HexColor('BDBDBD'),
                      borderColor: HexColor('757575'),
                      fontWeight: FontWeight.normal,
                      onPressed: () async {
                        await _requestExit(context);
                      }),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Future<void> _requestExit(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Salir del juego?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  SystemNavigator.pop();
                },
                child: Text('Si')),
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('No')),
          ],
        );
      },
    );
  }

  void _goToLevel(BuildContext context) async {
    await Navigator.pushReplacementNamed(context, LevelScreen.routeName);
  }
}
