import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Notes'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//ESTA CLASE ES DE PREUBA
class Lista {
  String titulo;
  String body;

  Lista({required this.titulo, required this.body});
}

class _MyHomePageState extends State<MyHomePage> {
  //CON OBJETOS DE PRUEBA
  List<Lista> lista = [
    Lista(titulo: 'Título 1', body: 'Cuerpo 1'),
    Lista(titulo: 'Título 2', body: 'Cuerpo 2'),
  ];

  void _agregarNota() {
    setState(() {});
  }

  void _eliminarNota() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, index) {
                //muestra cada nota de la lista
                return ListTile(
                  title: Text(lista[index].titulo),
                  subtitle: Text(lista[index].body),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: null,
                    tooltip: 'Eliminar',
                  ),
                );
              },
            )),
          ],
        ),
      ),
      //boton flotante
      floatingActionButton: FloatingActionButton(
        onPressed: _agregarNota,
        tooltip: 'Agregar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
