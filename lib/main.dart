import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const ChoikakiApp());
}

class ChoikakiApp extends StatelessWidget {
  const ChoikakiApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Choikaki',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Page());
  }
}

class Page extends HookWidget {
  const Page({super.key});

  @override
  Widget build(BuildContext context) {
    final text = useState<String>('こんにちは');

    Future<void> copyToClipboard() async {
      final data = ClipboardData(text: text.value);
      await Clipboard.setData(data);
    }

    return Scaffold(
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 20,
            decoration: InputDecoration(
              hintText: "ちょいっと書く ✍️",
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: copyToClipboard,
          child: const Icon(Icons.copy),
        ));
  }
}
