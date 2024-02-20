import 'package:app_notes/pages/listaDeNotas.dart';
import 'package:app_notes/pages/note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'nota.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _homePageState();
}

class _homePageState extends State<Home> {
  void createNotas() {
    int idNuevo =
        Provider.of<listaDeNotas>(context, listen: false).getNotas().length;
    Nota newNota = Nota(
        id: idNuevo, titulo: "Nota default", contenido: "Cuerpo de la nota");
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
        backgroundColor: Color.fromARGB(255, 255, 254, 235),
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
                          title: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${note.getNotas()[index].titulo}\n',
                                  style: TextStyle(
                                      fontWeight: FontWeight
                                          .bold, // Opciones de estilo según tus preferencias
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                                TextSpan(
                                  text: '${note.getNotas()[index].contenido}',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
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
