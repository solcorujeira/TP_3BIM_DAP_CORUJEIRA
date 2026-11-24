import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tp_2bim/modelos/animal.dart';
import 'package:tp_2bim/providers/animal_provider.dart';
import 'package:tp_2bim/pantallas/formulario_animal.dart';

class DetalleAnimal extends ConsumerWidget {
  final Animal animal;
  final String idDoc; // ID del documento en Firestore

  const DetalleAnimal({
    super.key,
    required this.animal,
    required this.idDoc,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        title: Text(animal.nombre),
        actions: [
          // Botón para Editar
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormularioAnimal(
                    animal: animal,
                    idDoc: idDoc,
                  ),
                ),
              );
            },
          ),
          // Botón para Eliminar
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              // Diálogo de confirmación opcional pero recomendado
              final confirmar = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.blueGrey.shade900,
                  title: const Text(
                    "Eliminar animal",
                    style: TextStyle(color: Colors.white),
                  ),
                  content: Text(
                    "¿Estás seguro de que querés eliminar a ${animal.nombre}?",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("Cancelar",
                          style: TextStyle(color: Colors.white70)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text("Eliminar",
                          style: TextStyle(color: Colors.redAccent)),
                    ),
                  ],
                ),
              );

              if (confirmar == true) {
                try {
                  // Usamos el animalServiceProvider en lugar de .notifier
                  await ref.read(animalServiceProvider).eliminar(idDoc);

                  if (context.mounted) {
                    Navigator.pop(context); // Volver a la pantalla anterior
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Error al eliminar: $e"),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                }
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del animal
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                animal.imagen,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 250,
                  color: Colors.blueGrey.shade900,
                  child: const Center(
                    child: Icon(Icons.broken_image,
                        size: 50, color: Colors.white54),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              animal.nombre,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  "Estado de conservación: ",
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  animal.peligro,
                  style: const TextStyle(color: Colors.amberAccent),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  "Especímenes estimados: ",
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  animal.especimenes.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Descripción",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              animal.descripcion,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}