import 'package:flutter/material.dart';

import '../core/services/sharing_service.dart';

class ShareViewModel with ChangeNotifier {
  final SharingService _sharingService = SharingService();

  Future<void> shareTask(String taskId, String email) async {
    await _sharingService.shareTaskWithEmail(taskId, email);
  }
}
