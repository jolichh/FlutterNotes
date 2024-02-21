import 'package:app_notes/pages/listaDeNotas.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'editar_nota.dart';
import 'nota.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _homePageState();
}

class _homePageState extends State<Home> {
  void createNotas() {
    int idNuevo =
        Provider.of<listaDeNotas>(context, listen: false).getNotas().length;
    Nota newNota = Nota(id: idNuevo, titulo: '', contenido: '');
    navegarNota(newNota, true);
  }

  void navegarNota(Nota nota, bool esNueva) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AgregarModificarNota(nota: nota, esNueva: esNueva)));
  }

  void eliminarNota(Nota nota) {
    Provider.of<listaDeNotas>(context, listen: false).deleteNota(nota);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<listaDeNotas>(
      builder: (context, note, child) => Scaffold(
        backgroundColor: CupertinoColors.systemBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: createNotas,
          child: Icon(Icons.add),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //header
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'my Notes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            //lista de notas
            CupertinoListSection.insetGrouped(
                children: List.generate(
                    note.getNotas().length,
                    (index) => CupertinoListTile(
                          title: Text(note.getNotas()[index].contenido),
                          onTap: () =>
                              navegarNota(note.getNotas()[index], false),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                eliminarNota(note.getNotas()[index]),
                          ),
                        ))),
          ],
        ),
      ),
    );
  }
}
