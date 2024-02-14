import 'package:app_notes/pages/listaDeNotas.dart';
import 'package:app_notes/pages/note.dart';
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
