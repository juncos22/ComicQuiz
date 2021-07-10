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
            width: 278.0,
            height: 50.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0), color: Colors.amber),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: widget.emailController,
              // validator: (value) => value == null
              //     ? "Complete el email"
              //     : !value.contains('@')
              //         ? "Email invalido"
              //         : "",
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
                borderRadius: BorderRadius.circular(15.0), color: Colors.amber),
            child: TextFormField(
              obscureText: true,
              controller: widget.passwordController,
              // validator: (value) => value == null
              //     ? "Complete la contraseña"
              //     : value.length < 6
              //         ? "La contraseña debe ser mayor a 6 caracteres"
              //         : "",
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
