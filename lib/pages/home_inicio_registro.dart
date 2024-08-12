import 'package:flutter/material.dart';
import 'home_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePageRegistro extends StatelessWidget {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatController = TextEditingController();

  /// Método para verificar si los campos están completos.
  bool verificarInformacion(BuildContext context) {
    if (userController.text.isEmpty ||
        passwordController.text.isEmpty ||
        repeatController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, complete todos los campos'),
          duration: Duration(seconds: 3),
        ),
      );
      return false;
    }
    return true;
  }

  Future<void> registerUser() async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userController.text,
        password: passwordController.text,
      );

      // Obtén el UID del usuario autenticado
      final uid = userCredential.user?.uid;
      if (uid != null) {
        final firestore = FirebaseFirestore.instance;

        // Crea un nuevo documento en la colección 'users' con el UID del usuario
        await firestore.collection('users').doc(uid).set({
          'email': userController.text,
          'displayName': userController.text,
          'createdAt': Timestamp.now(), // Guarda la fecha y hora de creación
        });

        print('User data saved successfully');
      }
    } catch (e) {
      print('Error registering user: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              width: 360,
              height: 800,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Color(0xFFE5E5E5)),
              child: Stack(
                children: [
                  Positioned(
                    left: -42,
                    top: -106,
                    child: Container(
                      width: 443,
                      height: 495,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 443,
                              height: 495,
                              decoration: ShapeDecoration(
                                color: Color(0xFFD9D9D9),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 42.14,
                            top: 77.82,
                            child: Container(
                              width: 370.02,
                              height: 355.58,
                              decoration: ShapeDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(0.01, -1.00),
                                  end: Alignment(-0.01, 1),
                                  colors: [
                                    Color(0x001B1A23),
                                    Color(0xFF020202)
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 1)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 262,
                    child: Container(
                      width: 319,
                      height: 520,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 36,
                    top: 354,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '  !Crea una nueva cuenta!',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                    left: 58,
                    top: 400,
                    child: Container(
                      width: 245,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Usuario',
                            style: TextStyle(
                              color: Color(0xFFCCCCCC),
                              fontSize: 18,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 5),
                          TextField(
                            controller: userController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              fillColor: Color(0xFFF2F2F2),
                              filled: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 58,
                    top: 505,
                    child: Container(
                      width: 245,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contraseña',
                            style: TextStyle(
                              color: Color(0xFFCCCCCC),
                              fontSize: 18,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 5),
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              fillColor: Color(0xFFF2F2F2),
                              filled: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 58,
                    top: 605,
                    child: Container(
                      width: 245,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Repetir contraseña',
                            style: TextStyle(
                              color: Color(0xFFCCCCCC),
                              fontSize: 18,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 5),
                          TextField(
                            controller: repeatController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              fillColor: Color(0xFFF2F2F2),
                              filled: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 36,
                    top: 290,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePageLogin()),
                        );
                      },
                      child: Container(
                        width: 154,
                        height: 37,
                        decoration: ShapeDecoration(
                          color: Color(0xFFE5E5E5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 150,
                    top: 290,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 178,
                        height: 37,
                        decoration: ShapeDecoration(
                          color: Color(0xFFBD1F1F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Registrarse',
                            style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 14,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 36,
                    top: 730,
                    child: GestureDetector(
                      onTap: () async {
                        if (verificarInformacion(context)) {
                          await registerUser();

                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     content: Text(
                          //         'Se registro el usuario de manera correcta'),
                          //     duration: Duration(seconds: 3),
                          //   ),
                          // );

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => HomePageLogin()),
                          // );
                        }
                      },
                      child: Container(
                        width: 288,
                        height: 39,
                        decoration: ShapeDecoration(
                          color: Color(0xFFBD1F1F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Registrarse',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
