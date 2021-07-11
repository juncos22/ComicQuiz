import 'package:comic_quiz/blocs/account/authentication_bloc.dart';
import 'package:comic_quiz/ui/menu/menu_screen.dart';
import 'package:comic_quiz/ui/register/components/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
                  child: Image(image: AssetImage('assets/img/icon.png')),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Crea una cuenta',
                style: TextStyle(fontFamily: 'ComicNeue', fontSize: 18.0),
              ),
              BlocConsumer<AuthenticationBLoC, AuthenticationState>(
                listener: (context, state) {
                  if (state is AccountStateChanged) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MenuScreen(
                            user: state.user,
                          ),
                        ),
                        (route) => false);
                  }
                  if (state is LoginFailureState) {
                    _showError(state.error, context);
                  }
                },
                builder: (context, state) {
                  if (state is LoggingInState) {
                    return Container(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container();
                },
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
                    onPressed: () => Navigator.pushNamed(context, 'login'),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: TextButton(
                        onPressed: () {},
                        child: Image.asset('assets/img/google.png')),
                  ),
                  SizedBox(
                    width: 38.0,
                  ),
                  SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: TextButton(
                        onPressed: () {},
                        child: Image.asset('assets/img/facebook.png')),
                  ),
                  SizedBox(
                    width: 38.0,
                  ),
                  SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: TextButton(
                        onPressed: () {},
                        child: Image.asset('assets/img/twitter.png')),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showError(String error, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Card(
        child: ListTile(
          leading: Icon(Icons.error),
          title: Text(error),
        ),
      ),
    ));
  }
}
