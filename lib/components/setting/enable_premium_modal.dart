import 'package:choikaki/service/premium.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const secretCode = String.fromEnvironment('PAYMENT_SECRET_CODE');

bool validateCode(String code) => code == secretCode;

class EnablePremiumModal extends HookWidget {
  const EnablePremiumModal({super.key});

  @override
  Widget build(BuildContext context) {
    final code = useState<String>('');
    final isps = useState<bool>(false);

    Future<void> handleButtonOnClick() async {
      await setPremium(true);
      isps.value = await isPremium();
    }

    useEffect(() {
      void checkIsps() async {
        final result = await isPremium();
        isps.value = result;
      }

      checkIsps();

      return;
    }, [
      isps,
    ]);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.width * 0.95,
      child: isps.value
          ? const Padding(
              padding: EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0),
              child: Text('ご購入ありがとうございました！\n壁紙やカラーを設定できるようになりました！',
                  style: TextStyle(fontSize: 16)),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('コードを入力するとデコレーション機能が使えるようになります。'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        code.value = value;
                      },
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'コードを入力してください',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed:
                          validateCode(code.value) ? handleButtonOnClick : null,
                      child: const Text('有効化する'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
