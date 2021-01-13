class Data {
  // ignore: unused_field
  int _id;
  // ignore: unused_field
  String _apto;
  // ignore: unused_field
  String _activity;

  // ignore: unused_field
  String _date;

  // ignore: unused_field
  int _progress;


  Data(this._apto, this._progress, this._date, [this._activity]);

  Data.withId(this._id, this._apto, this._progress, this._date,
      [this._activity]);

  int get id => _id;
  String get apto => _apto;
  int get progress => _progress;
  String get activity => _activity;
  String get date => _date;

  set apto(String newApto) {
    if (newApto.length <= 20) {
      this._apto = newApto;
    }
  }

  set activity(String newActivity) {
    if (newActivity.length <= 255) {
      this._activity = newActivity;
    }
  }

  set progress(int newProgress) {
    if (newProgress >= 1 && newProgress <= 100) {
      this._progress = newProgress;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }

    map['apto'] = _apto;
    map['activity'] = _activity;
    map['progress'] = _progress;
    map['date'] = _date;

    return map;
  }

  Data.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._apto = map['apto'];
    this._activity = map['activity'];
    this._progress = map['progress'];
    this._date = map['date'];
  }
}
