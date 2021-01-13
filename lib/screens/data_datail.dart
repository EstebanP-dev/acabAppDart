import 'package:flutter/material.dart';
import 'package:acab_app/models/Data.dart';
import 'package:acab_app/database/data.database.dart';
import 'package:acab_app/models/controller.dart';
import 'package:acab_app/models/excel.form.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DataDetail extends StatefulWidget {

  final String appBarTitle;
  final Data data;

  DataDetail(this.data, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return DataListState(this.data, this.appBarTitle);
  }
}
class DataListState extends State<DataDetail> {

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Data data;

  TextEditingController aptoController = TextEditingController();
  TextEditingController activityController = TextEditingController();
  final progressController = TextEditingController();

  DataListState(this.data, this.appBarTitle);

  //excel
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String __date = DateFormat.yMd().add_Hms().format(DateTime.now());

  void _submitForm () {
    if(_formKey.currentState.validate()){
      ExcelForm excelForm = ExcelForm(aptoController.text, activityController.text, progressController.text, __date);
      FormController formController = FormController(
          (String response){
            print(response);
            if(response == FormController.STATUS_SUCCESS){
              _showSnackBar("Datos enviados al Excel");
            }else {
              _showSnackBar("Ha ocurrido un error al enviar los datos al Excel");
            }
          }
      );
      _showSnackBar("Enviando datos al Excel");
      formController.sumitForm(excelForm);
    }

  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle1;



    aptoController.text = data.apto;
    activityController.text = data.activity;
    progressController.text = data.progress.toString();

    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: Scaffold(
        key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          appBarTitle.toUpperCase(),
          style: GoogleFonts.kanit()
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
              Icons.keyboard_arrow_left,
            size: 35.0,
          ),
          onPressed: () {
            moveToLastScreen();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: Form(
          key: _formKey,
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 50.0, bottom: 50.0),
                  child: Text(
                    'ACABAPP',
                    style: GoogleFonts.bigShouldersText(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        color: Colors.blueAccent
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                //First element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextFormField(
                    validator: (value) {
                      if(value.isEmpty){
                        return "Ingresa un valor en Apartamento";
                      } else {
                        return null;
                      }
                    },
                    controller: aptoController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Apto');
                      updateApto();
                    },
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.apartment_rounded,
                          color: Colors.blueAccent,
                        ),
                        labelText: 'Apartamento',
                        labelStyle: textStyle,
                        helperText: 'Ingrese el apartamento',
                        counterText: '20 caracteres',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),
                //Second Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextFormField(
                    validator: (value) {
                      if(value.isEmpty){
                        return "Ingresa un valor en Actividad";
                      } else {
                        return null;
                      }
                    },
                    controller: activityController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Activity');
                      updateActivity();
                    },
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.assessment,
                          color: Colors.blueAccent,
                        ),
                        labelText: 'Actividad',
                        labelStyle: textStyle,
                        helperText: 'Ingrese la actividad',
                        counterText: '255 caracteres',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),
                //Third Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextFormField(
                    validator: (value) {
                      if(value.isEmpty){
                        return "Ingresa un valor en Avance";
                      } else {
                        return null;
                      }
                    },
                    controller: progressController,
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      debugPrint('Progress');
                      updateProgress();
                    },
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.access_time,
                          color: Colors.blueAccent,
                        ),
                        labelText: 'Avance',
                        labelStyle: textStyle,
                        helperText: 'Ingrese el avance sin (%)',
                        counterText: 'De 1 a 100 %',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),
                //Fourth Element
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 170.0,
                        child: RaisedButton(
                          color: Colors.pink,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)
                          ),
                          padding: EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                              right: 1.0,
                              left: 1.0
                          ),
                          child: Text(
                            'GUARDAR',
                            textScaleFactor: 1.2,
                            style: GoogleFonts.kanit(),
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint('Save button pressed');
                              _save();
                            });
                            _submitForm();
                          },
                        ),
                      ),

                      Spacer(),

                      Container(
                        width: 170.0,
                        child: RaisedButton(
                          color: Colors.pink,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)
                          ),
                          padding: EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                              right: 1.0,
                              left: 1.0
                          ),
                          child: Text(
                            'BORRAR',
                            textScaleFactor: 1.2,
                            style: GoogleFonts.kanit(),
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint('Delete button pressed');
                              _delete();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.pink,
                    padding: EdgeInsets.only(
                      right: 15.0,
                      left: 15.0
                    ),
                    child: Text(
                        "Desarrollado por Esteban Navia P. | Version 1.0",
                        textScaleFactor: 1.1,
                        style: GoogleFonts.kanit(
                          color: Colors.white
                        )
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updateApto() {
    data.apto = aptoController.text;
  }

  void updateActivity() {
    data.activity = activityController.text;
  }

  void updateProgress() {
    data.progress = int.parse(progressController.text);
  }

  void _save() async {

    moveToLastScreen();
    data.date = DateFormat.yMd().add_Hms().format(DateTime.now());

    int result;
    if(data.id != null) { //update
      await helper.updateData(data);
    } else { //create
      if(data.apto == '' || data.activity == '' || data.progress < 0 || data.progress > 100){
        _showAlertDialog('Error', 'Hubo un problema al guardar los datos');
      } else {
        await helper.insertData(data);
        if(result != 0){
          _showAlertDialog('Anuncio', 'Datos guardados correctamente');
        } else {
          _showAlertDialog('Error', 'Hubo un problema al guardar los datos');
        }
      }
    }

  }

  void _delete() async {
    moveToLastScreen();

    if(data.id == null) {
      _showAlertDialog('Error', 'No se encontraron los datos');
      return;
    }

    int result = await helper.deleteData(data.id);
    if(result != 0){
      _showAlertDialog('Anuncio', 'Datos eliminados correctamente');
    } else {
      _showAlertDialog('Error', 'Hubo un problema al eliminar los datos');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(
          message,
          style: TextStyle(
              color: Colors.white
          )
      ),
      backgroundColor: Colors.blue[800],
    );
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}

