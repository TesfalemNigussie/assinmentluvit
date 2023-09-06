import 'package:flutter/material.dart';

class EmptyCard extends StatelessWidget {
  const EmptyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '추천 드릴 친구들을 준비 중이에요',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.6,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          '매일 새로운 친구들을 소개시켜드려요',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 16,
            color: Color(0xFFADADAD),
            letterSpacing: -0.6,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
