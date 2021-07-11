import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm(
      {Key? key,
      required this.formKey,
      required this.emailController,
      required this.passwordController,
      required this.onPressed})
      : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onPressed;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 300.0,
            height: 63.0,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0), color: Colors.amber),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: widget.emailController,
              validator: (value) =>
                  !value!.contains('@') ? 'Email invalido' : null,
              decoration:
                  InputDecoration(hintText: 'Correo electronico', border: null),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            width: 300.0,
            height: 63.0,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0), color: Colors.amber),
            child: TextFormField(
              obscureText: true,
              controller: widget.passwordController,
              validator: (value) => value!.length < 6
                  ? 'La contraseña no debe ser menor a 6 caracteres'
                  : null,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            width: 300.0,
            height: 50.0,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20.0)),
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
    ));
  }
}
