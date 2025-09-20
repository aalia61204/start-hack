enum MessageType {
  user,
  ai,
  system,
}

class ChatMessage {
  final String id;
  final String content;
  final MessageType type;
  final DateTime timestamp;
  final bool isTyping;

  const ChatMessage({
    required this.id,
    required this.content,
    required this.type,
    required this.timestamp,
    this.isTyping = false,
  });
}

class SuggestionChip {
  final String id;
  final String text;
  final String icon;
  final String category;

  const SuggestionChip({
    required this.id,
    required this.text,
    required this.icon,
    required this.category,
  });
}

class AiChatData {
  final List<ChatMessage> messages;
  final List<SuggestionChip> suggestions;

  const AiChatData({
    required this.messages,
    required this.suggestions,
  });

  // Demo data for the AI chat
  static AiChatData get demoData => AiChatData(
        messages: [
          ChatMessage(
            id: '1',
            content: 'Hello! I\'m your AI Finance Assistant. How can I help you with your financial questions today?',
            type: MessageType.ai,
            timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          ),
          ChatMessage(
            id: '2',
            content: 'What are my biggest expenses this month?',
            type: MessageType.user,
            timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
          ),
          ChatMessage(
            id: '3',
            content: 'Based on your spending data, your biggest expenses this month are:\n\n🍽️ **Food & Dining**: CHF 850 (32.7%)\n🛍️ **Shopping**: CHF 680 (26.2%)\n🚗 **Transportation**: CHF 420 (16.2%)\n\nI notice you\'re spending quite a bit on dining out. Would you like some tips to reduce these costs?',
            type: MessageType.ai,
            timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
          ),
        ],
        suggestions: const [
          SuggestionChip(
            id: '1',
            text: 'Summarize my expenses',
            icon: '📊',
            category: 'analytics',
          ),
          SuggestionChip(
            id: '2',
            text: 'Recommend saving strategies',
            icon: '💰',
            category: 'savings',
          ),
          SuggestionChip(
            id: '3',
            text: 'Analyze spending patterns',
            icon: '🔍',
            category: 'analysis',
          ),
          SuggestionChip(
            id: '4',
            text: 'Budget optimization tips',
            icon: '📈',
            category: 'budget',
          ),
          SuggestionChip(
            id: '5',
            text: 'Investment advice',
            icon: '📈',
            category: 'investment',
          ),
          SuggestionChip(
            id: '6',
            text: 'Tax planning help',
            icon: '📋',
            category: 'tax',
          ),
        ],
      );
}
