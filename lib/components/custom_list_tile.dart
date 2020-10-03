import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  ///Title displayed for the list tile
  final String title;

  ///Subtitle displayed for this list tile
  final String subtitle;

  ///Leading icon for this list tile
  final IconData icon;

  ///Use to set the color of the icon
  final Color iconColor;

  ///Trailing widget for this list tile
  final Widget trailing;

  ///Callback for list tile tapping
  final Function onTap;

  const CustomListTile({
    Key key,
    this.title,
    this.subtitle,
    this.icon,
    this.trailing,
    this.onTap,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
      leading: icon != null ? Icon(icon, color: iconColor) : null,
      subtitle: subtitle != null ? Text(subtitle) : null,
      title: title != null ? Text(title) : title,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
