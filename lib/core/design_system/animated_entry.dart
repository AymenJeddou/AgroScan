import 'dart:async';

import 'package:flutter/material.dart';

class RevealOnLoad extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset offset;
  final Curve curve;

  const RevealOnLoad({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 520),
    this.offset = const Offset(0, 0.08),
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<RevealOnLoad> createState() => _RevealOnLoadState();
}

class _RevealOnLoadState extends State<RevealOnLoad> {
  bool _visible = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.delay, () {
      if (mounted) {
        setState(() => _visible = true);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: _visible ? Offset.zero : widget.offset,
      duration: widget.duration,
      curve: widget.curve,
      child: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: widget.duration,
        curve: widget.curve,
        child: widget.child,
      ),
    );
  }
}
