import 'package:flutter/material.dart';
import 'package:techmind/models/consulta_conteudo.dart';
import 'package:techmind/shared/widgets/input_form.dart';
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
        appBar: AppBar(title: Text("TECHMIND"), centerTitle: true),
        drawer: Drawer(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text("TECHMIND"),
                ),
              ),
              ListTile(title: Text("Nova Análise"), onTap: () {}),
              ListTile(title: Text("Bibliotech"), onTap: () {}),
              ListTile(title: Text("Métricas"), onTap: () {}),
            ],
          ),
        ),
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
                    InputForm(controller:  ctrTitulo, label:  "Titulo"),
                    InputForm(controller:  ctrTexto, label:  "Texto"),
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

  
}
