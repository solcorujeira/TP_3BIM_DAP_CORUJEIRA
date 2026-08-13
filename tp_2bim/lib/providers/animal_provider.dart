import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tp_2bim/modelos/animal.dart';

class AnimalNotifier extends Notifier<List<Animal>> {
  @override
  List<Animal> build() {
    return [
      Animal(
        nombre: "Yaguareté",
        imagen:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbZ1j8BSAzLYKqY2BIeE8Z2D3n1g7qn8sOxwp8Wd3GlUPGbafHzrohdEE8YQPfGlzrPCurj4zTBfngPVq3tqKyzwomPPGNdaMNLl2Q5Q&s=10",
        descripcion:
            "Es el felino más grande de América y habita en la Selva Misionera y el Gran Chaco.",
        peligro: "En peligro crítico",
        especimenes: 250,
      ),
    ];
  }

  void agregar(Animal animal) {
    state = [...state, animal];
  }

  void editar(int index, Animal animal) {
    final lista = [...state];
    lista[index] = animal;
    state = lista;
  }

  void eliminar(int index) {
    final lista = [...state];
    lista.removeAt(index);
    state = lista;
  }
}

final animalesProvider =
    NotifierProvider<AnimalNotifier, List<Animal>>(
  AnimalNotifier.new,
);