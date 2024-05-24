import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_agency/tax_hiring_module/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';
//import 'package:travel_agency/tax_hiring_module/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';

import 'fade_in_animation_controller.dart';

class TFadeInAnimation extends StatelessWidget {
  TFadeInAnimation({
    super.key,
    required this.durationInMs,
    this.animate,
    required this.child,
  });

  final controller = Get.put(FadeInAnimationController());
  final int durationInMs;
  final TAnimationPosition? animate;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedPositioned(
        duration: const Duration(milliseconds: 1600),
        top: controller.animate.value ? animate!.topAfter : animate!.topBefore,
        left:
            controller.animate.value ? animate!.leftAfter : animate!.leftBefore,
        bottom: controller.animate.value
            ? animate!.bottomAfter
            : animate!.bottomBefore,
        right: controller.animate.value
            ? animate!.rightAfter
            : animate!.rightBefore,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 1600),
          opacity: controller.animate.value ? 1 : 0,
          child: child,
        ),
      ),
    );
  }
}
