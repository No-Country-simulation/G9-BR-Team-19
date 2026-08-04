import 'package:flutter/material.dart';
import 'package:techmind/config/app_size.dart';
import 'package:techmind/models/consulta_resposta.dart';

class ConsultaRespostaView extends StatelessWidget {
  final ConsultaResposta resposta;
  const ConsultaRespostaView({super.key, required this.resposta});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0x0F0F0F80),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text("TECHMIND", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: const Color(0x0F0F0F80),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/plano_de_fundo.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 8,
              children: [
                Text(
                  'Resumo da Análise',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    cardResultado(
                      context,
                      'Categoria',
                      resposta.categoria,
                      Icons.category,
                    ),
                    cardResultado(
                      context,
                      'Probabilidade',
                      resposta.probabilidade.toString(),
                      Icons.percent,
                    ),
                    cardResultado(
                      context,
                      'Resumo',
                      resposta.resumo,
                      Icons.description,
                    ),
                  ],
                ),
                Text(
                  'Topicos identificados',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0x37373726),
                    ),
                    child: ListView.builder(
                      itemCount: resposta.tags.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(
                            Icons.circle,
                            color: Colors.white,
                            size: 12,
                          ),
                          title: Text(
                            resposta.tags[index],
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container cardResultado(
    BuildContext context,
    String label,
    String resposta,
    IconData icone,
  ) {
    return Container(
      constraints: BoxConstraints(minHeight: 125),
      // height: 125,
      width: context.largura * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0x37373726),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(icone, size: 45, color: Colors.white),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: IntrinsicWidth(
                child: Container(
                  padding: const EdgeInsets.only(left: 12),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(width: 2, color: Colors.white),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      Text(
                        resposta,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
