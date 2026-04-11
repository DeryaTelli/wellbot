import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AiChatDataSource {
  late final GenerativeModel _model;
    String _limitTo100Words(String text) {
    final words = text.trim().split(RegExp(r'\s+'));
    if (words.length <= 100) return text.trim();

    return '${words.take(100).join(' ')}...';
  }

  AiChatDataSource() {
    final ai = FirebaseAI.googleAI(auth: FirebaseAuth.instance);

    _model = ai.generativeModel(model: 'gemini-2.5-flash-lite');
  }

  Future<String> sendMessage({
    required String systemPrompt,
    required List<Map<String, String>> history,
    required String userMessage,
  }) async {
    try {
      final chat = _model.startChat(
        history: [
          Content.text('System: $systemPrompt'),
          ...history.map((m) {
            final role = m['role'] == 'user' ? 'User' : 'Assistant';
            return Content.text('$role: ${m['text'] ?? ''}');
          }),
        ],
      );

      final response = await chat.sendMessage(Content.text(userMessage));

      final text = response.text;
      if (text == null || text.isEmpty) {
        return 'Sorry, I couldn\'t generate a response. Please try again.';
      }

      return _limitTo100Words(text);
    } catch (e) {
      return 'Error: $e';
    }
  }
}
