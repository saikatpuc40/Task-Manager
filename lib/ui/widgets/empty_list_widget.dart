import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/lotties/No-Data.json',
        width: 200,height: 200,fit: BoxFit.scaleDown);
  }
}
