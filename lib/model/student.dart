class Student {
  int _id;
  String _names;
  String _codigo;
  String _apepaterno;
  String _apematerno;
  String _dni;


  Student(this._names, this._codigo, this._apepaterno, this._apematerno, this._dni);
  Student.withId(this._id, this._names, this._codigo, this._apepaterno, this._apematerno, this._dni);

  int get id => _id;
  String get names => _names;
  String get codigo => _codigo;
  String get apepaterno => _apepaterno;
  String get apematerno => _apematerno;
  String get dni => _dni;

  set names (String names) {    
      _names = names;
  }

  set codigo (String codigo) {    
      _codigo = codigo;
  }

  set apepaterno (String apepaterno) {
      _apepaterno = apepaterno;
  }

  set apematerno (String apematerno) {
      _apematerno = apematerno;
  }

   set dni (String dni) {
      _dni = dni;
  }
}
