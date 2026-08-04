import 'package:flutter/material.dart';
import 'package:techmind/config/app_size.dart';
import 'package:techmind/models/consulta_conteudo.dart';
import 'package:techmind/shared/widgets/botao_form.dart';
import 'package:techmind/shared/widgets/input_form.dart';
import 'package:techmind/view/consulta_resposta_view.dart';
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
    final vm = context.watch<ConsultaConteudoViewmodels>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0x0F0F0F80),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text("TECHMIND", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: const Color(0x0F0F0F80),
        ),
        drawer: Drawer(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: context.altura * 0.10,
                width: double.infinity,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Color(0xff000541)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "TECHMIND",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(title: Text("Nova Análise"), onTap: () {}),
              const Divider(),
              ListTile(title: Text("Bibliotech"), onTap: () {}),
              const Divider(),
              ListTile(title: Text("Métricas"), onTap: () {}),
              const Divider(),

              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xff000541), // Cor da borda
                          width: 0.7,
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Sair", style: TextStyle(fontSize: 20)),
                          IconButton(
                            color: Colors.red,
                            onPressed: () {},
                            icon: Icon(Icons.logout, size: 25),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/plano_de_fundo.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  minVerticalPadding: 0,
                  title: Text(
                    "Análise de Conteúdo",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(104, 33, 149, 243),
                    ),
                    child: Icon(Icons.edit_document, color: Colors.white),
                  ),
                  subtitle: Text(
                    "Preencha os campos a baixo para analisar o conteúdo",
                    style: TextStyle(color: Colors.white54),
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
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        InputForm(
                          controller: ctrTitulo,
                          hintText: "Digite aqui o título...",
                        ),
                        Text(
                          "Texto",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        InputForm(
                          controller: ctrTexto,
                          hintText: "Digite aqui o texto...",
                          maxLine: 6,
                        ),
                        vm.carregar
                            ? Center(child: CircularProgressIndicator())
                            : BotaoForm(
                                label: "Consultar",
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    final dados = ConsultaConteudo(
                                      titulo: ctrTitulo.text,
                                      texto: ctrTexto.text,
                                    );

                                    final vm = context
                                        .read<ConsultaConteudoViewmodels>();

                                    await vm.enviarConteudo(dados);

                                    if (!context.mounted) return;

                                    final resposta = vm.resposta;

                                    if (resposta != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ConsultaRespostaView(
                                            resposta: resposta,
                                          ),
                                        ),
                                      );
                                    }
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
