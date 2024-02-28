import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'nota.dart';

class listaDeNotas extends ChangeNotifier {
  List<Nota> listaNotas = [
    Nota(
        id: 0,
        titulo: "My first note",
        contenido: "Un dia soleado en barcelona")
  ];

  /* listaDeNotas() {
    recuperarListaNotas().then((listNotaRec) => {
          if (listNotaRec.isNotEmpty)
            {
              listaNotas = listNotaRec,
              notifyListeners(),
            }
          else
            {
              agregarNota(Nota(
                  id: 0,
                  titulo: "My first note",
                  contenido: "Un dia soleado en barcelona"))
            }
        });
  }*/

  List<Nota> getNotas() {
    return this.listaNotas;
  }

  Future<void> agregarNota(Nota nuevaNota) async {
    listaNotas.add(nuevaNota);
    guardarListaNotas();
    notifyListeners();
  }

  Future<void> updateNota(Nota notaAct, String titulo, String texto) async {
    for (int i = 0; i < listaNotas.length; i++) {
      if (listaNotas[i].id == notaAct.id) {
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
    print(jsonData);
    await prefs.setString('listadoNotas', jsonData);
  }

  Future<void> vaciarSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('listadoNotas');
  }

  Future<List<Nota>> recuperarListaNotas() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString('listadoNotas');
    List<dynamic> jsonList = jsonDecode(jsonData!);
    List<Nota> listaDeNotas =
        jsonList.map((json) => Nota.fromJson(json)).toList();
    return listaDeNotas;
  }

  List<String> listaToJson() {
    List<String> list = [];
    for (Nota nota in listaNotas) {
      list.add(nota.toJson());
    }
    return list;
  }
}
