import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FaqQuestion {
  final String question;
  int likes;

  FaqQuestion(this.question, {this.likes = 0});
}

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
      _questions.add(FaqQuestion(question) as String);
    });
    _questionController.clear();
    Navigator.of(context).pop(); // Schließe die Chatbox
  }

  // ...

  @override
  Widget build(BuildContext context) {
    // ...

    return Scaffold(
      appBar: AppBar(
        // ...
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ...

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
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _questions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Frage ${index + 1}:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(_questions[index].question),
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

            // ...
          ],
        ),
      ),
    );
  }
}
