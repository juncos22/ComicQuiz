import 'package:comic_quiz/ui/menu/components/menu_button.dart';
import 'package:comic_quiz/ui/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key, this.user}) : super(key: key);

  final User? user;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 113.0,
              height: 105.0,
              child: CircleAvatar(
                child: Image(image: AssetImage('assets/img/icon.png')),
              ),
            ),
            (this.user != null)
                ? Text(
                    'Bienvenido/a de nuevo ${this.user?.email}',
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
            MenuButton(
                title: 'Comenzar a Jugar',
                backgrounColor: HexColor('536DFE'),
                fontWeight: FontWeight.bold,
                onPressed: () async {
                  await Navigator.pushReplacementNamed(context, 'level');
                }),
            (this.user != null)
                ? MenuButton(
                    title: 'Observar mi Perfil',
                    backgrounColor: HexColor('FF9800'),
                    borderColor: HexColor('F57C00'),
                    fontWeight: FontWeight.normal,
                    onPressed: () async => await Navigator.of(context)
                        .pushNamed(ProfileScreen.routeName,
                            arguments: {'user': this.user}))
                : Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MenuButton(
                            title: 'Ingresar con mi cuenta',
                            backgrounColor: HexColor('FF9800'),
                            borderColor: HexColor('F57C00'),
                            fontWeight: FontWeight.normal,
                            onPressed: () =>
                                Navigator.of(context).pushNamed('login')),
                        SizedBox(
                          height: 30.0,
                        ),
                        MenuButton(
                            title: 'Registrarme',
                            backgrounColor: HexColor('FF9800'),
                            borderColor: HexColor('F57C00'),
                            fontWeight: FontWeight.normal,
                            onPressed: () =>
                                Navigator.of(context).pushNamed('register')),
                      ],
                    ),
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
}
