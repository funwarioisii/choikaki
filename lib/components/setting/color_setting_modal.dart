import 'package:choikaki/components/setting/payment_leading.dart';
import 'package:choikaki/main.dart';
import 'package:choikaki/service/premium.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ColorSettingModal extends HookConsumerWidget {
  final void Function() toHomePage;

  const ColorSettingModal({super.key, required this.toHomePage});

  @override
  Widget build(BuildContext context, ref) {
    final primaryColor = ref.watch(currentThemeProvider).primaryColor;
    final isps = useState(false);

    void updatePrimaryColor(Color color) {
      final oldTheme = ref.read(currentThemeProvider);
      final newTheme = oldTheme.copyWith(primaryColor: color);
      ref.read(currentThemeProvider.notifier).setTheme(newTheme);
    }

    useEffect(() {
      () async {
        isps.value = await isPremium();
      }();
      return null;
    }, const []);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.width * 0.95,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isps.value
            ? Column(
                children: [
                  ColorPicker(
                    positionLabel: 'ボタンの色',
                    defaultColor: primaryColor,
                    onColorChanged: updatePrimaryColor,
                  ),
                ],
              )
            : const PaymentLeading(),
      ),
    );
  }
}

class ColorPicker extends HookConsumerWidget {
  final String positionLabel;
  final Color defaultColor;
  final void Function(Color) onColorChanged;

  const ColorPicker(
      {super.key,
      required this.positionLabel,
      required this.defaultColor,
      required this.onColorChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = useState<Color>(defaultColor);

    void saveColor() {
      onColorChanged(color.value);
    }

    return Row(
      children: [
        SizedBox(
          width: 300,
          child: Row(
            children: [
              Text(positionLabel),
              const SizedBox(width: 8),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: color.value,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 150,
                child: TextField(onChanged: (value) {
                  if (value.length == 6) {
                    final r = int.parse(value.substring(0, 2), radix: 16);
                    final g = int.parse(value.substring(2, 4), radix: 16);
                    final b = int.parse(value.substring(4, 6), radix: 16);
                    color.value = Color.fromRGBO(r, g, b, 1);
                  }
                }),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: saveColor,
          child: const Text('保存'),
        ),
      ],
    );
  }
}
