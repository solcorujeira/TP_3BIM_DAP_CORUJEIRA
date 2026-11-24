
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'bienvenida.dart';

class PerfilUsuario extends StatefulWidget {
  const PerfilUsuario({super.key});

  @override
  State<PerfilUsuario> createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _contrasenaActualController =
      TextEditingController();
  final TextEditingController _contrasenaNuevaController =
      TextEditingController();

  bool _cargando = true;
  bool _guardando = false;
  bool _cambiandoContrasena = false;
  bool _mostrarBloqueContrasena = false;

  User? get usuario => FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _cargarPerfil();
  }

  Future<void> _cargarPerfil() async {
    final user = usuario;

    if (user == null) {
      setState(() {
        _cargando = false;
      });
      return;
    }

    _emailController.text = user.email ?? '';
    _nombreController.text = user.displayName ?? '';

    try {
      final documento =
          await _db.collection('usuarios').doc(user.email).get();

      if (documento.exists) {
        final datos = documento.data() ?? {};

        _nombreController.text =
            datos['nombre']?.toString() ?? user.displayName ?? '';
        _apellidoController.text = datos['apellido']?.toString() ?? '';
        _dniController.text = datos['dni']?.toString() ?? '';
        _telefonoController.text = datos['telefono']?.toString() ?? '';
      }
    } catch (_) {
      if (mounted) {
        _mostrarMensaje('No se pudieron cargar los datos de Firestore.');
      }
    }

    if (!mounted) return;

    setState(() {
      _cargando = false;
    });
  }

  Future<void> _guardarPerfil() async {
    final user = usuario;

    if (user == null) {
      _mostrarMensaje('No hay un usuario iniciado.');
      return;
    }

    if (_nombreController.text.trim().isEmpty) {
      _mostrarMensaje('El nombre no puede estar vacío.');
      return;
    }

    setState(() {
      _guardando = true;
    });

    try {
      final nombre = _nombreController.text.trim();

      await _db.collection('usuarios').doc(user.email).set({
        'email': user.email,
        'nombre': nombre,
        'apellido': _apellidoController.text.trim(),
        'dni': _dniController.text.trim(),
        'telefono': _telefonoController.text.trim(),
      }, SetOptions(merge: true));

      await user.updateDisplayName(nombre);

      if (!mounted) return;

      _mostrarMensaje('Perfil guardado correctamente.');
    } catch (_) {
      if (!mounted) return;

      _mostrarMensaje('No se pudieron guardar los datos.');
    } finally {
      if (mounted) {
        setState(() {
          _guardando = false;
        });
      }
    }
  }

  Future<void> _cambiarContrasena() async {
    final user = usuario;

    if (user == null || user.email == null) {
      _mostrarMensaje('No hay un usuario iniciado.');
      return;
    }

    final actual = _contrasenaActualController.text;
    final nueva = _contrasenaNuevaController.text;

    if (actual.isEmpty || nueva.isEmpty) {
      _mostrarMensaje('Completá ambas contraseñas.');
      return;
    }

    if (nueva.length < 6) {
      _mostrarMensaje(
        'La nueva contraseña debe tener al menos 6 caracteres.',
      );
      return;
    }

    setState(() {
      _cambiandoContrasena = true;
    });

    try {
      final credencial = EmailAuthProvider.credential(
        email: user.email!,
        password: actual,
      );

      await user.reauthenticateWithCredential(credencial);
      await user.updatePassword(nueva);

      _contrasenaActualController.clear();
      _contrasenaNuevaController.clear();

      if (!mounted) return;

      setState(() {
        _mostrarBloqueContrasena = false;
      });

      _mostrarMensaje('Contraseña actualizada correctamente.');
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      if (e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        _mostrarMensaje('La contraseña actual es incorrecta.');
      } else if (e.code == 'weak-password') {
        _mostrarMensaje('La nueva contraseña es demasiado débil.');
      } else if (e.code == 'requires-recent-login') {
        _mostrarMensaje(
          'Volvé a iniciar sesión para cambiar la contraseña.',
        );
      } else {
        _mostrarMensaje('Error al cambiar la contraseña: ${e.message}');
      }
    } catch (_) {
      if (mounted) {
        _mostrarMensaje('No se pudo cambiar la contraseña.');
      }
    } finally {
      if (mounted) {
        setState(() {
          _cambiandoContrasena = false;
        });
      }
    }
  }

  Future<void> _cerrarSesion() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Cerrar sesión',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          '¿Querés cerrar tu sesión?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Cerrar sesión',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );

    if (confirmar != true) return;

    await FirebaseAuth.instance.signOut();

    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (context) => const Bienvenida(),
      ),
      (route) => false,
    );
  }

  void _mostrarMensaje(String mensaje) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje)),
    );
  }

  Widget _campo({
    required String etiqueta,
    required TextEditingController controller,
    TextInputType tipo = TextInputType.text,
    bool soloLectura = false,
    bool oculto = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: tipo,
        readOnly: soloLectura,
        obscureText: oculto,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: etiqueta,
          labelStyle: const TextStyle(color: Colors.white70),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blueGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
          filled: true,
          fillColor: Colors.grey[900],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nombreController.dispose();
    _apellidoController.dispose();
    _dniController.dispose();
    _telefonoController.dispose();
    _contrasenaActualController.dispose();
    _contrasenaNuevaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = usuario;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        title: const Text('Mi perfil'),
      ),
      body: _cargando
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blueGrey,
              ),
            )
          : user == null
              ? const Center(
                  child: Text(
                    'No hay un usuario iniciado.',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : SafeArea(
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      const Icon(
                        Icons.account_circle,
                        color: Colors.blueGrey,
                        size: 90,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Datos personales',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _campo(
                        etiqueta: 'Gmail de la cuenta',
                        controller: _emailController,
                        soloLectura: true,
                        tipo: TextInputType.emailAddress,
                      ),
                      _campo(
                        etiqueta: 'Nombre',
                        controller: _nombreController,
                      ),
                      _campo(
                        etiqueta: 'Apellido',
                        controller: _apellidoController,
                      ),
                      _campo(
                        etiqueta: 'DNI',
                        controller: _dniController,
                        tipo: TextInputType.number,
                      ),
                      _campo(
                        etiqueta: 'Teléfono',
                        controller: _telefonoController,
                        tipo: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _guardando ? null : _guardarPerfil,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                            foregroundColor: Colors.white,
                          ),
                          child: _guardando
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text('Guardar cambios'),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Divider(color: Colors.blueGrey),
                      const SizedBox(height: 16),
                      if (!_mostrarBloqueContrasena)
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _mostrarBloqueContrasena = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Cambiar contraseña'),
                          ),
                        ),
                      if (_mostrarBloqueContrasena)
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.blueGrey),
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Cambiar contraseña',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 18),
                              _campo(
                                etiqueta: 'Contraseña actual',
                                controller:
                                    _contrasenaActualController,
                                oculto: true,
                              ),
                              _campo(
                                etiqueta: 'Nueva contraseña',
                                controller:
                                    _contrasenaNuevaController,
                                oculto: true,
                              ),
                              SizedBox(
                                height: 46,
                                child: ElevatedButton(
                                  onPressed: _cambiandoContrasena
                                      ? null
                                      : _cambiarContrasena,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueGrey,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: _cambiandoContrasena
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text('Confirmar cambio'),
                                ),
                              ),
                              const SizedBox(height: 10),
                              OutlinedButton(
                                onPressed: _cambiandoContrasena
                                    ? null
                                    : () {
                                        setState(() {
                                          _mostrarBloqueContrasena =
                                              false;
                                        });

                                        _contrasenaActualController
                                            .clear();
                                        _contrasenaNuevaController
                                            .clear();
                                      },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white70,
                                  side: const BorderSide(
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                child: const Text('Cancelar'),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _cerrarSesion,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Cerrar sesión'),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
