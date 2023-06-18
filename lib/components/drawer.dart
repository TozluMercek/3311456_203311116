import 'package:final_app_project/components/list_tile.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;
  final void Function()? onShoppingTap;
  final void Function()? onPetsTap;
  final void Function()? onImagesTap;

  const MyDrawer(
      {super.key,
      required this.onProfileTap,
      required this.onSignOut,
      required this.onShoppingTap,
      required this.onPetsTap,
      required this.onImagesTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.deepPurple.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 64,
                ),
              ),
              MyListTile(
                text: 'H O M E',
                icon: Icons.home,
                onTap: () => Navigator.pop(context),
              ),
              MyListTile(
                text: 'P R O F I L E',
                icon: Icons.person,
                onTap: onProfileTap,
              ),
              MyListTile(
                  text: 'S H O P P I N G ',
                  icon: Icons.shop,
                  onTap: onShoppingTap),
              MyListTile(text: 'P E T S ', icon: Icons.pets, onTap: onPetsTap),
              MyListTile(
                  text: 'I M A G E S ', icon: Icons.image, onTap: onImagesTap)
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyListTile(
              text: 'L O G O U T',
              icon: Icons.logout,
              onTap: onSignOut,
            ),
          )
        ],
      ),
    );
  }
}
