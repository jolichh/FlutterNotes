class Nota {
  int? id;
  String titulo = '';
  String contenido = '';

  Nota({required this.id, required this.titulo, required this.contenido});

  Nota.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    contenido = json['contenido'];
  }

  String toJson() {
    String data = "{";
    if (id != null) {
      data += '"id": $id, ';
    }
    data += '"titulo": "$titulo", "contenido": $contenido}';
    return data;
  }
}
