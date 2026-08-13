import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tp_2bim/modelos/animal.dart';
import 'package:tp_2bim/providers/animal_provider.dart';
import 'package:tp_2bim/pantallas/formulario_animal.dart';

class Detalle extends ConsumerWidget {
  final Animal animal;
  final int index;

  const Detalle({
    super.key,
    required this.animal,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: Text(
          animal.nombre,
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,

        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
            ),

            onPressed: () {
              showDialog(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    backgroundColor:
                        Colors.blueGrey.shade900,

                    title: const Text(
                      "Eliminar animal",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    content: Text(
                      "¿Querés eliminar a ${animal.nombre}?",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),

                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                            dialogContext,
                          );
                        },

                        child: const Text(
                          "Cancelar",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ),

                      ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),

                        onPressed: () {
                          ref
                              .read(
                                animalesProvider.notifier,
                              )
                              .eliminar(index);

                          Navigator.pop(
                            dialogContext,
                          );

                          Navigator.pop(
                            context,
                          );
                        },

                        child: const Text(
                          "Eliminar",
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Expanded(
                      flex: 2,

                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(12),

                        child: Image.network(
                          animal.imagen,

                          height: 320,

                          fit: BoxFit.cover,

                          errorBuilder:
                              (context, error, stackTrace) {
                            return Container(
                              height: 320,

                              color:
                                  Colors.blueGrey.shade900,

                              child: const Center(
                                child: Icon(
                                  Icons
                                      .image_not_supported,
                                  color: Colors.white,
                                  size: 60,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 25,
                    ),

                    Expanded(
                      flex: 3,

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          Text(
                            animal.nombre,

                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                            height: 30,
                          ),

                          const Text(
                            "Descripción",

                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 22,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          Text(
                            animal.descripcion,

                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          const SizedBox(
                            height: 30,
                          ),

                          const Text(
                            "Estado de conservación",

                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 22,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          Text(
                            animal.peligro,

                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          const SizedBox(
                            height: 30,
                          ),

                          const Text(
                            "Número de especímenes",

                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 22,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          Text(
                            animal.especimenes
                                .toString(),

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
            ),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.edit,
                ),

                label: const Text(
                  "Editar",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.blueGrey,

                  foregroundColor:
                      Colors.white,

                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 14,
                  ),

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                ),

                onPressed: () async {
                  final Animal? animalActualizado =
                      await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FormularioAnimal(
                        animal: animal,
                        index: index,
                      ),
                    ),
                  );

                  if (animalActualizado != null) {
                    Navigator.pop(
                      context,
                      animalActualizado,
                    );
                  }
                },
              ),
            ),

            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}