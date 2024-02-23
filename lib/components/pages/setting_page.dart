import 'package:choikaki/components/setting/color_setting_modal.dart';
import 'package:choikaki/components/setting/enable_premium_modal.dart';
import 'package:choikaki/service/premium.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SettingPage extends HookWidget {
  final void Function() toHomePage;

  const SettingPage({super.key, required this.toHomePage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          MenuItem(
            title: 'カラーの設定',
            icon: const Icon(Icons.color_lens),
            modal: ColorSettingModal(toHomePage: toHomePage),
          ),
          const MenuItem(
            title: 'コードを入力する',
            icon: Icon(Icons.star),
            modal: EnablePremiumModal(),
          ),
          GestureDetector(
            onTap: toHomePage,
            child: const ListTile(
              leading: Icon(Icons.arrow_back),
              title: Text('戻る'),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final Icon icon;
  final String title;
  final Widget modal;

  const MenuItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.modal});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return modal;
          },
        );
      },
      onLongPress: () async {
        await setPremium(false);

        // snackbar を出して、プレミアムを解除したことをユーザーに伝える
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('プレミアムを解除しました'),
          ),
        );
      },
      child: ListTile(
        leading: icon,
        title: Text(title),
      ),
    );
  }
}
