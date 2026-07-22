import 'package:flutter/material.dart';
import 'package:techmind/models/consulta_conteudo.dart';
import 'package:techmind/repository/consulta_conteudo_repository.dart';

class ConsultaConteudoViewmodels extends ChangeNotifier {
  ConsultaConteudoRepository repositorio = ConsultaConteudoRepository();

  List<ConsultaConteudo> consultaConteudo = [];

  bool carregar = false;

  Future<void> enviarConteudo(ConsultaConteudo consultaConteudo) async {
    carregar = true;
    await repositorio.enviarDadosConsulta(consultaConteudo);
    carregar = false;
    notifyListeners();
  }
}
