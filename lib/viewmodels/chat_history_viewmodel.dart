import 'package:flutter/material.dart';
import 'package:wellbot/models/chat_history_model.dart';
import 'package:wellbot/services/chat_history_service.dart';

class ChatHistoryViewModel extends ChangeNotifier {
  List<ChatHistoryItemModel> _historyItems = [];
  List<ChatHistoryItemModel> get historyItems => _historyItems;

  void loadHistory() {
    _historyItems = ChatHistoryService.instance.getHistoryItems();
    notifyListeners();
  }
}