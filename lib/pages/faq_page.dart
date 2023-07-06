import 'package:flutter/material.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
      routes: {
        '/faq': (context) => FAQPage(),
        // Weitere Routen hier hinzufügen
      },
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Willkommen zur Homepage!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('FAQ'),
              onPressed: () {
                Navigator.pushNamed(context, '/faq');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  final List<QuestionAnswer> faqList = [
    QuestionAnswer(
      question: 'Frage 1',
      answer: 'Antwort 1',
    ),
    QuestionAnswer(
      question: 'Frage 2',
      answer: 'Antwort 2',
    ),
    // Weitere Fragen und Antworten hier hinzufügen
  ];

  List<QuestionAnswer> userQuestions = [];

  void askQuestion(String question) {
    setState(() {
      userQuestions.add(QuestionAnswer(
        question: question,
        answer: '',
      ));
    });
  }

  void answerQuestion(int index, String answer) {
    setState(() {
      userQuestions[index] = userQuestions[index].copyWith(answer: answer);
    });
  }

  void openChatBot() {
    showDialog(
      context: context,
      builder: (context) {
        String userQuestion = '';

        return AlertDialog(
          title: Text('Hilfe-Bot'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Wie kann ich dir helfen?'),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  userQuestion = value;
                },
                decoration: InputDecoration(
                  hintText: 'Frage eingeben',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Schließen'),
            ),
            TextButton(
              onPressed: () {
                askQuestion(userQuestion);
                Navigator.pop(context);
              },
              child: Text('Frage stellen'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 80,
        title: Row(
          children: [
            Image.asset(
              'assets/app_icon_inverted.png',
              width: 75,
              height: 75,
            ),
            SizedBox(width: 20),
            Text('About', style: TextStyle(fontSize: 30, color: Colors.white)),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: faqList.length + userQuestions.length,
              itemBuilder: (context, index) {
                if (index < faqList.length) {
                  return ListTile(
                    title: Text(faqList[index].question),
                    subtitle: Text(faqList[index].answer),
                  );
                } else {
                  int userQuestionIndex = index - faqList.length;
                  return ListTile(
                    title: Text(userQuestions[userQuestionIndex].question),
                    subtitle: Text(userQuestions[userQuestionIndex].answer),
                    trailing: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            String answer = '';

                            return AlertDialog(
                              title: Text('Frage beantworten'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(userQuestions[userQuestionIndex].question),
                                  SizedBox(height: 20),
                                  TextField(
                                    onChanged: (value) {
                                      answer = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Antwort eingeben',
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Abbrechen'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    answerQuestion(userQuestionIndex, answer);
                                    Navigator.pop(context);
                                  },
                                  child: Text('Antworten'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Antworten'),
                    ),
                  );
                }
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Aktion für den Kontaktformular-Button implementieren
            },
            child: Text('Kontaktformular'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              openChatBot();
            },
            child: Text('Hilfe-Bot'),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

class QuestionAnswer {
  final String question;
  final String answer;

  QuestionAnswer({
    required this.question,
    required this.answer,
  });

  QuestionAnswer copyWith({
    String? question,
    String? answer,
  }) {
    return QuestionAnswer(
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }
}
