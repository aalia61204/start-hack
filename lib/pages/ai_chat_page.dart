import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../features/ai_chat/ai_chat_models.dart';

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  late AiChatData _chatData;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _chatData = AiChatData.demoData;
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 5.h,
              height: 5.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(2.5.h),
              ),
              child: Icon(
                Icons.smart_toy,
                color: Colors.white,
                size: 3.h,
              ),
            ),
            SizedBox(width: 1.5.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Finance Assistant',
                  style: GoogleFonts.inter(
                    fontSize: 2.h,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  'Online',
                  style: GoogleFonts.inter(
                    fontSize: 1.5.h,
                    color: Colors.green[600],
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _chatData = AiChatData.demoData;
              });
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.grey[600],
              size: 2.5.h,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Suggestion Chips
          _buildSuggestionChips(),
          
          // Chat Messages
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Chat Header
                  Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2.5.h),
                        topRight: Radius.circular(2.5.h),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 1.h,
                          height: 1.h,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          'AI is ready to help with your finances',
                          style: GoogleFonts.inter(
                            fontSize: 1.7.h,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Messages List
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.all(2.w),
                      itemCount: _chatData.messages.length + (_isTyping ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == _chatData.messages.length && _isTyping) {
                          return _buildTypingIndicator();
                        }
                        return _buildMessageBubble(_chatData.messages[index]);
                      },
                    ),
                  ),
                  
                  // Message Input
                  _buildMessageInput(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChips() {
    return Container(
      height: 15.h,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Text(
              'Quick Actions',
              style: GoogleFonts.inter(
                fontSize: 2.h,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
          ),
          SizedBox(height: 1.5.h),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              itemCount: _chatData.suggestions.length,
              itemBuilder: (context, index) {
                final suggestion = _chatData.suggestions[index];
                return _buildSuggestionChip(suggestion);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(SuggestionChip suggestion) {
    return Container(
      margin: EdgeInsets.only(right: 1.5.w),
      child: InkWell(
        onTap: () => _sendSuggestionMessage(suggestion.text),
        borderRadius: BorderRadius.circular(2.5.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.2.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[50]!, Colors.purple[50]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(2.5.h),
            border: Border.all(color: Colors.blue[100]!),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                suggestion.icon,
                style: TextStyle(fontSize: 2.h),
              ),
              SizedBox(width: 1.w),
              Text(
                suggestion.text,
                style: GoogleFonts.inter(
                  fontSize: 1.7.h,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final isUser = message.type == MessageType.user;
    
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 4.h,
              height: 4.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(2.h),
              ),
              child: Icon(
                Icons.smart_toy,
                color: Colors.white,
                size: 2.2.h,
              ),
            ),
            SizedBox(width: 1.w),
          ],
          
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: isUser ? Colors.blue[600] : Colors.grey[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2.5.h),
                  topRight: Radius.circular(2.5.h),
                  bottomLeft: Radius.circular(isUser ? 2.5.h : 0.5.h),
                  bottomRight: Radius.circular(isUser ? 0.5.h : 2.5.h),
                ),
                boxShadow: [
                  BoxShadow(
                    color: (isUser ? Colors.blue : Colors.grey).withOpacity(0.2),
                    blurRadius: 1.h,
                    offset: Offset(0, 0.2.h),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.content,
                    style: GoogleFonts.inter(
                      fontSize: 1.8.h,
                      color: isUser ? Colors.white : Colors.grey[800],
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    _formatTime(message.timestamp),
                    style: GoogleFonts.inter(
                      fontSize: 1.3.h,
                      color: isUser ? Colors.white70 : Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          if (isUser) ...[
            SizedBox(width: 1.w),
            Container(
              width: 4.h,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.h),
              ),
              child: Icon(
                Icons.person,
                color: Colors.grey[600],
                size: 2.2.h,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      child: Row(
        children: [
          Container(
            width: 4.h,
            height: 4.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(2.h),
            ),
            child: Icon(
              Icons.smart_toy,
              color: Colors.white,
              size: 2.2.h,
            ),
          ),
          SizedBox(width: 1.w),
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(2.5.h),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTypingDot(0),
                SizedBox(width: 0.5.w),
                _buildTypingDot(1),
                SizedBox(width: 0.5.w),
                _buildTypingDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        return Container(
          width: 1.h,
          height: 1.h,
          decoration: BoxDecoration(
            color: Colors.grey[400]?.withOpacity(0.3 + (value * 0.7)),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(3.h),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Ask me about your finances...',
                  hintStyle: GoogleFonts.inter(
                    color: Colors.grey[500],
                    fontSize: 1.8.h,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 2.5.w,
                    vertical: 1.5.h,
                  ),
                ),
                style: GoogleFonts.inter(fontSize: 1.8.h),
                maxLines: null,
                onSubmitted: (value) => _sendMessage(),
              ),
            ),
          ),
          SizedBox(width: 1.5.w),
          Container(
            width: 6.h,
            height: 6.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(3.h),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 1.h,
                  offset: Offset(0, 0.2.h),
                ),
              ],
            ),
            child: IconButton(
              onPressed: _sendMessage,
              icon: Icon(
                Icons.send,
                color: Colors.white,
                size: 2.5.h,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final newMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: text,
      type: MessageType.user,
      timestamp: DateTime.now(),
    );

    setState(() {
      _chatData = AiChatData(
        messages: [..._chatData.messages, newMessage],
        suggestions: _chatData.suggestions,
      );
      _isTyping = true;
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate AI response
    Future.delayed(const Duration(seconds: 2), () {
      _simulateAiResponse(text);
    });
  }

  void _sendSuggestionMessage(String suggestion) {
    _messageController.text = suggestion;
    _sendMessage();
  }

  void _simulateAiResponse(String userMessage) {
    final responses = [
      "That's a great question! Based on your spending patterns, I can see some interesting trends. Let me analyze your data and provide you with detailed insights.",
      "I've analyzed your financial data and found some key insights. Your spending has increased by 15% compared to last month, primarily in the dining category.",
      "Here's what I found in your spending analysis: You're doing well with your budget overall, but there are a few areas where we could optimize your expenses.",
      "Based on your transaction history, I can provide you with personalized recommendations to help you save more and spend smarter.",
    ];

    final randomResponse = responses[DateTime.now().millisecondsSinceEpoch % responses.length];

    final aiMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: randomResponse,
      type: MessageType.ai,
      timestamp: DateTime.now(),
    );

    setState(() {
      _chatData = AiChatData(
        messages: [..._chatData.messages, aiMessage],
        suggestions: _chatData.suggestions,
      );
      _isTyping = false;
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${timestamp.day}/${timestamp.month}';
    }
  }
}