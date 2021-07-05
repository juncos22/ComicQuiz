import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({Key? key}) : super(key: key);

  @override
  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  String? respuesta;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [HexColor('F57C00'), HexColor('E18E12')])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(13.0),
                  child: Image.asset(
                    'lib/images/green_lantern.jpg',
                    width: 121.0,
                    height: 110.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Como se llama el \npersonaje que le dio el \nanillo a Hal Jordan?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: HexColor('212121'),
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Container(
                width: size.width - 10,
                height: size.height - (size.height * 0.5),
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(3, (index) {
                    return ListTile(
                      title: Text(
                        'Opcion ${index + 1}',
                        style: TextStyle(
                            color: HexColor('212121'),
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: Radio<String>(
                          value: "Opcion ${index + 1}",
                          groupValue: respuesta,
                          onChanged: (value) {
                            setState(() {
                              respuesta = value;
                            });
                          }),
                      onTap: () {
                        setState(() {
                          respuesta = "Opcion ${index + 1}";
                          print(respuesta);
                          if (index % 2 == 0) {
                            Navigator.pushNamed(context, 'congrat');
                          }else {
                            Navigator.pushNamed(context, 'fail');
                          }
                        });
                      },
                    );
                  }),
                ))
          ],
        ),
      ),
    );
  }
}
