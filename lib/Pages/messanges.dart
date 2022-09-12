import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:messenger/Models/messages_data.dart';
import 'package:messenger/Screens/chat_screen.dart';
import 'package:messenger/components/RandomPicker.dart';
import 'package:messenger/theme.dart';

import '../Models/story_data.dart';
import '../components/avatar.dart';

class messanges extends StatelessWidget {
  const messanges({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _Stories(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(_delegate),
        ),
      ],
    );
  }

  Widget _delegate(BuildContext context, index) {
    final faker = Faker();
    final date = Randoms.randomDate();
    return _MessageTitle(
        messagesData: MessagesData(
      senderName: faker.person.firstName(),
      message: faker.lorem.sentence(),
      profilePicture: Randoms.randomPictureUrl(),
      messageDate: date,
      dateMessage: Jiffy(date).fromNow(),
    ));
  }
}

class _MessageTitle extends StatelessWidget {
  const _MessageTitle({required this.messagesData});

  final MessagesData messagesData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(chatScreen.route(messagesData));
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Avatar.medium(
              url: messagesData.profilePicture,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      messagesData.senderName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        letterSpacing: 0.2,
                        wordSpacing: 1.5,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: Text(
                      messagesData.message,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13, color: AppColors.textFaded),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 4,
                ),
                Text(
                  messagesData.dateMessage.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 11,
                      letterSpacing: -0.2,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textFaded),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                      child: Text(
                    "1",
                    style: TextStyle(fontSize: 10, color: AppColors.textLigth),
                  )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Card _Stories() {
  return Card(
    elevation: 0,
    child: SizedBox(
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: const Text(
              "Stories",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15,
                color: AppColors.textFaded,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: ((BuildContext context, int index) {
                final faker = Faker();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _StoryCard(
                    storyData: StoryData(
                        name: faker.person.firstName(),
                        url: Randoms.randomPictureUrl()),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    ),
  );
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    Key? key,
    required this.storyData,
  }) : super(key: key);

  final StoryData storyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Avatar.medium(url: storyData.url),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              storyData.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                letterSpacing: 0.3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
