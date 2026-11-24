import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  bool cargando = false;

  void mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          mensaje,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<void> ingresar() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      mostrarMensaje('Complete todos los campos');
      return;
    }

    final emailValido = RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    ).hasMatch(email);

    if (!emailValido) {
      mostrarMensaje('Ingrese un email válido');
      return;
    }

    setState(() {
      cargando = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Cerramos Login para que AuthGate muestre Lista.
      if (mounted) {
        Navigator.pop(context);
      }

    } on FirebaseAuthException catch (e) {
      String mensaje;

      switch (e.code) {
        case 'user-not-found':
        case 'invalid-credential':
        case 'wrong-password':
          mensaje = 'Email o contraseña incorrectos';
          break;

        case 'invalid-email':
          mensaje = 'El email no es válido';
          break;

        case 'user-disabled':
          mensaje = 'Esta cuenta está deshabilitada';
          break;

        case 'too-many-requests':
          mensaje = 'Demasiados intentos. Intente más tarde';
          break;

        case 'network-request-failed':
          mensaje = 'Error de conexión. Verifique internet';
          break;

        default:
          mensaje = 'No se pudo iniciar sesión: ${e.code}';
      }

      if (mounted) {
        mostrarMensaje(mensaje);
      }

    } catch (e) {
      if (mounted) {
        mostrarMensaje('Ocurrió un error: $e');
      }

    } finally {
      if (mounted) {
        setState(() {
          cargando = false;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              campo(
                'Email',
                emailController,
                'Ingrese su email',
                tipo: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              campo(
                'Contraseña',
                passwordController,
                'Ingrese su contraseña',
                ocultar: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: cargando ? null : ingresar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35,
                    vertical: 12,
                  ),
                ),
                child: cargando
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Ingresar',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget campo(
    String titulo,
    TextEditingController controller,
    String hint, {
    bool ocultar = false,
    TextInputType tipo = TextInputType.text,
  }) {
    return Column(
      children: [
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 220,
          child: TextField(
            controller: controller,
            obscureText: ocultar,
            keyboardType: tipo,
            style: const TextStyle(color: Colors.white),
            decoration: campoDecoracion(hint),
          ),
        ),
      ],
    );
  }

  InputDecoration campoDecoracion(String texto) {
    return InputDecoration(
      hintText: texto,
      hintStyle: const TextStyle(color: Colors.white54),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12,
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueGrey),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blueGrey,
          width: 2,
        ),
      ),
    );
  }
}