import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'drawer.dart';
import 'package:proyectofinal/class/apiEndPoints.dart';

class HomeInicioHistorias extends StatefulWidget {
  @override
  _HomeInicioHistoriasState createState() => _HomeInicioHistoriasState();
}

class _HomeInicioHistoriasState extends State<HomeInicioHistorias> {
  late Future<List<dynamic>> futureStories;
  List<dynamic> filteredStories = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureStories = fetchStories();
  }

  Future<List<dynamic>> fetchStories() async {
    final api = ApiEndPoints();
    return await api.fetchHistorys();
  }

  void _filterStories(String query) {
    futureStories.then((stories) {
      setState(() {
        filteredStories = stories
            .where((story) =>
                story['title'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }).catchError((error) {
      print('Error fetching stories: $error');
      setState(() {
        filteredStories = [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Column(
        children: [
          Container(
            width: 360,
            height: 800,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Color(0xFFE5E5E5)),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 782,
                  child: Container(
                    width: 360,
                    height: 18,
                    decoration: BoxDecoration(color: Color(0xFFBD1F1F)),
                  ),
                ),
                Positioned(
                  left: 15,
                  top: 24,
                  child: Container(
                    width: 336,
                    height: 40,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 133,
                          top: 0,
                          child: Text(
                            'MarvelVerse',
                            style: TextStyle(
                              color: Color(0xFFFF0404),
                              fontSize: 13,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 301,
                          top: 3,
                          child: Container(
                            width: 35,
                            height: 33,
                            child: Image.asset(
                              'assets/images/user_1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 9,
                          child: Container(
                            width: 27,
                            height: 22,
                            child: Builder(
                              builder: (context) => GestureDetector(
                                onTap: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                child: Image.asset(
                                  'assets/images/menu_1.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 122,
                          top: 20,
                          child: Text(
                            getUserEmail(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 15,
                  top: 95,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/pow_1.png',
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(width: 18),
                      Text(
                        'Historias',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 15,
                  top: 155,
                  child: Container(
                    width: 336,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/magnifying_glass_11.png',
                          ),
                        ),
                        Expanded(
                            child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            _filterStories(value);
                          },
                          decoration: InputDecoration(
                            hintText: 'Buscar',
                            border: InputBorder.none,
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 5,
                  top: 220,
                  child: Row(
                    children: [
                      SizedBox(width: 18),
                      Text(
                        'Recomendaciones',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 15,
                  top: 255,
                  child: Container(
                    width: 336,
                    height: 520,
                    child: FutureBuilder<List<dynamic>>(
                      future: futureStories,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text('No stories found'));
                        } else {
                          // Mostrar las historias filtradas si hay texto de búsqueda
                          final stories = searchController.text.isEmpty
                              ? snapshot.data!
                              : filteredStories;
                          return ListView.builder(
                            itemCount: stories.length,
                            itemBuilder: (context, index) {
                              final story = stories[index];
                              return StoryCard(
                                title: story['title'],
                                description: story['description'] ??
                                    'No description available',
                                modified: story['modified'],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StoryCard extends StatelessWidget {
  final String title;
  final String description;
  final String modified;

  StoryCard({
    required this.title,
    required this.description,
    required this.modified,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Icon(Icons.access_time, size: 16.0),
                SizedBox(width: 5.0),
                Text('Modificado: $modified'),
                Spacer(),
                Image.asset('assets/images/disseminate_1.png', height: 20.0),
                SizedBox(width: 5.0),
                Image.asset('assets/images/Marvel_logo.png', height: 20.0),
              ],
            ),
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}

// Métodos
String getUserEmail() {
  var box = Hive.box('userData');
  return box.get('email', defaultValue: '');
}
