import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  MapController map = new MapController();
  String mapType = 'streets';

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.my_location),
            onPressed: (){
              map.move(scan.getLatLng(), 15);
            },
          )
        ],
      ),
      body: _createFlutterMap(scan),
      floatingActionButton: _createFloatingActionButton(context),
    );
  }

  Widget _createFlutterMap(ScanModel scan) {

    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 10
      ),
      layers: [
        _createMap(),
        _createMarks(context, scan)
      ],
    );

  }

  TileLayerOptions _createMap() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1IjoiZGFuYWVzIiwiYSI6ImNrNXh0ZTNnYjA1a2QzbG5vYTd5N3hjM2UifQ.oThenMvqNCjObbjK4N4now',
        'id': 'mapbox.$mapType' //streets, dark, light, outdoors, satellite
      }
    );
  }

  MarkerLayerOptions _createMarks(BuildContext context, ScanModel scan) {
    return MarkerLayerOptions(
      markers: <Marker> [
        Marker(
          width: 100.0, height: 100.0, point: scan.getLatLng(),
          builder: (context) => Container(
            child: Icon(Icons.location_on, size: 45.0, color: Theme.of(context).primaryColor),
          )
        )
      ]
    );
  }

  FloatingActionButton _createFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){

        switch(mapType){
          case 'streets': mapType = 'dark'; break;
          case 'dark': mapType = 'light'; break;
          case 'light': mapType = 'outdoors'; break;
          case 'outdoors': mapType = 'satellite'; break;
          case 'satellite': mapType = 'streets';
        }

        setState(() {});

      },
    );
  }
}