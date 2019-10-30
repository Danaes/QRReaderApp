import 'package:flutter/material.dart';

import 'package:qrreaderapp/src/pages/mapas_page.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _callPage(currentPage),
      bottomNavigationBar: _bottomNavigationBar(),
    );
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