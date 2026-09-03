import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tp_2bim/modelos/animal.dart';
import 'package:tp_2bim/providers/animal_provider.dart';
import 'package:tp_2bim/pantallas/detalle.dart';
import 'package:tp_2bim/pantallas/formulario_animal.dart';
import 'package:tp_2bim/pantallas/login.dart';

class Lista extends ConsumerWidget {
  const Lista({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animales = ref.watch(animalesProvider);

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text(
          "Animales",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,

        // AGREGADO: botón cerrar sesión
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Cerrar sesión"),
                    content: const Text(
                      "¿Estás seguro de que querés cerrar sesión?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("No"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text("Sí"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),

      body: animales.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.pets,
                    color: Colors.white54,
                    size: 70,
                  ),

                  SizedBox(height: 15),

                  Text(
                    "No hay animales",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Presioná + para agregar uno",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: animales.length,
              itemBuilder: (context, index) {
                final Animal animal = animales[index];

                return Card(
                  color: Colors.blueGrey.shade900,
                  margin: const EdgeInsets.only(
                    bottom: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),

                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        animal.imagen,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) {
                          return Container(
                            width: 70,
                            height: 70,
                            color: Colors.blueGrey.shade800,
                            child: const Icon(
                              Icons.image_not_supported,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),

                    title: Text(
                      animal.nombre,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: Text(
                        animal.peligro,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ),

                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white54,
                      size: 18,
                    ),

                    onTap: () async {
                      final Animal? animalActualizado =
                          await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Detalle(
                            animal: animal,
                            index: index,
                          ),
                        ),
                      );

                      if (animalActualizado != null) {
                        ref
                            .read(
                              animalesProvider.notifier,
                            )
                            .editar(
                              index,
                              animalActualizado,
                            );
                      }
                    },
                  ),
                );
              },
            ),

      floatingActionButton:
          FloatingActionButton.extended(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,

        icon: const Icon(
          Icons.add,
        ),

        label: const Text(
          "Agregar",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const FormularioAnimal(),
            ),
          );
        },
      ),
    );
  }
}