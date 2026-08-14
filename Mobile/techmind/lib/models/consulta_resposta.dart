class ConsultaResposta {
  final String categoria;
  final double probabilidade;
  final List<String> tags;
  final String resumo;

  ConsultaResposta({
    required this.categoria,
    required this.probabilidade,
    required this.tags,
    required this.resumo,
  });

  factory ConsultaResposta.fromJson(Map<String, dynamic> json) {
    return ConsultaResposta(
      categoria: json['categoria'],
      probabilidade: (json['probabilidade'] as num).toDouble(),
      tags: List<String>.from(json['tags']),
      resumo: json['resumo'],
    );
  }
}
