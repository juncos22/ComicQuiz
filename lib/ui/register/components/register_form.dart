import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey formKey;
  final VoidCallback onPressed;

  const RegisterForm(
      {Key? key,
      required this.emailController,
      required this.passwordController,
      required this.formKey,
      required this.onPressed})
      : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
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
              height: 60.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.amber),
              child: TextFormField(
                controller: widget.emailController,
                keyboardType: TextInputType.emailAddress,
                // autovalidateMode: AutovalidateMode.always,
                validator: (value) =>
                    (!value!.contains('@')) ? 'Email invalido' : null,
                decoration: InputDecoration(
                    border: null, hintText: 'Correo electronico'),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              width: 300.0,
              height: 60.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.amber),
              child: TextFormField(
                controller: widget.passwordController,
                obscureText: true,
                // autovalidateMode: AutovalidateMode.always,
                validator: (value) => value!.length < 6
                    ? 'La contraseña no debe ser menor a 6 caracteres'
                    : null,
                decoration:
                    InputDecoration(border: null, hintText: 'Contraseña'),
              ),
            ),
            SizedBox(
              height: 13.0,
            ),
            Container(
              width: 300.0,
              height: 50.0,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20.0)),
              child: TextButton(
                onPressed: widget.onPressed,
                child: Text(
                  'Crear Cuenta',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
