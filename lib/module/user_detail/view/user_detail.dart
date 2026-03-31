import 'package:flutter/material.dart';
import 'package:user/module/user/model/user_mdl.dart';
import 'package:user/util/theme/theme_color.dart';

class UserDetailView extends StatelessWidget {
  final UserMdl user;
  const UserDetailView({super.key, required this.user});
  String _getInitials(String name) {
    List<String> names = name.trim().split(RegExp(r'\s+'));
    if (names.isEmpty) return "";
    if (names.length == 1) return names[0][0].toUpperCase();
    return "${names[0][0]}${names[names.length - 1][0]}".toUpperCase();
  }

  String _getCompleteAddress() {
    return '${user.address.suite}, ${user.address.street}\n${user.address.city}, ${user.address.zipcode}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Detail")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              const SizedBox(height: 32.0),
              _buildSectionTitle('Contact Information'),
              const SizedBox(height: 12.0),
              _buildInfoCard([
                _buildInfoRow(Icons.email_rounded, user.email),
                Divider(),
                _buildInfoRow(Icons.phone_rounded, user.phone),
                Divider(),
                _buildInfoRow(Icons.language_rounded, user.website),
              ]),
              const SizedBox(height: 24.0),
              _buildSectionTitle('Address Details'),
              const SizedBox(height: 12.0),
              _buildInfoCard([
                _buildInfoRow(
                  Icons.location_on_rounded,
                  _getCompleteAddress(),
                  isMultiline: true,
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          height: 88.0,
          width: 88.0,
          decoration: BoxDecoration(
            color: ThemeColor.bgBlue,
            shape: BoxShape.circle,
            border: Border.all(color: ThemeColor.borderBlue, width: 2.0),
          ),
          alignment: Alignment.center,
          child: Text(
            _getInitials(user.name),
            style: const TextStyle(
              color: ThemeColor.textBlue,
              fontSize: 32.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          user.name,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: ThemeColor.textBlack,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4.0),
        Text(
          '@${user.username}',
          style: const TextStyle(
            fontSize: 16.0,
            color: ThemeColor.textGrey,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
        color: ThemeColor.blue,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: ThemeColor.borderBlue),
        boxShadow: [
          BoxShadow(
            color: ThemeColor.bgBlue.withValues(alpha: 0.6),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {bool isMultiline = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        crossAxisAlignment: isMultiline
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Icon(icon, color: ThemeColor.iconGrey, size: 24.0),
          const SizedBox(width: 16.0),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15.0,
                color: ThemeColor.valueGrey,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
