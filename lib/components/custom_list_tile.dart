import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget trailing;
  final Function onTap;

  const CustomListTile({
    Key key,
    this.title,
    this.subtitle,
    this.icon,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
      leading: icon != null ? Icon(icon) : null,
      subtitle: subtitle != null ? Text(subtitle) : null,
      title: title != null ? Text(title) : title,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
