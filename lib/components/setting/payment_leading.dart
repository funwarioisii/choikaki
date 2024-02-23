import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const paymentUrl = 'https://blog.funwarioisii.me/article/5';

class PaymentLeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const Center(
            child: Icon(
              Icons.lock_outline,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16.0),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'プレミアムにアップグレードすると、カラーを変更したり、壁紙を設定できるようになります。'
                      'アップグレードする方法は',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'こちら',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final url = Uri.parse(paymentUrl);
                      await launchUrl(url);
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
