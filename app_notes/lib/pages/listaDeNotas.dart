import 'package:flutter/material.dart';

import 'nota.dart';

class listaDeNotas extends ChangeNotifier {
  List<Nota> listaNotas = [
    Nota(id: 1, titulo: 'Título 1', contenido: 'Cuerpo 1')
  ];

  List<Nota> getNotas() {
    return this.listaNotas;
  }
}
