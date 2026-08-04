import 'package:techmind/models/consulta_conteudo.dart';
import 'package:techmind/models/consulta_resposta.dart';
import 'package:techmind/service/api_service.dart';

class ConsultaConteudoRepository {
  ApiService api = ApiService();

  Future<ConsultaResposta> enviarDadosConsulta(
    ConsultaConteudo consultaConteudo,
  ) async {
    try {
      final response = await api.post(
        "/conteudos/processar",
        consultaConteudo.toJson(),
      );
      print(response);
      return ConsultaResposta.fromJson(response);
    } catch (e) {
      print(e);
      throw Exception('Erro ao fazer requisição $e');
    }
  }
}
