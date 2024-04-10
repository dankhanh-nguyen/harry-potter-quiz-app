
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/app_quiz.dart';
import 'package:quiz_app/models/state.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'questions.dart';
import 'state_test.mocks.dart';

void main() {

  final client = MockClient();

  when(client.get(Uri.parse('https://stevecassidy.github.io/harry-potter-quiz-app/lib/data/questions.json')))
      .thenAnswer((_) async => http.Response(jsonEncode(questionsJson), 200));

  testWidgets('Main App interaction', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    
    await tester.pumpWidget(ChangeNotifierProvider(
         create: (context) => StateModel(client),
         child: const Quiz(),
    ));

    // should start showing the home screen
    final titleFinder = find.text("Harry Potter Quiz App");
    final startFinder = find.text("Start the Quiz");

    expect(titleFinder, findsOneWidget);
    expect(startFinder, findsOneWidget);

    // tap the start button and we should move to the quiz
    await tester.tap(startFinder);

    await tester.pump();

    // verify we're on the question screen by text
    final questionFinder = find.text("Question 1");
    expect(questionFinder, findsOneWidget);

    // or by looking for a widget key
    final questionTextFinder = find.byKey(const Key('question-text'));
    expect(questionTextFinder, findsOneWidget);
  });

  // Test whole progress through the quiz
    // Finding answer button on each question screen and tapping it
    // Verify results screen is shown

  testWidgets('Quiz progress', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    
    await tester.pumpWidget(ChangeNotifierProvider(
         create: (context) => StateModel(client),
         child: const Quiz(),
    ));

    final startFinder = find.text("Start the Quiz");
    expect(startFinder, findsOneWidget);

    // tap the start button and move to the quiz
    await tester.tap(startFinder);

    await tester.pump();

    // verify we're on the question 1 screen by text
    final questionFinder = find.text("Question 1");
    expect(questionFinder, findsOneWidget);

    // tap answer to move on to question 2
    final answerFinder = find.text("Hedwig");
    await tester.tap(answerFinder);

    await tester.pump();

    // verify we're on the question 2 screen by text
    final questionFinder2 = find.text("Question 2");
    expect(questionFinder2, findsOneWidget);

    // tap answer to move on to question 2
    final answerFinder2 = find.text("Hogwarts Express");
    await tester.tap(answerFinder2);

    await tester.pump();

    // verify we're on the question 3 screen by text
    final questionFinder3 = find.text("Question 3");
    expect(questionFinder3, findsOneWidget);

    // tap answer to move on to question 3
    final answerFinder3 = find.text("Pensieve");
    await tester.tap(answerFinder3);

    await tester.pump();

    // verify we're on the question 4 screen by text
    final questionFinder4 = find.text("Question 4");
    expect(questionFinder4, findsOneWidget);

    // tap answer to move on to question 4
    final answerFinder4 = find.text("Quidditch");
    await tester.tap(answerFinder4);

    await tester.pump();

    // verify we're on the question 5 screen by text
    final questionFinder5 = find.text("Question 5");
    expect(questionFinder5, findsOneWidget);

    // tap answer to move on to question 5
    final answerFinder5 = find.text("Gringotts");
    await tester.tap(answerFinder5);

    await tester.pump();
    
    // verify we're on the question 6 screen by text
    final questionFinder6 = find.text("Question 6");
    expect(questionFinder6, findsOneWidget);

    // tap answer to move on to question 6
    final answerFinder6 = find.text("Platform 9¾");
    await tester.tap(answerFinder6);

    await tester.pump();

    // verify we're on results screen
    final restartFinder = find.text("Restart Quiz");
    expect(restartFinder, findsOneWidget);

  }); 
}
