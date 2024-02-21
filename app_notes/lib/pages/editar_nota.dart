// ignore_for_file: must_be_immutable

import 'package:app_notes/pages/listaDeNotas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';
import 'nota.dart';

// ignore: must_be_immutable
class AgregarModificarNota extends StatefulWidget {
  Nota nota;
  bool esNueva;
  AgregarModificarNota({required this.nota, required this.esNueva});

  @override
  State<AgregarModificarNota> createState() => _AgregarModificarNota();
}

class _AgregarModificarNota extends State<AgregarModificarNota> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cargarNotaExistente();
  }

  void cargarNotaExistente() {
    _titleController.text = widget.nota.titulo;
    _textController.text = widget.nota.contenido;
  }

  void agregarNota() {
    int id =
        Provider.of<listaDeNotas>(context, listen: false).getNotas().length;
    String title = _titleController.text;
    String texto = _textController.text;
    Provider.of<listaDeNotas>(context, listen: false)
        .agregarNota(Nota(id: id, titulo: title, contenido: texto));
    // Navigator.pop(context);
  }

  void actualizarNota() {
    String title = _titleController.text;
    String texto = _textController.text;
    Provider.of<listaDeNotas>(context, listen: false)
        .updateNota(widget.nota, title, texto);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(
              border: InputBorder.none, hintText: 'Title...'),
          controller: _titleController,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                height: 200,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Texto...'),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 15,
                  controller: _textController,
                ),
              ),
            ),
            const Spacer(),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Tooltip(
                    message: 'Guardar',
                    child: ElevatedButton(
                      onPressed: () {
                        if (widget.esNueva &&
                            _textController.value.toString().isNotEmpty &&
                            _titleController.value.toString().isNotEmpty) {
                          agregarNota();
                        } else {
                          actualizarNota();
                        }
                        Navigator.pop(context);
                      },
                      child: Text('Save'),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
