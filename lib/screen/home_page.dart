import 'package:assinmentluvit/model/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../widget/dating_card_stack.dart';
import '../widget/empty_card.dart';
import '../widget/loading_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<User> users;
  bool isLoading = false;
  final _database = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    users = [];
    isLoading = true;

    _database.child('data').onValue.listen((event) {
      for (var element
          in (event.snapshot.value as Map<Object?, Object?>).values) {
        setState(() {
          isLoading = false;
          users.add(User.fromJson(element as Map<Object?, Object?>));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const ImageIcon(
                    AssetImage(
                      "assets/icons/location_icon.png",
                    ),
                    color: Color(0xFF615f5f),
                    size: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Expanded(
                    child: Text(
                      '목이길어슬픈기린님의 새로운 스팟',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Pretendard',
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff202020),
                      ),
                      color: const Color(0xff000000),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Row(
                      children: [
                        ImageIcon(
                          AssetImage(
                            "assets/icons/star_icon.png",
                          ),
                          color: Color(0xFFFF006B),
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '323,233',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            letterSpacing: -0.6,
                            color: Color(0xfffbfbfb),
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      const ImageIcon(
                        AssetImage(
                          "assets/icons/notification_icon.png",
                        ),
                        size: 40,
                        color: Colors.white,
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: users.isEmpty
                  ? true
                      ? const LoadingCard()
                      : const EmptyCard()
                  : DatingCardStack(
                      users: users,
                      onAllUserRemovedCallback: () {
                        setState(() {
                          users.clear();
                        });
                      },
                    ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Color(0xFF393939),
                width: 2,
              ),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: const Color(0xFF0E0D0D),
            unselectedItemColor: const Color(0xFF302E2E),
            selectedItemColor: const Color(0xFFFF016B),
            elevation: 10,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/icons/home_icon.png'),
                ),
                activeIcon: ImageIcon(
                  AssetImage('assets/icons/selected_home_icon.png'),
                ),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/icons/location_icon.png'),
                ),
                label: '스팟',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.circle_outlined,
                  size: 0,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/icons/chat_icon.png'),
                ),
                label: '채팅',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/icons/profile_icon.png'),
                ),
                label: '마이',
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 30),
        height: 60,
        width: 60,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF393939),
              width: 2,
            ),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black,
                Color(0xff2F2F2F),
              ],
            ),
            shape: BoxShape.circle,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(500.0),
            onTap: () {},
            child: const ImageIcon(
              AssetImage(
                'assets/icons/star_icon.png',
              ),
              color: Colors.black,
              size: 10,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
