import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wayaware/bloc/settings_mode_bloc.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({Key? key});

  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();
  final List<String> _questions = []; // Liste der gestellten Fragen
  final List<String> _answers = []; // Liste der Antworten
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  void _submitForm() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Form submitted'),
        content: const Text('Thank you for your message!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

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
      return _questions.where((question) => question.toLowerCase().contains(searchText.toLowerCase())).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSettingsBloc, Map<String, bool>>(
      builder: (context, state) {
        final accessibilityMode = state['accessibility_mode'] ?? false;

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
                 Text(
                  'FAQ',
                   style: TextStyle(fontSize: accessibilityMode ? 40 : 28, fontWeight: FontWeight.w900, color: Colors.white),
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
                  child: Text(
                    "Having issues?",
                    style: TextStyle(fontSize: accessibilityMode ? 31 : 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 5, bottom: 15, left: 40, right: 40),
                  child: Text(
                    "Our administrators try to answer your questions as quickly as possible. Just ask about it, or look for your question. Perhaps it has already been answered?",
                    style: TextStyle(fontSize: accessibilityMode ? 35 : 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Ask Question'),
                                content: TextField(
                                  controller: _questionController,
                                  decoration: const InputDecoration(
                                    hintText: 'Type here...',
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      _submitQuestion();
                                    },
                                    child: const Text('Send'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.black),
                        ),
                        child: const Text('Ask Question'),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                       Text(
                        'Questions and Answers',
                        style: TextStyle(fontSize: accessibilityMode ? 35 : 20, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {}); // Aktualisiere die Anzeige basierend auf dem Suchtext
                          },
                          decoration: const InputDecoration(
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _filterQuestions(_searchController.text).length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Question ${index + 1}: ${_filterQuestions(_searchController.text)[index]}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextField(
                                  onChanged: (value) {
                                    _submitAnswer(index, value);
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Type Answer here...',
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // Hier kannst du weitere Aktionen für das Absenden der Antwort hinzufügen
                                  },
                                  icon: const Icon(Icons.send),
                                ),
                                Text(
                                  'Answer: ${_answers[index]}',
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
                  child: Image.asset(
                    'assets/faq.png', // Pfad zum PNG-Bild
                    width: 75,
                    height: 75,
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 25, bottom: 10, left: 40, right: 40),
                        child: Text(
                          'Contact Form',
                          style: TextStyle(fontSize: accessibilityMode ? 35 : 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(top: 5, bottom: 15, left: 40, right: 40),
                        child: Text(
                          "No sufficient help found? Feel free to contact us here.",
                          style: TextStyle(fontSize: accessibilityMode ? 35 : 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _messageController,
                        decoration: const InputDecoration(labelText: 'Message'),
                        maxLines: 4,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a message.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.black),
                        ),
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
