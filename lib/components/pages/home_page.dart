import 'package:choikaki/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  final void Function() toSettingPage;

  const HomePage({super.key, required this.toSettingPage});

  @override
  Widget build(BuildContext context, ref) {
    final text = useState<String>('');
    final theme = ref.watch(currentThemeProvider);

    Future<void> copyToClipboard() async {
      final data = ClipboardData(text: text.value);
      await Clipboard.setData(data);
    }

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 20,
            decoration: const InputDecoration(
              hintText: "ちょいっと書く ✍️",
            ),
            onChanged: (value) {
              text.value = value;
            },
            autofocus: true,
          ),
        ),
        floatingActionButton: InkWell(
          onLongPress: toSettingPage,
          child: FloatingActionButton(
            onPressed: copyToClipboard,
            backgroundColor: theme.primaryColor,
            child: const Icon(
              Icons.copy,
              color: Colors.white70,
            ),
          ),
        ));
  }
}
