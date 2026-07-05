import 'package:flutter/material.dart';
import 'package:modern_calculator/breakpoints/app_breakpoints.dart';
import 'package:modern_calculator/models/caracteres.dart';
import 'package:modern_calculator/widgets/button.dart';

class ButtonGrid extends StatelessWidget {
  final void Function({required int index}) onTapButton;
  final List<Caracter> caracters;

  const ButtonGrid({
    required this.onTapButton,
    required this.caracters,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constaints) {
        final height = constaints.maxHeight;
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: height < AppBreakpoints.height ? 1.4 : 1.0,
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: caracters.length,
          itemBuilder: (context, index) {
            final caracter = caracters[index].caracter;
            final isNumber = caracters[index].isNumber;
            return Padding(
              padding: const EdgeInsets.all(4),
              child: Draggable<int>(
                data: index,
                feedback: Button(
                  text: caracter,
                  check: isNumber,
                  onTap: () => ()
                ),
                childWhenDragging: Button(
                  text: "",
                  check: false,
                  onTap: func
                ),
                child: Button(
                  text: caracter,
                  check: isNumber,
                  onTap: () => onTapButton(index: index)
                )
              )
            );
          }
        );
      }
    );
  }
}

void func(){}