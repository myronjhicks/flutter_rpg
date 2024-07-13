import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/screens/profile/skill_list.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';

class StatsTable extends StatefulWidget {
  const StatsTable(this.character, {super.key});

  final Character character;

  @override
  State<StatsTable> createState() => _StatsTableState();
}

class _StatsTableState extends State<StatsTable> {
  double turns = 0.0;

  @override
  Widget build(BuildContext context) {
    final Character character = widget.character;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          //available points
          Container(
            color: AppColors.secondaryColor,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                AnimatedRotation(
                  turns: turns,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    Icons.star,
                    color: character.points > 0 ? Colors.yellow : Colors.grey,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const StyledText('Stat points available:'),
                const Expanded(
                  child: SizedBox(
                    width: 20,
                  ),
                ),
                StyledHeadline(character.points.toString())
              ],
            ),
          ),
          //stats table
          Table(
            children: character.statsAsFormattedList.map((stat) {
              return TableRow(
                decoration: BoxDecoration(
                    color: AppColors.secondaryColor.withOpacity(0.5)),
                children: [
                  //stat title
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: StyledHeadline(stat['title']!),
                    ),
                  ),
                  //state vaule
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: StyledHeadline(stat['value']!),
                    ),
                  ),
                  //increase stat icon
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_upward,
                        color: AppColors.textColor,
                      ),
                      onPressed: () {
                        setState(() {
                          character.increaseStats(stat['title']!);
                          turns += 0.5;
                        });
                      },
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_downward,
                        color: AppColors.textColor,
                      ),
                      onPressed: () {
                        setState(() {
                          character.decreaseStats(stat['title']!);
                          turns -= 0.5;
                        });
                      },
                    ),
                  ),
                  // TableCell(child: child),
                ],
              );
            }).toList(),
          ),

          SkillList(character)
        ],
      ),
    );
  }
}
