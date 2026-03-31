import 'package:flutter/material.dart';
import 'package:user/module/user/model/user_mdl.dart';
import 'package:user/util/theme/theme_color.dart';

class UserCard extends StatelessWidget {
  final UserMdl user;
  final Function() onTap;
  const UserCard({super.key, required this.user, required this.onTap});
  String _getInitials(String name) {
    List<String> names = name.trim().split(RegExp(r'\s+'));
    if (names.isEmpty) return "";
    if (names.length == 1) return names[0][0].toUpperCase();
    return "${names[0][0]}${names[names.length - 1][0]}".toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        padding: const EdgeInsets.all(22.0),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: ThemeColor.borderBlue, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: ThemeColor.bgBlue.withValues(alpha: 0.8),
              blurRadius: 8.0,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 56.0,
              width: 56.0,
              decoration: const BoxDecoration(
                color: ThemeColor.bgBlue,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                _getInitials(user.name),
                style: const TextStyle(
                  color: ThemeColor.textBlue,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w700,
                      color: ThemeColor.textBlack,
                      letterSpacing: 0.3,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.email_rounded,
                        color: ThemeColor.iconGrey,
                        size: 16.0,
                      ),
                      const SizedBox(width: 6.0),
                      Expanded(
                        child: Text(
                          user.email,
                          style: const TextStyle(
                            fontSize: 13.0,
                            color: ThemeColor.valueGrey,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        color: ThemeColor.iconGrey,
                        size: 16.0,
                      ),
                      const SizedBox(width: 6.0),
                      Expanded(
                        child: Text(
                          user.address.city,
                          style: const TextStyle(
                            fontSize: 13.0,
                            color: ThemeColor.valueGrey,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
