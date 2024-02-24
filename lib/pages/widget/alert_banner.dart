import 'package:alert_banner/exports.dart';
import 'package:flutter/material.dart';

class InAppNotification extends StatelessWidget {
  final String message;
  final Color? textColor;
  final Color? backgroundColor;
  const InAppNotification({
    super.key,
    required this.message,
    required this.textColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      width: double.infinity,
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Material(
          color: const Color.fromARGB(0, 162, 95, 95),
          child: Text(
            message,
            style: TextStyle(color: textColor, fontSize: 14),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class AlertBannerWidgets {
  static void success(context, String message) => showAlertBanner(
        context,
        () => {},
        InAppNotification(
          message: message,
          textColor: Colors.white,
          backgroundColor: Colors.green,
        ),
        alertBannerLocation: AlertBannerLocation.top,
      );

  static void fail(context, String message) => showAlertBanner(
        context,
        () => {},
        InAppNotification(
          message: message,
          textColor: Colors.white,
          backgroundColor: Colors.red,
        ),
        alertBannerLocation: AlertBannerLocation.top,
      );
}
