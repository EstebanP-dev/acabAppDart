class ExcelForm {
  String _apto;
  String _activity;
  String _progress;
  String _date;

  ExcelForm(this._apto, this._activity, this._progress, this._date);

  String toParams() => "?apto=$_apto&activity=$_activity&progress=$_progress&date=$_date";
}