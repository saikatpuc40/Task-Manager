import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/ui/utilities/asset_paths.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        SvgPicture.asset(AssetPaths.backgroundSvg,
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        child

      ],
    );
  }
}
