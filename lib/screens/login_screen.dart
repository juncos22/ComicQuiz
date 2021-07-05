import 'package:comic_quiz/blocs/account_bloc.dart';
import 'package:comic_quiz/blocs/events/account_event.dart';
import 'package:comic_quiz/blocs/states/account_state.dart';
import 'package:comic_quiz/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AccountBloc _accountBloc = AccountBloc();
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();

  @override
  void dispose() {
    this._accountBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width - 10,
        height: size.height - 10,
        child: BlocListener<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is AuthenticatedState) {
              Navigator.pushNamed(context, 'level');
              Navigator.pop(context);
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
                    child: Image(image: AssetImage('lib/images/icon.png')),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'Ingresa con tu cuenta',
                  style: TextStyle(fontFamily: 'ComicNeue', fontSize: 18.0),
                ),
                BlocBuilder<AccountBloc, AccountState>(
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return Container(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is FailureState) {
                      return Container(
                        width: size.width - 30,
                        height: 30.0,
                        child: Card(
                          child: ListTile(
                            leading: Icon(Icons.error),
                            title: Text(state.error.toString()),
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                SizedBox(
                  height: 33.0,
                ),
                LoginForm(
                    emailController: this._emailController,
                    passwordController: this._passwordController,
                    onPressed: () => this._startLogin()),
                SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('No posee una cuenta?'),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, 'register'),
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
                          child: Image.asset('lib/images/google.png')),
                    ),
                    SizedBox(
                      width: 38.0,
                    ),
                    SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: TextButton(
                          onPressed: () {},
                          child: Image.asset('lib/images/facebook.png')),
                    ),
                    SizedBox(
                      width: 38.0,
                    ),
                    SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: TextButton(
                          onPressed: () {},
                          child: Image.asset('lib/images/twitter.png')),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _startLogin() {
    if (this._emailController.value.text.isNotEmpty &&
        this._passwordController.value.text.isNotEmpty) {
      this._accountBloc.accountEvent.add(LoginEvent(
          this._emailController.value.text,
          this._passwordController.value.text));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Complete los campos')));
    }
  }
}
