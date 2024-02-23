import 'package:choikaki/components/pages/home_page.dart';
import 'package:choikaki/components/pages/setting_page.dart';
import 'package:choikaki/service/premium.dart';
import 'package:choikaki/service/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: ChoikakiApp()));
}

class CurrentTheme extends StateNotifier<ChoikakiTheme> {
  CurrentTheme() : super(defaultTheme);

  void setTheme(ChoikakiTheme theme) {
    state = theme;
  }
}

final currentThemeProvider =
    StateNotifierProvider<CurrentTheme, ChoikakiTheme>((_) => CurrentTheme());

enum Page {
  home,
  settings,
}

class ChoikakiApp extends HookConsumerWidget {
  const ChoikakiApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final displayedPage = useState<Page>(Page.home);

    void toSettingPage() {
      displayedPage.value = Page.settings;
    }

    void toHomePage() {
      displayedPage.value = Page.home;
    }

    useEffect(() {
      () async {
        final isps = await isPremium();
        if (isps) {
          final theme = await getTheme();
          ref.read(currentThemeProvider.notifier).setTheme(theme);
        }
      }();
      return null;
    }, const []);

    return MaterialApp(
      title: 'Choikaki',
      home: switch (displayedPage.value) {
        Page.home => HomePage(toSettingPage: toSettingPage),
        Page.settings => SettingPage(toHomePage: toHomePage),
      },
    );
  }
}
