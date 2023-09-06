import 'package:flutter/material.dart';

import '../model/user_model.dart';
import 'dating_card.dart';

class DatingCardStack extends StatefulWidget {
  final List<User> users;
  final Function() onAllUserRemovedCallback;
  const DatingCardStack(
      {Key? key, required this.users, required this.onAllUserRemovedCallback})
      : super(key: key);

  @override
  State<DatingCardStack> createState() => _DatingCardStackState();
}

class _DatingCardStackState extends State<DatingCardStack> {
  double angle = 0.0;
  Size screenSize = Size.zero;
  Offset currentUserCardPosition = Offset.zero;

  onPanStart(DragStartDetails detail) {}

  onPanUpdate(DragUpdateDetails details) {
    currentUserCardPosition += details.delta;
    angle = 45 * currentUserCardPosition.dx / screenSize.width;

    setState(() {});
  }

  onPanEnd(DragEndDetails details) {
    angle = 0;
    currentUserCardPosition = Offset.zero;
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
    int currentUserIndex = 0;
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      pageSnapping: true,
      controller: PageController(
        viewportFraction: 0.9,
        initialPage: 1,
      ),
      children: [
        currentUserIndex - 1 <= 0
            ? const SizedBox(
                height: 0,
                width: 0,
              )
            : DatingCard(
                user: widget.users[currentUserIndex - 1],
                isFront: false,
                onSwipe: (remove) {}),
        Stack(
          children: [
            ...widget.users.map(
              (e) => DatingCard(
                  user: e,
                  isFront: widget.users.last == e,
                  onSwipe: (removedUser) {
                    final index = widget.users.indexOf(removedUser);
                    setState(() {
                      currentUserIndex = index + 1;
                      widget.users.remove(removedUser);
                    });
                    if (widget.users.isEmpty) {
                      widget.onAllUserRemovedCallback.call();
                    }
                  }),
            ),
          ],
        ),
        currentUserIndex + 1 >= widget.users.length
            ? const SizedBox(
                height: 0,
                width: 0,
              )
            : DatingCard(
                user: widget.users[currentUserIndex + 1],
                isFront: false,
                onSwipe: (remove) {}),
      ],
    );
  }
}
