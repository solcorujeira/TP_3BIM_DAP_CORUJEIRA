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
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: Text(animal.nombre),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  animal.imagen,
                  height: 320,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 25),

            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    animal.nombre,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Descripción",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    animal.descripcion,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Estado de conservación",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    animal.peligro,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Número de especímenes",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    animal.especimenes.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}