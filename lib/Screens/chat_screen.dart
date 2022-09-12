import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger/components/avatar.dart';
import 'package:messenger/theme.dart';

import '../Models/messages_data.dart';
import '../components/Icon_buttons.dart';
import '../components/glowing_action _button.dart';

class chatScreen extends StatelessWidget {
  const chatScreen({super.key, required this.messagesData});

  static Route route(MessagesData data) =>
      MaterialPageRoute(builder: (context) => chatScreen(messagesData: data));

  final MessagesData messagesData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: CupertinoIcons.back,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: _AppBarTitle(messagesData),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: IconBorder(
                icon: CupertinoIcons.video_camera_solid,
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: IconBorder(
                icon: CupertinoIcons.phone_solid,
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: const [
            Expanded(child: _DemoMessageList()),
            _ActionBarInput(),
          ],
        ),
      ),
    );
  }
}

class _DemoMessageList extends StatelessWidget {
  const _DemoMessageList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        _DateLable(lable: 'Yesterday'),
        _MessageTile(
            message: "Hi Lucy  How is the going?", messageDate: "12:02"),
        _MessageOwnTile(
            message: "Amazingly good and you", messageDate: "12:30"),
        _MessageTile(
          message: "Just strugling here and thre",
          messageDate: "12:02",
        ),
        _MessageOwnTile(
          message: "All will be well soon ",
          messageDate: "01:2",
        ),
        _MessageTile(message: "Hope so", messageDate: "08:23"),
        _MessageOwnTile(
          message: "Dont you pray??",
          messageDate: "12:00",
        ),
        _MessageTile(
          message: "Yeah i do you fool",
          messageDate: "08:23",
        ),
        _MessageOwnTile(
            message:
                "okay shit it doesnt have to reach there ....man are you sick or what??",
            messageDate: "12:00"),
      ],
    );
  }
}

class _DateLable extends StatelessWidget {
  const _DateLable({required this.lable});

  final String lable;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Text(
              lable,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textFaded),
            ),
          ),
        ),
      ),
    );
  }
}

class _MessageOwnTile extends StatelessWidget {
  const _MessageOwnTile({
    Key? key,
    required this.message,
    required this.messageDate,
  }) : super(key: key);

  final String message;
  final String messageDate;

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                  bottomLeft: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(message,
                    style: const TextStyle(
                      color: AppColors.textLigth,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                messageDate,
                style: const TextStyle(
                  color: AppColors.textFaded,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({
    Key? key,
    required this.message,
    required this.messageDate,
  }) : super(key: key);

  final String message;
  final String messageDate;

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  topRight: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(message),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                messageDate,
                style: const TextStyle(
                  color: AppColors.textFaded,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle(this.messagesData);

  final MessagesData messagesData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Avatar.small(url: messagesData.profilePicture),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                messagesData.senderName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 2),
              const Text(
                "online",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionBarInput extends StatelessWidget {
  const _ActionBarInput();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        bottom: true,
        top: false,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 2,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(
                  CupertinoIcons.camera_fill,
                ),
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: TextField(
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Type something...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 12,
                right: 24.0,
              ),
              child: GlowingActionButton(
                  size: 30,
                  color: AppColors.accent,
                  icon: Icons.send_rounded,
                  onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
