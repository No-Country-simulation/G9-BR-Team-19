class ConsultaConteudo {
  String titulo;
  String texto;

  ConsultaConteudo({required this.texto, required this.titulo});

  factory ConsultaConteudo.fromJson(Map<String, dynamic> json) {
    return ConsultaConteudo(texto: json['texto'], titulo: json['titulo']);
  }

  Map<String, dynamic> toJson() {
    return {'titulo': titulo, 'texto': texto};
  }

}
