import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';

class DatingCard extends StatefulWidget {
  final User user;
  final bool isFront;
  final Function(User) onSwipe;
  const DatingCard(
      {Key? key,
      required this.user,
      required this.isFront,
      required this.onSwipe})
      : super(key: key);

  @override
  State<DatingCard> createState() => _DatingCardState();
}

class _DatingCardState extends State<DatingCard> {
  int currentImageIndex = 0;
  double angle = 0;
  Size screenSize = Size.zero;
  bool shouldItemRemoved = false;
  Offset currentUserCardPosition = Offset.zero;

  onPanStart(DragStartDetails detail) {}

  onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0 || details.delta.dy < 0) {
      shouldItemRemoved = false;
      return;
    }

    shouldItemRemoved = true;
    currentUserCardPosition += details.delta;
    angle = 45 * currentUserCardPosition.dx / screenSize.width;

    setState(() {});
  }

  onPanEnd(DragEndDetails details) {
    angle = 0;
    currentUserCardPosition = Offset.zero;
    if (shouldItemRemoved) {
      widget.onSwipe.call(widget.user);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      screenSize = MediaQuery.of(context).size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.isFront
        ? GestureDetector(
            onPanStart: onPanStart,
            onPanUpdate: onPanUpdate,
            onPanEnd: onPanEnd,
            child: LayoutBuilder(builder: (context, constraints) {
              final tempAngle = angle * pi / 180;
              final rotationMatrix = Matrix4.identity()
                ..translate(
                  constraints.smallest.center(Offset.zero).dx,
                  constraints.smallest.center(Offset.zero).dy,
                )
                ..rotateZ(tempAngle)
                ..translate(
                  -constraints.smallest.center(Offset.zero).dx,
                  -constraints.smallest.center(Offset.zero).dy,
                );

              return AnimatedContainer(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF3A3A3A),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.user.images?[currentImageIndex] ?? "",
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                duration: const Duration(seconds: 0),
                transform: rotationMatrix
                  ..translate(
                      currentUserCardPosition.dx, currentUserCardPosition.dy),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [
                            0.2,
                            0.9,
                          ],
                          colors: <Color>[
                            Colors.transparent,
                            Colors.black,
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          if (currentImageIndex == 0) {
                            return;
                          }
                          setState(() {
                            currentImageIndex--;
                          });
                        },
                        child: const SizedBox(
                          height: 300,
                          width: 150,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          if (currentImageIndex + 1 ==
                              (widget.user.images?.length ?? 0)) {
                            return;
                          }
                          setState(() {
                            currentImageIndex++;
                          });
                        },
                        child: const SizedBox(
                          height: 300,
                          width: 150,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                            widget.user.images?.length ?? 1,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 2.5,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: index == currentImageIndex
                                    ? const Color(0xFFFF0E73)
                                    : Colors.black,
                              ),
                              height: 3,
                              width: 56,
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 15),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xff202020),
                              ),
                              color: const Color(0xff000000),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const ImageIcon(
                                  AssetImage(
                                    "assets/icons/star_icon.png",
                                  ),
                                  color: Color(0xFF262626),
                                  size: 18,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.user.likeCount?.toString() ?? "-",
                                  style: const TextStyle(
                                    fontFamily: 'Pretendard',
                                    letterSpacing: -0.6,
                                    color: Color(0xffFCFCFC),
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                widget.user.name ?? "",
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontFamily: 'Pretendard',
                                  letterSpacing: -0.6,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFFCFCFC),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.user.age?.toString() ?? "",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xFFFCFCFC),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: currentImageIndex == 0
                                    ? locationWidget
                                    : currentImageIndex == 1
                                        ? descriptionWidget
                                        : tagsWidget,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (Rect bounds) =>
                                    const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xFF45FFF4),
                                    Color(0xFF7000FF),
                                  ],
                                ).createShader(bounds),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Icon(
                                    Icons.favorite,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.chevron_down,
                                color: Colors.white,
                                size: 20,
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
          )
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF3A3A3A),
              ),
              image: DecorationImage(
                image: NetworkImage(
                  widget.user.images?[currentImageIndex] ?? "",
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.2,
                        0.9,
                      ],
                      colors: <Color>[
                        Colors.transparent,
                        Colors.black,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      if (currentImageIndex == 0) {
                        return;
                      }
                      setState(() {
                        currentImageIndex--;
                      });
                    },
                    child: const SizedBox(
                      height: 300,
                      width: 150,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      if (currentImageIndex + 1 ==
                          (widget.user.images?.length ?? 0)) {
                        return;
                      }
                      setState(() {
                        currentImageIndex++;
                      });
                    },
                    child: const SizedBox(
                      height: 300,
                      width: 150,
                    ),
                  ),
                ),
                Positioned(
                  top: 15,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                        widget.user.images?.length ?? 1,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 2.5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: index == currentImageIndex
                                ? const Color(0xFFFF0E73)
                                : Colors.black,
                          ),
                          height: 3,
                          width: 56,
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff202020),
                          ),
                          color: const Color(0xff000000),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const ImageIcon(
                              AssetImage(
                                "assets/icons/star_icon.png",
                              ),
                              color: Color(0xFF262626),
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.user.likeCount?.toString() ?? "-",
                              style: const TextStyle(
                                fontFamily: 'Pretendard',
                                letterSpacing: -0.6,
                                color: Color(0xffFCFCFC),
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.user.name ?? "",
                            style: const TextStyle(
                              fontSize: 28,
                              fontFamily: 'Pretendard',
                              letterSpacing: -0.6,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFFCFCFC),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.user.age?.toString() ?? "",
                            style: const TextStyle(
                              fontSize: 22,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w300,
                              color: Color(0xFFFCFCFC),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: currentImageIndex == 0
                                ? locationWidget
                                : currentImageIndex == 1
                                    ? descriptionWidget
                                    : tagsWidget,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (Rect bounds) =>
                                const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFF45FFF4),
                                Color(0xFF7000FF),
                              ],
                            ).createShader(bounds),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Icon(
                                Icons.favorite,
                                size: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.chevron_down,
                            color: Colors.white,
                            size: 20,
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }

  Widget get descriptionWidget => Text(
        widget.user.description ?? "",
        style: const TextStyle(
          fontSize: 15,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w300,
          color: Color(0xFFD9D9D9),
        ),
      );
  Widget get tagsWidget => Wrap(
        spacing: 10,
        runSpacing: 10,
        children: List.generate(
          widget.user.tags?.length ?? 0,
          (index) => Container(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 25,
            ),
            decoration: BoxDecoration(
              color: index == 0 ? const Color(0xB3621133) : Colors.black,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              widget.user.tags?[index] ?? "",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Pretendard',
                color: index == 0
                    ? const Color(0xFFFF016B)
                    : const Color(0xFFF5F5F5),
                letterSpacing: -0.6,
              ),
            ),
          ),
        ),
      );
  Widget get locationWidget => Text(
        widget.user.location ?? "",
        style: const TextStyle(
          fontSize: 15,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w300,
          color: Color(0xFFD9D9D9),
        ),
      );
}
