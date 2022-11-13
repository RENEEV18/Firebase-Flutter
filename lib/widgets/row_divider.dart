import 'package:flutter/material.dart';

class RowDivider extends StatelessWidget {
  const RowDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Divider(),
        Text('or'),
        Divider(),
      ],
    );
  }
}
