import 'package:event_ui/event_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Events'),
        trailing: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage('assets/images/profile.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Transform.translate(
            offset: const Offset(15, -15),
            child: Container(
              margin: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: CupertinoColors.tertiarySystemBackground,
                      width: 3),
                  color: CupertinoColors.activeOrange,
                  shape: BoxShape.circle),
            ),
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CupertinoSearchTextField(),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (_, index) => EventCard(
                          image: (index + 1).toString(), date: index * 2 + 2),
                      separatorBuilder: (_, index) => const Divider(
                          color: CupertinoColors.separator, thickness: .5),
                      itemCount: 6))
            ],
          ),
        ),
      ),
    );
  }
}
