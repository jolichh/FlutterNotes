import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    nuevaNota.toString();
    //guardarDatosCache(nuevaNota)
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

  Future<void> guardarDatosCache(String values) async {
    print(values);
    final dataNotas = await SharedPreferences.getInstance();
    dataNotas.setString("listaNotas", values);
  }

  Future<List<Nota>> getDatosCache() async {
    final dataNotas = await SharedPreferences.getInstance();
    List listaNotas =
        json.decode(dataNotas.getString("llistaArticles").toString());
    return listaNotas.map((e) => Nota.fromJson(e)).toList();
  }
}
