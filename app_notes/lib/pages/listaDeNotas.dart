import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'nota.dart';

class listaDeNotas extends ChangeNotifier {
  List<Nota> listaNotas = [
    Nota(titulo: "My first note", contenido: "My first day at work")
  ];

  Future<List<Nota>> getNotas() async {
    final prefs = await SharedPreferences.getInstance();
    final String listNotas = prefs.getString('cacheDatos').toString();
    print("get");
    print(listNotas);

    if (listNotas == 'null') {
      return this.listaNotas;
    }

    final List result = jsonDecode(listNotas);
    this.listaNotas = result.map((e) => Nota.fromJson(e)).toList();
    return listaNotas;
  }

  Future<void> agregarNota(Nota nuevaNota) async {
    listaNotas.add(nuevaNota);
    guardarListaNotas();
    notifyListeners();
  }

  Future<void> updateNota(Nota notaAct, String titulo, String texto) async {
    for (int i = 0; i < listaNotas.length; i++) {
      if (listaNotas[i] == notaAct) {
        listaNotas[i].titulo = titulo;
        listaNotas[i].contenido = texto;
      }
    }
    guardarListaNotas();
    notifyListeners();
  }

  Future<void> deleteNota(Nota nota) async {
    listaNotas.remove(nota);
    guardarListaNotas();
    notifyListeners();
  }

  Future<void> guardarListaNotas() async {
    final jsonData = listaToJson().toString();
    final prefs = await SharedPreferences.getInstance();
    print("guardando");
    print(jsonData);
    prefs.setString('cacheDatos', jsonData);
  }

  List<String> listaToJson() {
    List<String> list = [];
    for (Nota nota in listaNotas) {
      list.add(nota.toJson());
    }
    return list;
  }
}
