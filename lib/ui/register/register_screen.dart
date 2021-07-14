import 'package:comic_quiz/blocs/account/authentication_bloc.dart';
import 'package:comic_quiz/ui/login/login_screen.dart';
import 'package:comic_quiz/ui/register/components/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:comic_quiz/main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const String routeName = 'register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  void _createAccount() {
    if (this.formKey.currentState!.validate()) {
      if (this.emailController.value.text.isNotEmpty &&
          this.passwordController.value.text.isNotEmpty) {
        String email = this.emailController.value.text;
        String password = this.passwordController.value.text;

        BlocProvider.of<AuthenticationBLoC>(context)
            .add(RequestRegisterEvent(email, password));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Complete los campos')));
      }
    }
  }

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
              Navigator.of(context).pushReplacementNamed(ComicQuiz.routeName);
            }
            if (state is LoginFailureState) {
              _showError(state.error, context);
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
                  'Crea una cuenta',
                  style: TextStyle(fontFamily: 'ComicNeue', fontSize: 18.0),
                ),
                SizedBox(
                  height: 33.0,
                ),
                RegisterForm(
                    emailController: this.emailController,
                    passwordController: this.passwordController,
                    formKey: this.formKey,
                    onPressed: this._createAccount),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Ya tenes una cuenta?'),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, LoginScreen.routeName),
                      child: Text(
                        'Ingresa',
                        style: TextStyle(color: Colors.amber),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 9.0,
                ),
                Text('O registrate con tus redes'),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: 300.0,
                  height: 50.0,
                  child: OutlinedButton(
                      onPressed: () => this._signUpWithGoogle(),
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
                            'Registrate con Google',
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

  void _signUpWithGoogle() {
    BlocProvider.of<AuthenticationBLoC>(context).add(RequestLoginWithGoogle());
  }

  void _onLoggingProcess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: ListTile(
      leading: SizedBox(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            color: Colors.blue,
          )),
      title: Text(
        'Ingresando...',
        style: TextStyle(color: Colors.blue),
      ),
    )));
  }

  void _showError(String error, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
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
      ),
    );
  }
}
