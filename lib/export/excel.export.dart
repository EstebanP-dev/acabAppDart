import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class ExcelFile {
  // ByteData data = await rootBundle.load("assets/zanettiDatos.xlsx");

  // var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  // var excel = Excel.decodeBytes(bytes);

  void _add(bytes, excel, [apto, activity, progress, date]) async {
    Sheet sheetObject = excel['zanettiDatos'];

    sheetObject.appendRow([apto, activity, progress, date]);
  }

  void _saveExcel(excel, directory) {
    excel.encode().then((onValue) {
      File(join(directory))
        ..createSync(recursive: true)
        ..writeAsBytesSync(onValue);
    });
  }
}
