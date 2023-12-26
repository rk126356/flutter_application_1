import 'package:flutter/material.dart';

Widget buildUserInfo(String label, String value) {
  return ListTile(
    title: Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
    ),
    subtitle: Text(
      value,
      style: const TextStyle(color: Colors.grey),
    ),
  );
}
