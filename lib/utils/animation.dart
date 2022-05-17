import 'package:flutter/material.dart';

enum AnimationType {
  slideAnimation,
}

class CustomAnimation extends StatefulWidget {
  final Widget child;
  final Duration? duration;
  final Tween<Offset>? offset;
  final AnimationType animationType;

  const CustomAnimation({
    required this.child,
    this.duration = const Duration(seconds: 1),
    this.offset,
    required this.animationType,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomAnimation> createState() => CustomAnimationState();
}

class CustomAnimationState extends State<CustomAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    if (widget.animationType == AnimationType.slideAnimation) {
      _slideAnimation = widget.offset!.animate(_animationController);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _getAnimation(widget.animationType);
  }

  void changeAnimation(bool reverseAnimation) {
    if (!reverseAnimation) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  _getAnimation(AnimationType _animationType) {
    switch (_animationType) {
      case AnimationType.slideAnimation:
        return SlideTransition(
          position: _slideAnimation!,
          child: widget.child,
        );
    }
  }
}
