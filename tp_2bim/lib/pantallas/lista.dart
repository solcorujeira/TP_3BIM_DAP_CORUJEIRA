import 'package:flutter/material.dart';
import 'package:tp_2bim/modelos/animal.dart';
import 'package:tp_2bim/pantallas/detalle.dart';

class Lista extends StatelessWidget {
  const Lista({super.key});

  @override
  Widget build(BuildContext context) {
    List<Animal> animales = [
      Animal(
  nombre: "Yaguareté",
  imagen: "https://upload.wikimedia.org/wikipedia/commons/9/92/Panthera_onca_PyS.jpg",
  descripcion:
      "Es el felino más grande de América y habita en la Selva Misionera y el Gran Chaco.",
  peligro: "En peligro crítico",
  especimenes: 250,
),

Animal(
  nombre: "Cóndor Andino",
  imagen: "https://upload.wikimedia.org/wikipedia/commons/5/5d/Andean_condor.jpg",
  descripcion:
      "Ave emblemática de la Cordillera de los Andes y una de las aves voladoras más grandes del mundo.",
  peligro: "Vulnerable",
  especimenes: 6700,
),

Animal(
  nombre: "Puma",
  imagen: "https://upload.wikimedia.org/wikipedia/commons/e/e0/Puma_concolor.jpg",
  descripcion:
      "Gran felino que vive en montañas, bosques y estepas de Argentina.",
  peligro: "Preocupación menor",
  especimenes: 50000,
),

Animal(
  nombre: "Guanaco",
  imagen: "https://upload.wikimedia.org/wikipedia/commons/0/0f/Guanaco_Patagonia.jpg",
  descripcion:
      "Mamífero típico de la Patagonia y pariente silvestre de la llama.",
  peligro: "Preocupación menor",
  especimenes: 2000000,
),

Animal(
  nombre: "Carpincho",
  imagen: "https://upload.wikimedia.org/wikipedia/commons/b/bf/Capybara_%28Hydrochoerus_hydrochaeris%29.JPG",
  descripcion:
      "Es el roedor más grande del mundo y habita en ríos, lagunas y esteros.",
  peligro: "Preocupación menor",
  especimenes: 1000000,
),

Animal(
  nombre: "Tapir",
  imagen: "https://upload.wikimedia.org/wikipedia/commons/8/88/Tapirus_terrestris.jpg",
  descripcion:
      "También llamado anta. Vive en las selvas del norte argentino.",
  peligro: "Vulnerable",
  especimenes: 4500,
),

Animal(
  nombre: "Lobito de Río",
  imagen: "https://upload.wikimedia.org/wikipedia/commons/7/74/Lontra_longicaudis.jpg",
  descripcion:
      "Mamífero acuático que vive en ríos y arroyos del noreste argentino.",
  peligro: "En peligro",
  especimenes: 3000,
),

Animal(
  nombre: "Aguará Guazú",
  imagen: "https://upload.wikimedia.org/wikipedia/commons/4/45/Maned_wolf-aguara_guazu.jpeg",
  descripcion:
      "Es el cánido más grande de Sudamérica. Habita en pastizales y humedales del norte argentino.",
  peligro: "Casi amenazado",
  especimenes: 17000,
),

Animal(
  nombre: "Ñandú",
  imagen: "https://upload.wikimedia.org/wikipedia/commons/8/8b/Rhea_americana.jpg",
  descripcion:
      "Ave corredora típica de las llanuras argentinas.",
  peligro: "Casi amenazado",
  especimenes: 500000,
),

Animal(
  nombre: "Oso Hormiguero Gigante",
  imagen: "https://upload.wikimedia.org/wikipedia/commons/8/87/Giant_anteater.jpg",
  descripcion:
      "Mamífero que habita en el norte argentino y se alimenta principalmente de hormigas y termitas.",
  peligro: "Vulnerable",
  especimenes: 5000,
),
    ];

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text("Animales de Argentina"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),

      body: ListView.builder(
        itemCount: animales.length,
        itemBuilder: (context, index) {
          Animal animal = animales[index];

          return Card(
            color: Colors.blueGrey.shade900,
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(animal.imagen),
              ),

              title: Text(
                animal.nombre,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Text(
                animal.peligro,
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),

              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),

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