import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class FailScreen extends StatelessWidget {
  const FailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 118.0,
              height: 118.0,
              child: CircleAvatar(
                child: Image(
                  image: AssetImage('lib/images/sad.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Text(
              'Que mal! Te falta \nrecorrer un largo \ncamino...',
              textAlign: TextAlign.center,
              style: TextStyle(color: HexColor('212121'), fontSize: 18.0),
            ),
            SizedBox(
              height: 48.0,
            ),
            Text(
              'Puntuacion: 10 pt.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: HexColor('212121'),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 38.0,
            ),
            Text(
              'Tu nivel es:',
              textAlign: TextAlign.center,
              style: TextStyle(color: HexColor('212121'), fontSize: 15.0),
            ),
            SizedBox(
              height: 11.0,
            ),
            Text(
              'Comic Noob',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor('F50000'),
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            TextButton(
              child: Text(
                'Reintentar?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: HexColor('536DFE'),
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => Navigator.pushNamed(context, 'level'),
            )
          ],
        ),
      ),
    );
  }
}
