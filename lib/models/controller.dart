import 'package:acab_app/models/excel.form.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class FormController { //"https://script.google.com/macros/s/AKfycbz0SXhAQqwQpHugm2sLgSbzF7HCyFMhv1JlI1UUTGyXE9Vc7sQO/exec"
  final void Function(String) callback;
  static const String URL = "https://script.google.com/macros/s/AKfycbyqYEWO7deink0zPdamX__WAIv2D7H9VDSqx6uddr4DBUvSYbHXm8NtEQ/exec";
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