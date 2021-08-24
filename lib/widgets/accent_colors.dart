import 'package:flutter/material.dart';
import 'package:picsplash/utils/my_state.dart';
import 'package:provider/provider.dart';

class AccentColors extends StatelessWidget {
  const AccentColors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accentState = Provider.of<ThemeState>(context);
    return Dialog(
      child: ListView.builder(
          itemCount: 6,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTileTheme(
              selectedColor: Theme.of(context).accentColor,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: accentState.accentColors[index],
                ),
                title: accentState.accentTexts[index],
                selected: index == accentState.currentAccentIndex,
                onTap: () {
                  accentState.changeAccent(index);
                  Navigator.pop(context);
                },
              ),
            );
          }),
    );
  }
}
