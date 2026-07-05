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
  imagen: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbZ1j8BSAzLYKqY2BIeE8Z2D3n1g7qn8sOxwp8Wd3GlUPGbafHzrohdEE8YQPfGlzrPCurj4zTBfngPVq3tqKyzwomPPGNdaMNLl2Q5Q&s=10",
  descripcion:
      "Es el felino más grande de América y habita en la Selva Misionera y el Gran Chaco.",
  peligro: "En peligro crítico",
  especimenes: 250,
),

Animal(
  nombre: "Cóndor Andino",
  imagen: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0VRSLR57uMgu1TLi0-CPGsDBmnYnA9q7ZH0gAs6VOfQ&s=10",
  descripcion:
      "Ave emblemática de la Cordillera de los Andes y una de las aves voladoras más grandes del mundo.",
  peligro: "Vulnerable",
  especimenes: 6700,
),

Animal(
  nombre: "Puma",
  imagen: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLD5Doa_jzPMwcQhVl8r2rLaXEyAWkF-Mt6KwFgHPoaQ&s=10",
  descripcion:
      "Gran felino que vive en montañas, bosques y estepas de Argentina.",
  peligro: "Preocupación menor",
  especimenes: 50000,
),

Animal(
  nombre: "Guanaco",
  imagen: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRN5ET0yvhAjl-wvf3SpxZg9LQV8570atkAFO32N-APqT6_AgTuSxGNKldq&s=10",
  descripcion:
      "Mamífero típico de la Patagonia y pariente silvestre de la llama.",
  peligro: "Preocupación menor",
  especimenes: 2000000,
),

Animal(
  nombre: "Carpincho",
  imagen: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1mzThObqs5jLF6FcEWDLz5bTQGtfI-5Uyzf4WyLAK7A&s=10",
  descripcion:
      "Es el roedor más grande del mundo y habita en ríos, lagunas y esteros.",
  peligro: "Preocupación menor",
  especimenes: 1000000,
),

Animal(
  nombre: "Tapir",
  imagen: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeTLTgmzJM_jWcojnuRI5G1QNV4X5kF3jTkD3tVruFYg&s=10",
  descripcion:
      "También llamado anta. Vive en las selvas del norte argentino.",
  peligro: "Vulnerable",
  especimenes: 4500,
),

Animal(
  nombre: "Lobito de Río",
  imagen: "https://media.todojujuy.com/p/92ee44b982a4a36cad72a01b0221a01b/adjuntos/227/imagenes/003/238/0003238811/1200x675/smart/lobito-rio.png",
  descripcion:
      "Mamífero acuático que vive en ríos y arroyos del noreste argentino.",
  peligro: "En peligro",
  especimenes: 3000,
),

Animal(
  nombre: "Aguará Guazú",
  imagen: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZUMy35R-4HPorevQ_PrtTBy17MMxAzTCdbcpEVoYw4JzsgGjlcV3-EPk5&s=10",
  descripcion:
      "Es el cánido más grande de Sudamérica. Habita en pastizales y humedales del norte argentino.",
  peligro: "Casi amenazado",
  especimenes: 17000,
),

Animal(
  nombre: "Ñandú",
  imagen: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdqih9c-12mlXfTuyCxgeoZ-5OrF_G-MwR9HUBdq9LQlvfwLmu30mp_XzA&s=10",
  descripcion:
      "Ave corredora típica de las llanuras argentinas.",
  peligro: "Casi amenazado",
  especimenes: 500000,
),

Animal(
  nombre: "Oso Hormiguero Gigante",
  imagen: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2Q7kaGddkyY_RdKZ3hTxbBbHkXpILQGv6O6rbBDkYksxlBfKApAMecdqW&s=10",
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