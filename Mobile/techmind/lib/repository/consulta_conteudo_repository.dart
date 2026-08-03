import 'package:techmind/models/consulta_conteudo.dart';
import 'package:techmind/models/consulta_resposta.dart';
import 'package:techmind/service/api_service.dart';

class ConsultaConteudoRepository {
  ApiService api = ApiService();

  Future<Object> enviarDadosConsulta(ConsultaConteudo consultaConteudo) async {
    try {
      final response = await api.post(
        "/conteudos/processar",
        consultaConteudo.toJson(),
      );
      print(response);
      return ConsultaResposta.fromjson(response);
    } catch (e) {
      print(e);
    }
    return 'Erro ao fazer requisição';
  }
}
