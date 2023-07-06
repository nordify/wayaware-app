import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({Key? key});

  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  TextEditingController _searchController = TextEditingController();
  TextEditingController _questionController = TextEditingController();
  List<String> _questions = []; // Liste der gestellten Fragen

  void _submitQuestion() {
    String question = _questionController.text;
    setState(() {
      _questions.add(question);
    });
    _questionController.clear();
    Navigator.of(context).pop(); // Schließe die Chatbox
  }

  @override
  void dispose() {
    _searchController.dispose();
    _questionController.dispose();
    super.dispose();
  }

  List<String> _filterQuestions(String searchText) {
    // Hier kannst du die Logik für die Filterung der Fragen implementieren,
    // basierend auf dem Suchtext
    if (searchText.isEmpty) {
      return _questions; // Gib alle Fragen zurück, wenn die Suchleiste leer ist
    } else {
      return _questions
          .where((question) => question.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 80,
        title: GestureDetector(
          onTap: () => context.go('/home'),
          child: Row(
            children: [
              Image.asset(
                'assets/app_icon_inverted.png',
                width: 75,
                height: 75,
              ),
              const SizedBox(width: 20),
              const Text('FAQ',
                  style: TextStyle(fontSize: 30, color: Colors.white)),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.black,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () => context.go('/about'),
                          icon: const Icon(Icons.info, color: Colors.white),
                        ),
                        const Text(
                          'About',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () => context.go('/contact'),
                          icon: const Icon(Icons.contact_mail,
                              color: Colors.white),
                        ),
                        const Text(
                          'Kontakt',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Fragen stellen',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Frage stellen'),
                            content: TextField(
                              controller: _questionController,
                              decoration: const InputDecoration(
                                hintText: 'Geben Sie Ihre Frage ein',
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: (){
                                  _submitQuestion();
                                },
                                child: const Text('Absenden'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Frage stellen'),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Fragen und Antworten',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {}); // Aktualisiere die Anzeige basierend auf dem Suchtext
                      },
                      decoration: const InputDecoration(
                        hintText: 'Suche nach Fragen',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _filterQuestions(_searchController.text).length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Frage ${index + 1}:',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(_filterQuestions(_searchController.text)[index]),
                            // Hier können weitere Informationen zur Beantwortung der Frage angezeigt werden,
                            // z. B. Textfelder für die Antwort, Buttons zum Liken usw.
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black,
              padding: const EdgeInsets.all(16),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '© 2023 Your Company. Alle Rechte vorbehalten.',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
