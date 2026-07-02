import 'package:flutter/material.dart';
import 'package:tp_2bim/modelos/animal.dart';
import 'package:tp_2bim/pantallas/detalle.dart';

class Lista extends StatelessWidget {
  const Lista({super.key});

  @override
  Widget build(BuildContext context) {

    List<Animal> animales = [

      Animal(
        nombre: "León",
        imagen:
            "https://upload.wikimedia.org/wikipedia/commons/7/73/Lion_waiting_in_Namibia.jpg",
        descripcion:
            "El león es un felino que vive en África y se caracteriza por su melena.",
        peligro: "Vulnerable",
        especimenes: 23000,
      ),

      Animal(
        nombre: "Tigre",
        imagen:
            "https://upload.wikimedia.org/wikipedia/commons/5/56/Tiger.50.jpg",
        descripcion:
            "Es el felino más grande del mundo y un excelente cazador.",
        peligro: "En peligro",
        especimenes: 3900,
      ),

      Animal(
        nombre: "Elefante",
        imagen:
            "https://upload.wikimedia.org/wikipedia/commons/3/37/African_Bush_Elephant.jpg",
        descripcion:
            "Es el mamífero terrestre más grande del planeta.",
        peligro: "En peligro",
        especimenes: 415000,
      ),

      Animal(
        nombre: "Panda",
        imagen:
            "https://upload.wikimedia.org/wikipedia/commons/0/0f/Grosser_Panda.JPG",
        descripcion:
            "Habita en China y se alimenta principalmente de bambú.",
        peligro: "Vulnerable",
        especimenes: 1864,
      ),

    ];

    return Scaffold(

      appBar: AppBar(
        title: const Text("Lista de animales"),
        centerTitle: true,
      ),

      body: ListView.builder(

        itemCount: animales.length,

        itemBuilder: (context, index) {

          Animal animal = animales[index];

          return Card(

            margin: const EdgeInsets.all(10),

            child: ListTile(

              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  animal.imagen,
                ),
              ),

              title: Text(
                animal.nombre,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              trailing: const Icon(Icons.arrow_forward_ios),

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) => Detalle(
                      animal: animal,
                    ),

                  ),

                );

              },

            ),

          );

        },

      ),

    );
  }
}