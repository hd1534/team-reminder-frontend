import 'dart:developer' as developer;

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class OverlappingPanels extends StatelessWidget {
  Widget mainWidget;
  Widget? leftWidget;
  Widget? rightWidget;

  OverlappingPanels(
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
  // consts
  final _animateDuration = const Duration(milliseconds: 200);

  // var
  final _dx = 0.0.obs;
  double get dx => _dx.value;

  var _dragStartTimestamp = 0;

  //
  final double width;
  final double restWidth;
  final double leftEnd;
  final double rightEnd;
  final double baselineRatio;

  final bool hasLeftWidget;
  final bool hasRightWidget;

  /// milliseconds
  final int? quickTranslation;

  OverlappingPanesController({
    required this.width,
    required this.hasLeftWidget,
    required this.hasRightWidget,
    this.restWidth = 100,
    this.baselineRatio = 0.5,
    this.quickTranslation = 200,
  })  : leftEnd = -(width - restWidth),
        rightEnd = width - restWidth;

  late AnimationController _animationController;

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
    var duration = DateTime.now().millisecondsSinceEpoch - _dragStartTimestamp;
    double translateGoal = 0;

    // 기준점 이상 드래그 했거나, quickTranslation내 드래그한 경우 해당 방향으로
    if (dx.abs() > width * baselineRatio ||
        quickTranslation != null && duration < quickTranslation!) {
      translateGoal = dx < 0 ? leftEnd : rightEnd;
    }

    translate(dx, translateGoal);
  }

  void translate(double begin, double end) {
    // TODO: FIX: 애니메이션이 한번 동작하고 나선 안돌아감

    var animation = Tween(begin: begin, end: end).animate(_animationController);
    animation.addListener(() => _dx.value = animation.value);

    _animationController.forward();
  }

  @override
  void onInit() {
    super.onInit();

    _animationController =
        AnimationController(vsync: this, duration: _animateDuration);
  }

  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
  }
}
