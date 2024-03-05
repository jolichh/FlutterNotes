import 'package:app_notes/pages/listaDeNotas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'editar_nota.dart';
import 'nota.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  void navegarNota(Nota nota, bool esNueva) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AgregarModificarNota(nota: nota, esNueva: esNueva),
      ),
    );
  }

  void eliminarNota(Nota nota) async {
    Provider.of<listaDeNotas>(context, listen: false).deleteNota(nota);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<listaDeNotas>(
      builder: (context, note, child) => Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 254, 235),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Nota newNota = Nota(titulo: '', contenido: '');
            navegarNota(newNota, true);
          },
          child: const Icon(Icons.add),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'My Notes',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            // Lista de notas
            Expanded(
                child: FutureBuilder<List<Nota>>(
                    future: note.getNotas(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) => Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: ListTile(
                              title: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${snapshot.data![index].titulo}\n',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: snapshot.data![index].contenido,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () =>
                                        eliminarNota(snapshot.data![index]),
                                  ),
                                  IconButton(
                                    onPressed: () => navegarNota(
                                        snapshot.data![index], false),
                                    icon: const Icon(Icons.create_outlined),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text("Error:${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                    })),
          ],
        ),
      ),
    );
  }
}
