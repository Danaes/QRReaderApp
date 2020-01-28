import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:qrreaderapp/src/bloc/scan_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';

import 'package:qrreaderapp/src/pages/mapas_page.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';

import 'package:qrreaderapp/src/utils/utils.dart' as utils;


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.delete_forever ),
            onPressed: scansBloc.removeAllScans,
          )
        ],
      ),
      body: _callPage(currentPage),
      bottomNavigationBar: _bottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: _scanQR,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scanQR () async {

    // https://www.google.es
    // geo:40.77729065096283,-74.18446913203127

    String futureString = 'https://www.google.es';

    /* try {
      futureString = await new QRCodeReader().scan();
    }
    catch (e) {
      futureString = e.toString();
    }*/

    if (futureString != null) {
      final scan = ScanModel(valor: futureString);
      scansBloc.addScan(scan);

      // final scan2 = ScanModel(valor: 'geo:40.77729065096283,-74.18446913203127');
      // scansBloc.addScan(scan2);

      if(Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), () {
          utils.openScan(scan);
        });
      } else {
        utils.openScan(scan);
      }

    }

    
  }

  Widget _callPage( int currentPage) {

    switch (currentPage) {
      case 0: return MapasPage();
      case 1: return DireccionesPage();

      default: return MapasPage();
    }
  }

  Widget _bottomNavigationBar() {

    return BottomNavigationBar(
      currentIndex: this.currentPage,
      onTap: ( index ) {
        setState(() {
          this.currentPage = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones')
        )
      ],
    );
  }
}