import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:acab_app/screens/data_list.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    Future.delayed(
        Duration(
            milliseconds: 3000
        ), () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => DataList('Lista de Datos'))));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: Padding(
        padding: EdgeInsets.only(top: 50.0),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/appstore.png'),
                maxRadius: 130.0,
                minRadius: 50.0,
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(
                bottom: 50.0,
              ),
              child: SpinKitFoldingCube(
                color: Colors.blue[800],
                size: 90,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10.0,
                  bottom: 15.0
              ),
              child: Text(
                "CARGANDO...",
                style: GoogleFonts.kanit(
                  fontSize: 20.0,
                  color: Colors.white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}