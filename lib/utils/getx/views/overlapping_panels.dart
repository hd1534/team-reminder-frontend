import 'package:flutter/material.dart';

import 'package:get/get.dart';

enum CurrentSide {
  left,
  main,
  right,
}

class OverlappingPanels extends StatelessWidget {
  final Widget mainWidget;
  final Widget? leftWidget;
  final Widget? rightWidget;

  const OverlappingPanels(
      {super.key, required this.mainWidget, this.leftWidget, this.rightWidget});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GetX<OverlappingPanesController>(
          init: OverlappingPanesController(
              width: constraints.maxWidth,
              hasLeftWidget: leftWidget != null,
              hasRightWidget: rightWidget != null),
          builder: (_) {
            return Stack(children: [
              Offstage(
                offstage: _.dx <= 0,
                child: leftWidget,
              ),
              Offstage(
                offstage: _.dx >= 0,
                child: rightWidget,
              ),
              Transform.translate(
                offset: Offset(_.dx, 0),
                child: mainWidget,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onHorizontalDragStart: _.onHorizontalDragStart,
                onHorizontalDragUpdate: _.onHorizontalDragUpdate,
                onHorizontalDragEnd: _.onHorizontalDragEnd,
              ),
            ]);
          });
    });
  }
}

class OverlappingPanesController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // var
  final _dx = 0.0.obs;
  double get dx => _dx.value;

  var _dragStartTimestamp = 0;
  Animation? _animation;
  late AnimationController _animationController;

  //
  final double width;
  final double restWidth;
  final double leftEnd;
  final double rightEnd;
  final double baselineRatio;
  final Duration animateDuration;

  final bool hasLeftWidget;
  final bool hasRightWidget;
  var _currentSide = CurrentSide.main;
  CurrentSide get currentSide => _currentSide;

  /// milliseconds
  final int? quickTranslation;

  OverlappingPanesController({
    required this.width,
    required this.hasLeftWidget,
    required this.hasRightWidget,
    this.restWidth = 100,
    this.baselineRatio = 0.45,
    this.animateDuration = const Duration(milliseconds: 200),
    this.quickTranslation = 300,
  })  : leftEnd = -(width - restWidth),
        rightEnd = width - restWidth;

  void onHorizontalDragStart(DragStartDetails details) {
    _dragStartTimestamp = DateTime.now().millisecondsSinceEpoch;
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    var nextDx = _dx.value + details.delta.dx;
    if (leftEnd < nextDx &&
        nextDx < rightEnd &&
        (nextDx < 0 && hasRightWidget || nextDx > 0 && hasLeftWidget)) {
      _dx.value = nextDx;
    }
  }

  void onHorizontalDragEnd(DragEndDetails details) {
    var translateGoal = 0.0;
    var vX = details.primaryVelocity!;
    var duration = DateTime.now().millisecondsSinceEpoch - _dragStartTimestamp;

    // 기준점 이상 드래그 했거나, quickTranslation내 드래그한 경우 해당 방향으로
    if (quickTranslation != null && duration < quickTranslation!) {
      var index = currentSide.index;
      index += vX == 0
          ? 0
          : vX > 0
              ? -1
              : 1;

      translateGoal = index == CurrentSide.main.index
          ? 0
          : index > CurrentSide.main.index
              ? leftEnd
              : rightEnd;
    } else if (dx.abs() > width * baselineRatio) {
      translateGoal = dx < 0 ? leftEnd : rightEnd;
    }

    _currentSide = translateGoal == 0
        ? CurrentSide.main
        : translateGoal > 0
            ? CurrentSide.left
            : CurrentSide.right;

    translate(dx, translateGoal);
  }

  void translate(double begin, double end) {
    _animation = Tween(begin: begin, end: end).animate(_animationController);

    _animationController.removeListener(_setDxWithAnimationValue);
    _animation!.addListener(_setDxWithAnimationValue);

    _animationController.reset();
    _animationController.forward();
  }

  /// _animation must not be null
  void _setDxWithAnimationValue() {
    _dx.value = _animation!.value;
  }

  @override
  void onInit() {
    super.onInit();
    _animationController =
        AnimationController(vsync: this, duration: animateDuration);
  }

  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
  }
}
