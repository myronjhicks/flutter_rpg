import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/theme.dart';

class Heart extends StatefulWidget {
  const Heart({super.key, required this.character});

  final Character character;

  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  //transition of size value of heart size
  //small to large and large to small for pulse effect
  //use Tween - represents the transition between two values
  late Animation _sizeAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _sizeAnimation = TweenSequence([
      TweenSequenceItem<double>(
        tween: Tween(
          begin: 25,
          end: 40,
        ),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween(
          begin: 40,
          end: 25,
        ),
        weight: 50,
      ),
    ]).animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return IconButton(
          icon: Icon(
            Icons.favorite,
            color: widget.character.isFav
                ? AppColors.primaryColor
                : Colors.grey[800],
            size: _sizeAnimation.value,
          ),
          onPressed: () {
            _controller.reset();
            _controller.forward();
            widget.character.toggleIsFav();
          },
        );
      },
    );
  }
}
