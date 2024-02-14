import 'package:flutter/material.dart';

class Nota extends StatefulWidget {
  @override
  _Nota createState() => _Nota();
}

class _Nota extends State<Nota> {
  void _guardarNota() {
    setState(() {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Título'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                height: 300,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Texto...'),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 15,
                ),
              ),
            ),
            const Spacer(),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Tooltip(
                    message: 'Guardar',
                    child: ElevatedButton(
                      onPressed: _guardarNota,
                      child: Text('Save'),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
