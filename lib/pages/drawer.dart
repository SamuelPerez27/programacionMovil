import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:proyectofinal/pages/home_inicio_comics.dart';
import 'package:proyectofinal/pages/home_inicio_personajes.dart';
import 'package:proyectofinal/pages/home_inicio_creador_Comics.dart';
import 'package:proyectofinal/pages/home_page_inicio.dart';
import 'package:proyectofinal/pages/home_inicio_series.dart';
import 'package:proyectofinal/pages/home_inicio_stories.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(Icons.person, size: 50, color: Colors.blue),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                getUserEmail(),
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 50),
          MenuItem(
            iconPath: 'assets/images/man_1.png',
            label: 'Personajes',
            routeBuilder: () => HomeInicioPersonajes(),
          ),
          SizedBox(height: 22),
          MenuItem(
            iconPath: 'assets/images/comic_book_1.png',
            label: 'Comics',
            routeBuilder: () => HomeInicioComics(),
          ),
          SizedBox(height: 22),
          MenuItem(
            iconPath: 'assets/images/comic_book_11.png',
            label: 'Creadores de Comics',
            routeBuilder: () => HomeInicioCreadores(),
          ),
          SizedBox(height: 22),
          MenuItem(
            iconPath: 'assets/images/series_1.png',
            label: 'Series',
            routeBuilder: () => HomeInicioSeries(),
          ),
          SizedBox(height: 22),
          MenuItem(
            iconPath: 'assets/images/parchment_1.png',
            label: 'Historias',
            routeBuilder: () => HomeInicioHistorias(),
          ),
          Spacer(),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: Size(
                  double.infinity, 45), // Ajusta el ancho y alto del botón aquí
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePageInicio()),
              );
            },
            icon: Image.asset(
              'assets/images/logout_1.png',
              width: 24, // Ajusta el ancho de la imagen según sea necesario
              height: 24, // Ajusta la altura de la imagen según sea necesario
            ),
            label: Text(
              'Log Out',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text('Version 1.0'),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData? icon;
  final String? iconPath;
  final String label;
  final Widget Function() routeBuilder;

  MenuItem(
      {this.icon,
      this.iconPath,
      required this.label,
      required this.routeBuilder});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: iconPath != null
          ? Image.asset(
              iconPath!,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            )
          : Icon(
              icon,
              size: 40,
              color: Colors.black,
            ),
      title: Text(
        label,
        style: TextStyle(fontSize: 20),
      ),
      onTap: () {
        // Maneja la navegación aquí
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => routeBuilder()),
        );
      },
    );
  }
}

// Metodos
String getUserEmail() {
  var box = Hive.box('userData');
  return box.get('email', defaultValue: '');
}
