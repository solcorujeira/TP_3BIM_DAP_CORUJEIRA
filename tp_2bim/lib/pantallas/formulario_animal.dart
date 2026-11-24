import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tp_2bim/modelos/animal.dart';
import 'package:tp_2bim/providers/animal_provider.dart';

class FormularioAnimal extends ConsumerStatefulWidget {
  final Animal? animal;
  final String? idDoc;

  const FormularioAnimal({
    super.key,
    this.animal,
    this.idDoc,
  });

  @override
  ConsumerState<FormularioAnimal> createState() =>
      _FormularioAnimalState();
}

class _FormularioAnimalState extends ConsumerState<FormularioAnimal> {
  late TextEditingController nombreController;
  late TextEditingController imagenController;
  late TextEditingController descripcionController;
  late TextEditingController peligroController;
  late TextEditingController especimenesController;

  bool guardando = false;

  bool get editando => widget.animal != null;

  @override
  void initState() {
    super.initState();

    nombreController = TextEditingController(
      text: widget.animal?.nombre ?? '',
    );

    imagenController = TextEditingController(
      text: widget.animal?.imagen ?? '',
    );

    descripcionController = TextEditingController(
      text: widget.animal?.descripcion ?? '',
    );

    peligroController = TextEditingController(
      text: widget.animal?.peligro ?? '',
    );

    especimenesController = TextEditingController(
      text: widget.animal?.especimenes.toString() ?? '',
    );
  }

  @override
  void dispose() {
    nombreController.dispose();
    imagenController.dispose();
    descripcionController.dispose();
    peligroController.dispose();
    especimenesController.dispose();
    super.dispose();
  }

  InputDecoration decoracion(String texto) {
    return InputDecoration(
      labelText: texto,
      labelStyle: const TextStyle(color: Colors.white70),
      filled: true,
      fillColor: Colors.blueGrey.shade900,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.blueGrey,
          width: 2,
        ),
      ),
    );
  }

  Future<void> guardar() async {
    if (guardando) return;

    final nombre = nombreController.text.trim();
    final imagen = imagenController.text.trim();
    final descripcion = descripcionController.text.trim();
    final peligro = peligroController.text.trim();
    final especimenes = int.tryParse(
      especimenesController.text.trim(),
    );

    if (nombre.isEmpty ||
        imagen.isEmpty ||
        descripcion.isEmpty ||
        peligro.isEmpty ||
        especimenes == null ||
        especimenes < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Completá todos los campos correctamente'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final idParaEditar = widget.idDoc ?? widget.animal?.id;

    if (editando && (idParaEditar == null || idParaEditar.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No se encontró el ID del animal que querés editar.',
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final animalNuevo = Animal(
      id: idParaEditar,
      nombre: nombre,
      imagen: imagen,
      descripcion: descripcion,
      peligro: peligro,
      especimenes: especimenes,
    );

    setState(() {
      guardando = true;
    });

    try {
      final servicio = ref.read(animalServiceProvider);

      if (editando) {
        await servicio.editar(idParaEditar!, animalNuevo);
      } else {
        await servicio.agregar(animalNuevo);
      }

      if (!mounted) return;

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al guardar: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          guardando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(editando ? 'Editar animal' : 'Agregar animal'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade900,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    editando ? Icons.edit : Icons.add,
                    color: Colors.white,
                    size: 45,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                editando ? 'Modificar información' : 'Nuevo animal',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                editando
                    ? 'Modificá los datos del animal'
                    : 'Completá los datos para agregarlo',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: nombreController,
                style: const TextStyle(color: Colors.white),
                decoration: decoracion('Nombre'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: imagenController,
                style: const TextStyle(color: Colors.white),
                decoration: decoracion('URL de imagen'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descripcionController,
                style: const TextStyle(color: Colors.white),
                maxLines: 4,
                decoration: decoracion('Descripción'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: peligroController,
                style: const TextStyle(color: Colors.white),
                decoration: decoracion('Estado de conservación'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: especimenesController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: decoracion('Número de especímenes'),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: guardando ? null : guardar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: guardando
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          editando
                              ? 'Guardar cambios'
                              : 'Agregar animal',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}