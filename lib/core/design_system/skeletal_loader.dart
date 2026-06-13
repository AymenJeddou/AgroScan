import 'package:flutter/material.dart';

class SkeletalLoader extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SkeletalLoader({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  State<SkeletalLoader> createState() => _SkeletalLoaderState();
}

class _SkeletalLoaderState extends State<SkeletalLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.4,
      end: 0.8,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
      ),
    );
  }
}

class SkeletalListLoader extends StatelessWidget {
  const SkeletalListLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
          ),
          child: Row(
            children: [
              const SkeletalLoader(width: 90, height: 90, borderRadius: 12),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SkeletalLoader(
                      width: 60,
                      height: 16,
                      borderRadius: 6,
                    ),
                    const SizedBox(height: 8),
                    const SkeletalLoader(
                      width: 140,
                      height: 20,
                      borderRadius: 6,
                    ),
                    const SizedBox(height: 6),
                    const SkeletalLoader(
                      width: 100,
                      height: 14,
                      borderRadius: 6,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: const [
                        SkeletalLoader(width: 50, height: 16, borderRadius: 8),
                        SizedBox(width: 8),
                        SkeletalLoader(width: 50, height: 16, borderRadius: 8),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SkeletalGridLoader extends StatelessWidget {
  const SkeletalGridLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 6,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.60,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                child: SkeletalLoader(
                  width: double.infinity,
                  height: 110,
                  borderRadius: 0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SkeletalLoader(width: 120, height: 14, borderRadius: 6),
                    SizedBox(height: 6),
                    SkeletalLoader(width: 90, height: 12, borderRadius: 6),
                    SizedBox(height: 10),
                    SkeletalLoader(
                      width: double.infinity,
                      height: 10,
                      borderRadius: 6,
                    ),
                    SizedBox(height: 6),
                    SkeletalLoader(width: 140, height: 10, borderRadius: 6),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
