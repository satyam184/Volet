import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet/utils/images.dart';
import 'package:wallet/utils/screen_util.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            floating: true,
            pinned: false,
            title: Text('Wallet'),
            centerTitle: true,
            leading: Align(
              child: SvgPicture.asset(
                wallet,
                height: ScreenUtil.height(5),
                width: ScreenUtil.width(5),
              ),
            ),
            actions: [CircleAvatar()],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Color(0xFF305DB7),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: ScreenUtil.height(4),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Total Spends'),
                        Text(
                          '15000',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }, childCount: 2),
          ),
        ],
      ),
    );
  }
}
