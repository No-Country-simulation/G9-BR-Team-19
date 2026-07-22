import 'package:techmind/models/consulta_conteudo.dart';
import 'package:techmind/service/api_service.dart';

class ConsultaConteudoRepository {
  ApiService api = ApiService();

  Future<ConsultaConteudo> enviarDadosConsulta(
    ConsultaConteudo consultaConteudo,
  ) async {
    final response = await api.post(
      "/conteudos/processar",
      consultaConteudo.toJson(),
    );

    return ConsultaConteudo.fromJson(response);
  }
}
