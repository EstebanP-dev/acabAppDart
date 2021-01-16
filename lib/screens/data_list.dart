import 'dart:async';
import 'package:flutter/material.dart';
import 'package:acab_app/models/Data.dart';
import 'package:acab_app/database/data.database.dart';
import 'package:acab_app/screens/data_datail.dart';
import 'package:sqflite/sqflite.dart';
import 'package:google_fonts/google_fonts.dart';

class DataList extends StatefulWidget {

  final String title;

  DataList(this.title);

@override
  State<StatefulWidget> createState() {
  return DataListState(this.title);
  }
}

class DataListState extends State<DataList> {

  final String title;

  DataListState(this.title);

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Data> datalist;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (datalist == null) {
      // ignore: deprecated_member_use
      datalist = List<Data>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title.toUpperCase(),
            style: GoogleFonts.kanit()
        ),
      ),
      body: getDataListView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: () {
          navigationToDetail(Data('', 1, '', ''), 'Agregar Dato');
        },
        child: Icon(Icons.add),
      )
    );
  }

  ListView getDataListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Padding(
          padding: EdgeInsets.only(
            top: 2.0
          ),
          child: Card(
            shadowColor: Colors.pinkAccent,
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/aptos2.jpg'),
              ),
              title: Text(
                this.datalist[position].apto.toUpperCase(),
                style: GoogleFonts.oxygen(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text(
                "  Avance: " + this.datalist[position].progress.toString() + "%\n  Creación: " + this.datalist[position].date,
              ),
              trailing: GestureDetector(
                child: Icon(Icons.delete, color: Colors.blueAccent,),
                onTap: () {
                  _delete(context, datalist[position]);
                },
              ),
              onTap: () {
                debugPrint("Pressed info data");
                navigationToDetail(this.datalist[position], 'Editar Dato');
              },
            ),
          )
        );
      },
    );
  }

  //Progress Color

  //Delete function
  void _delete(BuildContext context, Data data) async {
    int result = await databaseHelper.deleteData(data.id);
    if (result != 0) {
      _showSnackBar(context, 'Dato eliminado correctamente');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
          message,
        style: TextStyle(
          color: Colors.white
        ),
      ),
      backgroundColor: Colors.blue[800],
    );
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigationToDetail(Data data, String title) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) {
      return DataDetail(data, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Data>> dataListFuture = databaseHelper.getDataList();
      dataListFuture.then((dataList) {
        setState(() {
          this.datalist = dataList;
          this.count = dataList.length;
        });
      });
    });
  }
}
