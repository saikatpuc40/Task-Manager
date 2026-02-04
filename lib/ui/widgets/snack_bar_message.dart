import 'package:flutter/material.dart';

void showSnackBarMessage(
    BuildContext context,
    String Message,
    [ bool isError = false,]){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(Message),
            backgroundColor: isError ? Colors.red : null,
        ),
    );

}