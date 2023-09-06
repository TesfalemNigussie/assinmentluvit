import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF3A3A3A),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade600,
            highlightColor: Colors.grey.shade500,
            child: Image.asset(
              "assets/images/placeholder_image.png",
              fit: BoxFit.cover,
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
                  4,
                  (index) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade600,
                    highlightColor: Colors.grey.shade500,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 2.5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      height: 3,
                      width: 56,
                    ),
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
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade600,
                  highlightColor: Colors.grey.shade500,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff202020),
                      ),
                      color: const Color(0xff000000),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const SizedBox(
                      height: 10,
                      width: 100,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade600,
                      highlightColor: Colors.grey.shade500,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const SizedBox(
                          height: 10,
                          width: 200,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade600,
                      highlightColor: Colors.grey.shade500,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const SizedBox(
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade600,
                      highlightColor: Colors.grey.shade500,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const SizedBox(
                          height: 20,
                          width: 200,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade600,
                      highlightColor: Colors.grey.shade500,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const SizedBox(
                          height: 60,
                          width: 60,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
