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
  List<String> _answers = []; // Liste der Antworten

  void _submitQuestion() {
    String question = _questionController.text;
    setState(() {
      _questions.add(question);
      _answers.add(''); // Füge eine leere Antwort für die Frage hinzu
    });
    _questionController.clear();
    Navigator.of(context, rootNavigator: true).pop();
  }

  void _submitAnswer(int index, String answer) {
    setState(() {
      _answers[index] = answer;
    });
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
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.black,
      toolbarHeight: 80,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Hier hinzugefügt
        children: [
          Image.asset(
            'assets/app_icon_inverted.png',
            width: 75,
            height: 75,
          ),
          const Text(
            'About',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 30, bottom: 15),
                  child: const Text(
                    "Gibt's noch Fragen?",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 5, bottom: 15, left: 40, right: 40),
                  child: const Text(
                    "Unsere Administratoren versuchen ihre Fragen schnellstmöglich zu beantworten. Fragen sie einfach drauf los, oder suchen sie nach ihrer Frage. Eventuell wurde sie bereits beantwortet?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
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
                                onPressed: () {
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
                      onChanged:
                      (value) {
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
                              'Frage ${index + 1}: ${_filterQuestions(_searchController.text)[index]}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextField(
                              onChanged: (value) {
                                _submitAnswer(index, value);
                              },
                              decoration: const InputDecoration(
                                hintText: 'Antwort eingeben...',
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Hier kannst du weitere Aktionen für das Absenden der Antwort hinzufügen
                              },
                              icon: const Icon(Icons.send),
                            ),
                            Text(
                              'Antwort: ${_answers[index]}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: 
              Image.asset(
                'assets/faq.png', // Pfad zum PNG-Bild
                width: 75,
                height: 75,
              ),
            )
          ],
        ),
      ),
    );
  }
}
