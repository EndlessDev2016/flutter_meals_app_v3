import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.onSelectScreen,
  });

  final void Function(String identifier) onSelectScreen;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(children: [
              Icon(
                Icons.fastfood,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 10),
              Text(
                'Cooking Up!',

                /// FlutterのThemeは、アプリ全体の見た目を変更することができるウィジェットです。
                /// Theme.of(context)は、指定されたコンテキストの親ウィジェットが持つテーマを取得します。
                ///
                /// copyWith()は、既存のテーマのプロパティを変更して新しいテーマを作成するために使用されます。
                /// この場合、textTheme.titleLargeは、テキストの大きな見出し用のテキストテーマです。
                /// この見出しの色を colorScheme.primary（プライマリーカラー）に変更し、太字のフォントウェイトに変更しています。
                /// このように、既存のテーマをコピーして変更を加えることで、アプリのテーマの見た目をカスタマイズすることができます。
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ]),
          ),
          ListTile(
            title: Text(
              'Meals',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            leading: Icon(
              Icons.restaurant,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            onTap: () {
              onSelectScreen('meals');
            },
          ),
          ListTile(
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            leading: Icon(
              Icons.settings,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            onTap: () {
              onSelectScreen('filters');
            },
          ),
        ],
      ),
    );
  }
}
