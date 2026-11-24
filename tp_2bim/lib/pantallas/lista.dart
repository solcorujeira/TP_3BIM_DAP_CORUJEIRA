
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:tp_2bim/modelos/animal.dart';
import 'package:tp_2bim/providers/animal_provider.dart';
import 'package:tp_2bim/pantallas/detalle.dart';
import 'package:tp_2bim/pantallas/formulario_animal.dart';
import 'package:tp_2bim/pantallas/perfil_usuario.dart';

class Lista extends ConsumerWidget {
  const Lista({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animalesAsync = ref.watch(animalProvider);

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text('Animales Argentinos'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,

        actions: [
          // BOTÓN PERFIL
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Mi perfil',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PerfilUsuario(),
                ),
              );
            },
          ),

          // BOTÓN CERRAR SESIÓN
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () async {
              final confirmar = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Cerrar sesión'),
                  content: const Text(
                    '¿Está seguro de que desea cerrar sesión?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text('Cerrar sesión'),
                    ),
                  ],
                ),
              );

              if (confirmar == true) {
                await FirebaseAuth.instance.signOut();

                // AuthGate detecta el cierre de sesión
                // y muestra automáticamente Bienvenida.
              }
            },
          ),
        ],
      ),

      // LISTADO DE ANIMALES
      body: animalesAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),

        error: (error, stackTrace) => Center(
          child: Text(
            'Error al cargar los animales: $error',
            style: const TextStyle(color: Colors.white),
          ),
        ),

        data: (animales) {
          if (animales.isEmpty) {
            return const Center(
              child: Text(
                'Todavía no hay animales registrados',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView.builder(
            itemCount: animales.length,
            itemBuilder: (context, index) {
              final Animal animal = animales[index];

              return Card(
                color: Colors.blueGrey.shade900,
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),

                child: ListTile(
                  leading: Image.network(
                    animal.imagen,
                    width: 65,
                    height: 65,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.image_not_supported,
                        color: Colors.white,
                        size: 40,
                      );
                    },
                  ),

                  title: Text(
                    animal.nombre,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(
                    'Peligro: ${animal.peligro}',
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),

                  onTap: () {
                    if (animal.id == null) {
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetalleAnimal(
                          animal: animal,
                          idDoc: animal.id!,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),

      // BOTÓN AGREGAR ANIMAL
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FormularioAnimal(),
            ),
          );
        },
      ),
    );
  }
}
