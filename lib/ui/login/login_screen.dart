import 'package:comic_quiz/blocs/account/authentication_bloc.dart';
import 'package:comic_quiz/main.dart';
import 'package:comic_quiz/ui/login/components/login_form.dart';
import 'package:comic_quiz/ui/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width - 10,
        height: size.height - 10,
        child: BlocListener<AuthenticationBLoC, AuthenticationState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              Navigator.pushReplacementNamed(context, ComicQuiz.routeName);
            }
            if (state is LoginFailureState) {
              _onShowError(state.error, context);
            }
            if (state is LoggingInState) {
              _onLoggingProcess(context);
            }
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50.0,
                ),
                SizedBox(
                  width: 107.0,
                  height: 110.0,
                  child: CircleAvatar(
                    child: Image(image: AssetImage('assets/icon/icon.png')),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'Ingresa con tu cuenta',
                  style: TextStyle(fontFamily: 'ComicNeue', fontSize: 18.0),
                ),
                SizedBox(
                  height: 33.0,
                ),
                LoginForm(
                    formKey: this._formKey,
                    emailController: this._emailController,
                    passwordController: this._passwordController,
                    onPressed: this._startLogin),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('No posee una cuenta?'),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(
                          context, RegisterScreen.routeName),
                      child: Text(
                        'Registrarse',
                        style: TextStyle(color: Colors.amber),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 9.0,
                ),
                Text('O ingresa con tus redes'),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: 300.0,
                  height: 50.0,
                  child: OutlinedButton(
                      onPressed: () => this._logInWithGoogle(),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(color: Colors.blue, width: 2.0),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.google,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            'Ingresa con Google',
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _startLogin() {
    if (this._formKey.currentState!.validate()) {
      if (this._emailController.value.text.isNotEmpty &&
          this._passwordController.value.text.isNotEmpty) {
        String email = this._emailController.value.text;
        String password = this._passwordController.value.text;

        var bloc = BlocProvider.of<AuthenticationBLoC>(context);
        bloc.add(RequestLoginEvent(email, password));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Complete los campos')));
      }
    }
  }

  void _logInWithGoogle() {
    BlocProvider.of<AuthenticationBLoC>(context).add(RequestLoginWithGoogle());
  }

  void _onLoggingProcess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: ListTile(
          leading: CircularProgressIndicator(
            color: Colors.blue,
          ),
          title: Text(
            'Ingresando',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  void _onShowError(String error, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: ListTile(
        leading: FaIcon(
          FontAwesomeIcons.angry,
          color: Colors.red,
        ),
        title: Text(
          error,
          style: TextStyle(color: Colors.red),
        ),
      ),
    ));
  }
}
