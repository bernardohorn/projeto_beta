import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> escolaridades = [];
  List<String> projetos = [];
  List<String> recomendacoes = [];

  void _abrirFormulario() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormularioCadastro()),
    ).then((resultado) {
      if (resultado != null) {
        setState(() {
          if (resultado['tipo'] == 'Escolaridade') {
            escolaridades.add(resultado['texto']);
          } else if (resultado['tipo'] == 'Projetos') {
            projetos.add(resultado['texto']);
          } else if (resultado['tipo'] == 'Recomendacoes') {
            recomendacoes.add(resultado['texto']);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Currículo Digital"),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: _abrirFormulario),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('images/i.png'),
            ),
            SizedBox(height: 16),
            Text(
              'Olá, meu nome é Bernardo Pellizzaro Horn. Sou um desenvolvedor apaixonado pela tecnologia e pelo inter.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EscolaridadePage(lista: escolaridades),
                  ),
                );
              },
              child: Text("Escolaridade"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProjetosPage(lista: projetos),
                  ),
                );
              },
              child: Text("Projetos"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RecomendacoesPage(lista: recomendacoes),
                  ),
                );
              },
              child: Text("Recomendações"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FormularioCadastro extends StatefulWidget {
  @override
  _FormularioCadastroState createState() => _FormularioCadastroState();
}

class _FormularioCadastroState extends State<FormularioCadastro> {
  TextEditingController textoController = TextEditingController();
  String tipoSelecionado = 'Escolaridade';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastrar Informação")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<String>(
              value: tipoSelecionado,
              isExpanded: true,
              items: ['Escolaridade', 'Projetos', 'Recomendacoes'].map((
                String valor,
              ) {
                return DropdownMenuItem(value: valor, child: Text(valor));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  tipoSelecionado = value!;
                });
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: textoController,
              decoration: InputDecoration(
                labelText: "Digite a informação",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (textoController.text.isNotEmpty) {
                  Navigator.pop(context, {
                    'tipo': tipoSelecionado,
                    'texto': textoController.text,
                  });
                }
              },
              child: Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}

class EscolaridadePage extends StatelessWidget {
  final List<String> lista;

  EscolaridadePage({required this.lista});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Escolaridade")),
      body: lista.isEmpty
          ? Center(child: Text("Nenhuma escolaridade cadastrada"))
          : ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.school),
                  title: Text(lista[index]),
                );
              },
            ),
    );
  }
}

class ProjetosPage extends StatelessWidget {
  final List<String> lista;

  ProjetosPage({required this.lista});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Projetos")),
      body: lista.isEmpty
          ? Center(child: Text("Nenhum projeto cadastrado"))
          : ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.work),
                  title: Text(lista[index]),
                );
              },
            ),
    );
  }
}

class RecomendacoesPage extends StatelessWidget {
  final List<String> lista;

  RecomendacoesPage({required this.lista});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recomendações")),
      body: lista.isEmpty
          ? Center(child: Text("Nenhuma recomendação cadastrada"))
          : ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.thumb_up),
                  title: Text(lista[index]),
                );
              },
            ),
    );
  }
}
