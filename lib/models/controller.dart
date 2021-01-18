import 'package:acab_app/models/excel.form.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class FormController {
  final void Function(String) callback;
  static const String URL = "https://script.google.com/macros/s/AKfycbxXz1VBzSo9sTrGCMglfTwAR6v2oMXYJMR5HyTS3FFjxMDyBXw/exec";
  static const STATUS_SUCCESS = "Success";
  FormController(this.callback);
  Future sumitForm(ExcelForm excelForm) async {
    try{
      await http.get(URL + excelForm.toParams()).then(
              (response){
            callback(convert.jsonDecode(response.body)['status']);
          });
    } catch(e) {
      print(e);
    }
  }
}