import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/screens/create/vocation_card.dart';
import 'package:flutter_rpg/screens/home/home.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateState();
}

class _CreateState extends State<CreateScreen> {
  final _nameController = TextEditingController();
  final _sloganController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _sloganController.dispose();
    super.dispose();
  }

  Vocation selectedVocation = Vocation.junkie;

  void updateVocation(Vocation vocation) {
    setState(() {
      selectedVocation = vocation;
    });
  }

  void showAlert(String alertTitle, String description) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: StyledHeadline(
            alertTitle,
          ),
          content: StyledText(
            description,
          ),
          actions: [
            StyledButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const StyledHeadline('Close'),
            )
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }

  void handleSubmit() {
    if (_nameController.text.trim().isEmpty) {
      showAlert(
        'Missing Character Name.',
        'Every good rpg character needs a great name.',
      );
      return;
    }
    if (_sloganController.text.trim().isEmpty) {
      showAlert(
        'Missing Character Slogan.',
        'Remember to add a slogan...',
      );
      return;
    }

    Provider.of<CharacterStore>(context, listen: false).addCharacter(Character(
      name: _nameController.text.trim(),
      slogan: _sloganController.text.trim(),
      vocation: selectedVocation,
      id: uuid.v4(),
    ));

    Navigator.push(context, MaterialPageRoute(builder: (ctx) => const Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Character Creation'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Icon(
                  Icons.code,
                  color: AppColors.primaryColor,
                ),
              ),
              const Center(
                child: StyledHeadline('Welcome new player'),
              ),
              const Center(
                child:
                    StyledText('Create a name and slogan for your character'),
              ),
              const SizedBox(
                height: 30,
              ),
              //input form
              TextField(
                controller: _nameController,
                style: GoogleFonts.kanit(
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
                cursorColor: AppColors.textColor,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_2),
                  label: StyledText('Character Name'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _sloganController,
                style: GoogleFonts.kanit(
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
                cursorColor: AppColors.textColor,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.chat),
                  label: StyledText('Character Slogan'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              // select vocation title
              Center(
                child: Icon(
                  Icons.code,
                  color: AppColors.primaryColor,
                ),
              ),
              const Center(
                child: StyledHeadline('Choose a vocation'),
              ),
              const Center(
                child: StyledText('This determines your available skills.'),
              ),
              const SizedBox(
                height: 30,
              ),

              VocationCard(
                onTap: updateVocation,
                vocation: Vocation.junkie,
                selected: selectedVocation == Vocation.junkie,
              ),
              VocationCard(
                onTap: updateVocation,
                vocation: Vocation.ninja,
                selected: selectedVocation == Vocation.ninja,
              ),
              VocationCard(
                onTap: updateVocation,
                vocation: Vocation.raider,
                selected: selectedVocation == Vocation.raider,
              ),
              VocationCard(
                onTap: updateVocation,
                vocation: Vocation.wizard,
                selected: selectedVocation == Vocation.wizard,
              ),

              Center(
                child: Icon(
                  Icons.code,
                  color: AppColors.primaryColor,
                ),
              ),
              const Center(
                child: StyledHeadline('Good luck'),
              ),
              const Center(
                child: StyledText('And enjoy the journey...'),
              ),
              const SizedBox(
                height: 30,
              ),

              Center(
                child: StyledButton(
                  onPressed: handleSubmit,
                  child: const StyledHeadline('Create Character'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
