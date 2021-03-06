import 'dart:async';

import 'package:qrreaderapp/src/bloc/validator.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScansBloc with Validators{

  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc(){
    return _singleton;
  }

  ScansBloc._internal(){
    getScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStreamGeo  => _scansController.stream.transform(validateGeo);
  Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(validateHttp);

  dispose() {
    _scansController.close();
  }

  addScan(ScanModel scan) async{
    await DBProvider.db.insert(scan);
    getScans();
  }

  getScans() async {
    _scansController.sink.add(await DBProvider.db.getAllScan());
  }

  removeScan(int id) async {
    await DBProvider.db.delete(id);
    getScans();
  }

  removeAllScans() async {
    await DBProvider.db.deleteAll();
    getScans();
  }

}