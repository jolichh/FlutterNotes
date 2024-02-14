import 'package:flutter/material.dart';

import 'nota.dart';

class listaDeNotas extends ChangeNotifier {
  List<Nota> listaNotas = [
    Nota(id: 1, titulo: 'Título 1', contenido: 'Cuerpo 1')
  ];

  List<Nota> getNotas() {
    return this.listaNotas;
  }

  void agregarNota(Nota nuevaNota) {
    listaNotas.add(nuevaNota);
    notifyListeners();
  }

  void updateNota(Nota notaAct, String titulo, String texto) {
    for (int i = 0; i < listaNotas.length; i++) {
      if (listaNotas[i].id == notaAct.id) {
        listaNotas[i].titulo = titulo;
        listaNotas[i].contenido = texto;
      }
    }
    notifyListeners();
  }

  void deleteNota(Nota nota) {
    listaNotas.remove(nota);
    notifyListeners();
  }
}
