class Nota {
  //int? id;
  String titulo = '';
  String contenido = '';

  Nota({required this.titulo, required this.contenido});

  factory Nota.fromJson(Map<String, dynamic> json) {
    return Nota(
      titulo: json['titulo'] as String,
      contenido: json['contenido'] as String,
    );
  }

  String toJson() {
    String data = "{";
    data += '"titulo": "$titulo", "contenido": "$contenido"}';
    return data;
  }
}
