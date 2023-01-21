class AttendanceInfo {
  String? _date;
  String? _inTime;
  String? _outTime;
  String? _punchInNote;
  String? _punchInIp;
  String? _punchInLocation;
  String? _punchOutNote;
  String? _pinchOutIp;
  String? _punchOutLocation;

  AttendanceInfo(
      {String? date,
        String? inTime,
        String? outTime,
        String? punchInNote,
        String? punchInIp,
        String? punchInLocation,
        String? punchOutNote,
        String? punchOutIp,
        String? punchOutLocation}) {
    if (date != null) {
      this._date = date;
    }
    if (inTime != null) {
      this._inTime = inTime;
    }
    if (outTime != null) {
      this._outTime = outTime;
    }
    if (punchInNote != null) {
      this._punchInNote = punchInNote;
    }
    if (punchInIp != null) {
      this._punchInIp = punchInIp;
    }
    if (punchInLocation != null) {
      this._punchInLocation = punchInLocation;
    }
    if (punchOutNote != null) {
      this._punchOutNote = punchOutNote;
    }
    if (punchOutIp != null) {
      this._pinchOutIp = punchOutIp;
    }
    if (punchOutLocation != null) {
      this._punchOutLocation = punchOutLocation;
    }
  }

  String? get date => _date;
  set date(String? date) => _date = date;
  String? get inTime => _inTime;
  set inTime(String? inTime) => _inTime = inTime;
  String? get outTime => _outTime;
  set outTime(String? outTime) => _outTime = outTime;
  String? get punchInNote => _punchInNote;
  set punchInNote(String? punchInNote) => _punchInNote = punchInNote;
  String? get punchInIp => _punchInIp;
  set punchInIp(String? punchInIp) => _punchInIp = punchInIp;
  String? get punchInLocation => _punchInLocation;
  set punchInLocation(String? punchInLocation) =>
      _punchInLocation = punchInLocation;
  String? get punchOutNote => _punchOutNote;
  set punchOutNote(String? punchOutNote) => _punchOutNote = punchOutNote;
  String? get pinchOutIp => _pinchOutIp;
  set pinchOutIp(String? pinchOutIp) => _pinchOutIp = pinchOutIp;
  String? get punchOutLocation => _punchOutLocation;
  set punchOutLocation(String? punchOutLocation) =>
      _punchOutLocation = punchOutLocation;

  AttendanceInfo.fromJson(Map<String, dynamic> json) {
    _date = json['date'];
    _inTime = json['in_time'];
    _outTime = json['out_time'];
    _punchInNote = json['punch_in_note'];
    _punchInIp = json['punch_in_ip'];
    _punchInLocation = json['punch_in_location'];
    _punchOutNote = json['punch_out_note'];
    _pinchOutIp = json['pinch_out_ip'];
    _punchOutLocation = json['punch_out_location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this._date;
    data['in_time'] = this._inTime;
    data['out_time'] = this._outTime;
    data['punch_in_note'] = this._punchInNote;
    data['punch_in_ip'] = this._punchInIp;
    data['punch_in_location'] = this._punchInLocation;
    data['punch_out_note'] = this._punchOutNote;
    data['pinch_out_ip'] = this._pinchOutIp;
    data['punch_out_location'] = this._punchOutLocation;
    return data;
  }
}
