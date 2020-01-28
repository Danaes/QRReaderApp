import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.my_location),
            onPressed: (){},
          )
        ],
      ),
      body: _createFlutterMap(scan)
    );
  }

  Widget _createFlutterMap(ScanModel scan) {

    return FlutterMap(
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 10
      ),
      layers: [
        _createMap()
      ],
    );

  }

  TileLayerOptions _createMap() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1IjoiZGFuYWVzIiwiYSI6ImNrNXh0ZTNnYjA1a2QzbG5vYTd5N3hjM2UifQ.oThenMvqNCjObbjK4N4now',
        'id': 'mapbox.streets'
      }
    );
  }
}