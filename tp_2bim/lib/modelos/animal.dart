import 'package:cloud_firestore/cloud_firestore.dart';

class Animal {
  final String? id;
  final String nombre;
  final String imagen;
  final String descripcion;
  final String peligro;
  final int especimenes;

  Animal({
    this.id,
    required this.nombre,
    required this.imagen,
    required this.descripcion,
    required this.peligro,
    required this.especimenes,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'Nombre': nombre,
      'Descripción': descripcion,
      'Imagen': imagen,
      'Peligro': peligro,
      'Especímenes': especimenes,
    };
  }

  factory Animal.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Animal(
      id: snapshot.id,
      nombre: data?['Nombre'] ?? '',
      descripcion: data?['Descripción'] ?? '',
      imagen: data?['Imagen'] ?? '',
      peligro: data?['Peligro'] ?? '',
      especimenes: data?['Especímenes'] ?? ''
          //(data?['Especímenes'] as num?)?.toInt() ?? 0,
    );
  }
}