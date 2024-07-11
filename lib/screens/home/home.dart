import 'package:flutter/material.dart';
import 'package:flutter_rpg/screens/create/create_screen.dart';
import 'package:flutter_rpg/screens/home/character_card.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Your Characters'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Consumer<CharacterStore>(builder: (context, store, child) {
                return ListView.builder(
                  itemCount: store.characters.length,
                  itemBuilder: (_, index) {
                    return CharacterCard(store.characters[index]);
                  },
                );
              }),
            ),
            StyledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const CreateScreen(),
                  ),
                );
              },
              child: const StyledHeadline('Create new'),
            )
          ],
        ),
      ),
    );
  }
}
