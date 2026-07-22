import 'package:flutter/material.dart';
import 'package:techmind/models/consulta_conteudo.dart';
import 'package:techmind/viewmodels/consulta_conteudo_viewmodels.dart';
import 'package:provider/provider.dart';

class ConsultaConteudoView extends StatefulWidget {
  const ConsultaConteudoView({super.key});

  @override
  State<ConsultaConteudoView> createState() => _ConsultaConteudoViewState();
}

class _ConsultaConteudoViewState extends State<ConsultaConteudoView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController ctrTitulo = TextEditingController();
  TextEditingController ctrTexto = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: 12,
                  children: [
                    Text("data"),
                    inputForm(ctrTitulo, "Titulo"),
                    inputForm(ctrTexto, "Texto"),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final dados = ConsultaConteudo(
                            titulo: ctrTitulo.text,
                            texto: ctrTexto.text,
                          );

                          await context
                              .read<ConsultaConteudoViewmodels>()
                              .enviarConteudo(dados);
                        }
                      },
                      child: Text("Consultar Dados"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField inputForm(TextEditingController controller, String label) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        label: Text(label),
      ),
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Campo obrigatório";
        }
        return null;
      },
    );
  }
}
