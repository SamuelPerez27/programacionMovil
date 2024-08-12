import 'package:flutter/material.dart';
import 'home_inicio_personajes.dart';
import 'home_inicio_registro.dart';
import 'package:hive/hive.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePageLogin extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /// Método para verificar si los campos están completos.
  bool verificarInformacion(BuildContext context) {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
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

  Future<User?> signInWithGoogle() async {
    // Inicia el flujo de autenticación
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtiene los detalles de autenticación del request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Crea una nueva credencial
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Una vez autenticado, devuelve el User
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final user = userCredential.user;

    return userCredential.user;
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
                      height: 507,
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
                    top: 374,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Bienvenido/a a ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 23,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: 'MarvelVerse',
                            style: TextStyle(
                              color: Color(0xFFFF0404),
                              fontSize: 23,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 58,
                    top: 441,
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
                            controller: emailController,
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
                    top: 533,
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
                    left: 150,
                    top: 290,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePageRegistro()),
                        );
                      },
                      child: Container(
                        width: 178,
                        height: 37,
                        decoration: ShapeDecoration(
                          color: Color(0xFFE5E5E5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Registrarse',
                            style: TextStyle(
                              color: Color(0xFF060606),
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
                    left: 85,
                    top: 745,
                    child: Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 36,
                    top: 290,
                    child: GestureDetector(
                      onTap: () {
                        // Acción para el login
                      },
                      child: Container(
                        width: 154,
                        height: 37,
                        decoration: ShapeDecoration(
                          color: Color(0xFFBD1F1F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
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
                    top: 658,
                    child: GestureDetector(
                      onTap: () async {
                        if (verificarInformacion(context)) {
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );

                            final box = await Hive.openBox('userData');
                            await box.put('email', emailController.text);
                            await box.put('password', passwordController.text);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeInicioPersonajes()),
                            );
                          } catch (e) {
                            if (e is FirebaseAuthException) {
                              if (e.code == 'user-not-found') {
                                // Mostrar un mensaje si el usuario no existe
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('El usuario no existe.'),
                                  ),
                                );
                              } else if (e.code == 'wrong-password') {
                                // Mostrar un mensaje si la contraseña es incorrecta
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Contraseña incorrecta.'),
                                  ),
                                );
                              } else {
                                // Otros errores
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Error al iniciar sesión: ${e.message}'),
                                  ),
                                );
                              }
                            }
                          }
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
                            'Login',
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
                  Positioned(
                    left: 36,
                    top: 705,
                    child: GestureDetector(
                      onTap: () async {
                        User? user = await signInWithGoogle();

                        final box = await Hive.openBox('userData');
                        await box.put('email', user?.displayName);
                        await box.put('password', passwordController.text);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeInicioPersonajes()),
                        );
                      },
                      child: Container(
                        width: 290,
                        height: 35,
                        decoration: ShapeDecoration(
                          color: Color(0xffb24904),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/google.png', // Asegúrate de que la ruta sea correcta
                              height: 24, // Tamaño del ícono
                              width: 24, // Tamaño del ícono
                            ),
                            SizedBox(
                                width: 8), // Espacio entre el ícono y el texto
                            Text(
                              'Autenticarte con Google',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
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
