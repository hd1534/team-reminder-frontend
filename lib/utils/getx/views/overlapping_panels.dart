import 'package:flutter/material.dart';

import 'package:get/get.dart';

enum Side {
  left,
  main,
  right,
}

class OverlappingPanels extends StatelessWidget {
  final Widget mainWidget;
  final Widget? leftWidget;
  final Widget? rightWidget;

  /// A callback to notify when a panel reveal has completed.
  final ValueChanged<Side>? onSideChange;
  final ValueChanged<Side>? afterSideChanged;

  const OverlappingPanels({
    super.key,
    required this.mainWidget,
    this.leftWidget,
    this.rightWidget,
    this.onSideChange,
    this.afterSideChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GetX<OverlappingPanelsController>(
          init: OverlappingPanelsController(
            width: constraints.maxWidth,
            hasLeftWidget: leftWidget != null,
            hasRightWidget: rightWidget != null,
            onSideChange: onSideChange,
            afterSideChanged: afterSideChanged,
          ),
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

class OverlappingPanelsController extends GetxController
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
  var _currentSide = Side.main;
  Side get currentSide => _currentSide;

  /// milliseconds
  final int? quickTranslation;

  /// A callback to notify when a panel reveal has completed.
  final ValueChanged<Side>? onSideChange;
  final ValueChanged<Side>? afterSideChanged;

  OverlappingPanelsController({
    required this.width,
    required this.hasLeftWidget,
    required this.hasRightWidget,
    this.restWidth = 100,
    this.baselineRatio = 0.45,
    this.animateDuration = const Duration(milliseconds: 200),
    this.quickTranslation = 300,
    this.onSideChange,
    this.afterSideChanged,
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
    Side side = Side.main;
    var duration = DateTime.now().millisecondsSinceEpoch - _dragStartTimestamp;

    // 기준점 이상 드래그 했거나, quickTranslation내 드래그한 경우 해당 방향으로
    if (quickTranslation != null && duration < quickTranslation!) {
      var index = currentSide.index;
      var vX = details.primaryVelocity ?? 0;

      index += vX == 0
          ? 0
          : vX > 0
              ? -1
              : 1;

      side = index == Side.main.index
          ? Side.main
          : index < Side.main.index
              ? Side.left
              : Side.right;
    } else if (dx.abs() > width * baselineRatio) {
      side = dx < 0 ? Side.right : Side.left;
    }

    revealSide(side);
  }

  /// You can use revealSide like
  /// IconButton(
  ///   icon: const Icon(Icons.group),
  ///   onPressed: () =>
  ///       Get.find<OverlappingPanelsController>().revealSide(Side.right),
  /// )
  void revealSide(Side side) {
    // Check whether the side exists or not
    switch (side) {
      case Side.left:
        if (hasLeftWidget) {
          if (side == currentSide && dx == rightEnd) return;
          _currentSide = Side.left;
        }
        break;
      case Side.main:
        if (side == currentSide && dx == 0) return;
        _currentSide = Side.main;
        break;
      case Side.right:
        if (hasRightWidget) {
          if (side == currentSide && dx == leftEnd) return;
          _currentSide = Side.right;
        }
        break;
      default:
        throw Exception("There's no matching side");
    }

    if (onSideChange != null) {
      onSideChange!(currentSide);
    }

    // translate
    switch (currentSide) {
      case Side.left:
        translate(dx, rightEnd);
        break;
      case Side.main:
        translate(dx, 0);
        break;
      case Side.right:
        translate(dx, leftEnd);
        break;
    }
  }

  void translate(double begin, double end) {
    _animation = Tween(begin: begin, end: end).animate(_animationController);

    _animationController
      ..removeListener(_setDxWithAnimationValue)
      ..removeStatusListener(_onAnimationStatusChange);

    _animation!
      ..addListener(_setDxWithAnimationValue)
      ..addStatusListener(_onAnimationStatusChange);

    _animationController.reset();
    _animationController.forward();
  }

  /// _animation must not be null
  void _setDxWithAnimationValue() {
    _dx.value = _animation!.value;
  }

  void _onAnimationStatusChange(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.completed:
        if (afterSideChanged != null) {
          afterSideChanged!(_currentSide);
        }
        break;
      default:
    }
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
