import 'package:flutter/material.dart';

//Additional Information
class AdditionalInformation extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const AdditionalInformation({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(onPressed: () {}, icon: Icon(icon), iconSize: 42),
        SizedBox(height: 5),
        Text(label, style: TextStyle(fontSize: 15)),
        SizedBox(height: 12),
        Text(value, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}
