import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () async {
      return await Navigator.pushReplacementNamed(context, 'menu');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [HexColor('F57C00'), HexColor('E18E12')],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Center(
          child: SizedBox(
            width: 149.0,
            height: 144.0,
            child: CircleAvatar(
              child: Image(
                image: AssetImage('assets/img/icon.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
