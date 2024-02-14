import 'dart:html';

import 'package:app_notes/pages/listaDeNotas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

import 'nota.dart';

class AgregarModificarNota extends StatefulWidget {
  Nota nota;
  bool esNueva;
  AgregarModificarNota({required this.nota, required this.esNueva});

  @override
  State<AgregarModificarNota> createState() => _AgregarModificarNota();
}

class _AgregarModificarNota extends State<AgregarModificarNota> {
  QuillController _controller = QuillController.basic();

  @override
  void initState() {
    super.initState();
    cargarNotaExistente();
  }

  void cargarNotaExistente() {
    final doc = Document()..insert(0, widget.nota.contenido);
    setState(() {
      _controller = QuillController(
          document: doc, selection: const TextSelection.collapsed(offset: 0));
    });
  }

  void agregarNota() {
    int id =
        Provider.of<listaDeNotas>(context, listen: false).getNotas().length;
    String title = _controller.document.toPlainText();
    String texto = _controller.document.toPlainText();
    Provider.of<listaDeNotas>(context, listen: false)
        .agregarNota(Nota(id: id, titulo: title, contenido: texto));
    Navigator.pop(context);
  }

  void actualizarNota() {
    String title = _controller.document.toPlainText();
    String texto = _controller.document.toPlainText();
    Provider.of<listaDeNotas>(context, listen: false)
        .updateNota(widget.nota, title, texto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Título'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                height: 300,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Texto...'),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 15,
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
                        if (widget.esNueva && !_controller.document.isEmpty()) {
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
