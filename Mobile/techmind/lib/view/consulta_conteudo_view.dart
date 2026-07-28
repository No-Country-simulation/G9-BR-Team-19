import 'package:flutter/material.dart';
import 'package:techmind/models/consulta_conteudo.dart';
import 'package:techmind/shared/widgets/botao_form.dart';
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
        resizeToAvoidBottomInset: false,
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
        body: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('assets/plano_de_fundo.png'),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  minVerticalPadding: 0,
                  title: Text("Análise de Conteúdo"),
                  leading: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(104, 33, 149, 243),
                    ),
                    child: Icon(Icons.edit_document),
                  ),
                  subtitle: Text(
                    "Preencha os campos a baixo para analisar o conteúdo",
                  ),
                ),
                Form(
                  key: formKey,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 18,
                      bottom: 18,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0x37373726),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 12,
                      children: [
                        Text(
                          "Titulo",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        InputForm(
                          controller: ctrTitulo,
                          hintText: "Digite aqui o título...",
                        ),
                        Text(
                          "Texto",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        InputForm(
                          controller: ctrTexto,
                          hintText: "Digite aqui o texto...",
                          maxLine: 6,
                        ),
                        BotaoForm(
                          label: "Consultar",
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
                          gradient1: Color(0xff000EA7),
                          gradient2: Color(0xff000541),
                        ),
                      ],
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
}
