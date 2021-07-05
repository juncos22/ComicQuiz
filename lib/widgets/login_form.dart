import 'package:comic_quiz/blocs/account_bloc.dart';
import 'package:comic_quiz/blocs/states/account_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm(
      {Key? key,
      required this.emailController,
      required this.passwordController,
      required this.onPressed})
      : super(key: key);

  final emailController;
  final passwordController;
  final VoidCallback onPressed;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return state is LoadingState
            ? Container(
                child: Center(
                    child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          color: Colors.amber,
                        ))),
              )
            : Form(
                key: this.formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 278.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.amber),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: widget.emailController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(color: Colors.amber)),
                            hintText: 'Correo electronico'),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      width: 278.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.amber),
                      child: TextFormField(
                        obscureText: true,
                        controller: widget.passwordController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(color: Colors.amber)),
                            hintText: 'Contraseña'),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      width: 278.0,
                      height: 47.0,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: TextButton(
                        onPressed: widget.onPressed,
                        child: Text(
                          'Ingresar',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    ));
  }
}
