import 'package:comic_quiz/blocs/account/authentication_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key, this.user}) : super(key: key);

  static const String routeName = '/profile';
  final User? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: BlocListener<AuthenticationBLoC, AuthenticationState>(
        listener: (context, state) {
          if (state is LogoutSuccessState) {
            Navigator.of(context).pushReplacementNamed('main');
          }
          if (state is LogoutFailureState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Perfil de ${this.user?.email}'),
            ElevatedButton(
              onPressed: () => BlocProvider.of<AuthenticationBLoC>(context)
                  .add(RequestLogoutEvent()),
              child: Text('Cerrar Sesion'),
            ),
          ],
        ),
      ),
    ));
  }
}
