
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final TextEditingController nombreController =
      TextEditingController();

  final TextEditingController mailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  final TextEditingController confirmarPasswordController =
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

  Future<void> registrarse() async {
    final nombre = nombreController.text.trim();
    final mail = mailController.text.trim();
    final password = passwordController.text;
    final confirmarPassword =
        confirmarPasswordController.text;

    if (nombre.isEmpty ||
        mail.isEmpty ||
        password.isEmpty ||
        confirmarPassword.isEmpty) {
      mostrarMensaje('Complete todos los campos');
      return;
    }

    final emailValido = RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    ).hasMatch(mail);

    if (!emailValido) {
      mostrarMensaje('Ingrese un email válido');
      return;
    }

    if (password != confirmarPassword) {
      mostrarMensaje('Las contraseñas no coinciden');
      return;
    }

    if (password.length < 6) {
      mostrarMensaje(
        'La contraseña debe tener al menos 6 caracteres',
      );
      return;
    }

    setState(() {
      cargando = true;
    });

    try {
      final credencial = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );

      await credencial.user!.updateDisplayName(nombre);

      // AuthGate detecta automáticamente el nuevo usuario
      // y muestra la pantalla Lista.

    } on FirebaseAuthException catch (e) {
      String mensaje;

      switch (e.code) {
        case 'email-already-in-use':
          mensaje = 'Este email ya está registrado';
          break;

        case 'invalid-email':
          mensaje = 'El email no es válido';
          break;

        case 'weak-password':
          mensaje = 'La contraseña es demasiado débil';
          break;

        case 'operation-not-allowed':
          mensaje = 'El registro por email está deshabilitado';
          break;

        case 'network-request-failed':
          mensaje = 'Error de conexión. Verifique internet';
          break;

        case 'too-many-requests':
          mensaje = 'Demasiados intentos. Intente más tarde';
          break;

        default:
          mensaje =
              'No se pudo completar el registro: ${e.message ?? e.code}';
      }

      if (mounted) {
        mostrarMensaje(mensaje);
      }
    } catch (e) {
      if (mounted) {
        mostrarMensaje(
          'Ocurrió un error al registrar el usuario',
        );
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
    nombreController.dispose();
    mailController.dispose();
    passwordController.dispose();
    confirmarPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Registro'),
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
                'Nombre',
                nombreController,
                'Ingrese su nombre',
              ),
              const SizedBox(height: 12),

              campo(
                'Email',
                mailController,
                'Ingrese su email',
                tipo: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),

              campo(
                'Contraseña',
                passwordController,
                'Ingrese su contraseña',
                ocultar: true,
              ),
              const SizedBox(height: 12),

              campo(
                'Confirmar contraseña',
                confirmarPasswordController,
                'Repita su contraseña',
                ocultar: true,
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: cargando ? null : registrarse,
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
                        'Registrarse',
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
