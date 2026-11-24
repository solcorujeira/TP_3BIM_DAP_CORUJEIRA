import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tp_2bim/modelos/animal.dart';

final animalProvider = StreamProvider<List<Animal>>((ref) {
  return FirebaseFirestore.instance
      .collection('animales arg')
      .withConverter<Animal>(
        fromFirestore: Animal.fromFirestore,
        toFirestore: (Animal animal, _) => animal.toFirestore(),
      )
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) {
          final animal = doc.data();

          return Animal(
            id: doc.id,
            nombre: animal.nombre,
            imagen: animal.imagen,
            descripcion: animal.descripcion,
            peligro: animal.peligro,
            especimenes: animal.especimenes,
          );
        }).toList();
      });
});

final animalServiceProvider = Provider<AnimalService>((ref) {
  return AnimalService();
});

class AnimalService {
  final CollectionReference<Animal> _coleccion =
      FirebaseFirestore.instance
          .collection('animales arg')
          .withConverter<Animal>(
            fromFirestore: Animal.fromFirestore,
            toFirestore: (Animal animal, _) => animal.toFirestore(),
          );

  Future<void> agregar(Animal animal) async {
    await _coleccion.add(animal);
  }

  Future<void> editar(String idDoc, Animal animal) async {
    await _coleccion.doc(idDoc).set(animal);
  }

  Future<void> eliminar(String idDoc) async {
    await _coleccion.doc(idDoc).delete();
  }
}