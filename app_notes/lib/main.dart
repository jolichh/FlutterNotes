import 'package:app_notes/pages/home.dart';
import 'package:app_notes/pages/listaDeNotas.dart';
import 'package:app_notes/pages/note.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/nota.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => listaDeNotas(),
        builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Home(),
            ));
  }
}
