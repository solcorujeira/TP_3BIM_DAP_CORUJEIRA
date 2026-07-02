import 'package:flutter/material.dart';
import 'package:tp_2bim/modelos/animal.dart';

class Detalle extends StatelessWidget {
  final Animal animal;

  const Detalle({
    super.key,
    required this.animal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animal.nombre),
      ),

      body: Padding(
      padding: const EdgeInsets.all(20),

  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Image.network(
        animal.imagen,
        width: 280,
        height: 280,
        fit: BoxFit.cover,
      ),

      const SizedBox(width: 20),

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              animal.nombre,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Descripción:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              animal.descripcion,
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            Text(
              "Peligro: ${animal.peligro}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 15),

            Text(
              "Especímenes: ${animal.especimenes}",
              style: const TextStyle(fontSize: 18),
            ),

          ],
        ),
      ),
  
    ],
  )
  ),
);
}
}