import 'package:comic_quiz/blocs/account/authentication_bloc.dart';
import 'package:comic_quiz/main.dart';
import 'package:comic_quiz/ui/profile/components/profile_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [HexColor('F57C00'), HexColor('FF9800')],
        begin: Alignment.topCenter,
        end: Alignment.center,
      )),
      child: BlocListener<AuthenticationBLoC, AuthenticationState>(
        listener: (context, state) {
          if (state is LogoutSuccessState) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(ComicQuiz.routeName, (route) => false);
          }
          if (state is LogoutFailureState) {
            _showError(context, state.error);
          }
        },
        child: BlocBuilder<AuthenticationBLoC, AuthenticationState>(
          builder: (context, state) {
            if (state is AccountStateChanged) {
              return ProfileInfo(user: state.user);
            }
            return Container();
          },
        ),
      ),
    ));
  }

  void _showError(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: ListTile(
        leading: Icon(
          Icons.error,
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
