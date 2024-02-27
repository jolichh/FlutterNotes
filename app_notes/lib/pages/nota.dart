class Nota {
  int? id;
  String titulo = '';
  String contenido = '';

  Nota({required this.id, required this.titulo, required this.contenido});

  factory Nota.fromJson(Map<String, dynamic> json) {
    return Nota(
      id: json['id'] as int,
      titulo: json['titulo'] as String,
      contenido: json['contenido'] as String,
    );
  }

  String toJson() {
    String data = "{";
    if (id != null) {
      data += '"id": $id, ';
    }
    data += '"titulo": "$titulo", "contenido": "$contenido"}';
    return data;
  }
}
