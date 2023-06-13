import 'package:flutter/material.dart';
import 'package:siskom_tv_dosen/theme.dart';

class IdentityTile extends StatelessWidget {
  IdentityTile({
    super.key,
    required this.name,
    required this.title,
    required this.icon,
  });

  String title;
  String name;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Icon(
            icon,
            size: 32,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: blackTextStyle.copyWith(
                  fontSize: 13,
                ),
              ),
              Text(
                name,
                style: greyTextStyleB,
              )
            ],
          ),
        ],
      ),
    );
  }
}
