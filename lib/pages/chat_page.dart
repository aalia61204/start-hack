import 'dart:developer';

import 'package:ai_finance_manager/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../data/api.dart';
import '../features/ai_chat/ai_chat_models.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.transactionData});
  final String transactionData;

  @override
  State<ChatPage> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  late AiChatData _chatData;
  final ScrollController _scrollController = ScrollController();

  bool loading = false;
  List<Map<String, dynamic>> content =[];
  TextEditingController prompt = TextEditingController();
  String output = '';
  List<Map> history = [];

  @override
  void initState() {
    super.initState();
    _chatData = AiChatData.demoData;
  }

  runPromptGemini(val) async {
    setState(() {
      loading = true;
    });
    content.add(
      {
        "role": "user",
        "parts": [
          {
            "text": "Here's my financial data in JSON string format: ${widget.transactionData}.  Please provide a summary of these transactions in a beautiful, easy-to-read format. Use markdown for a clear presentation. For example, you could list each transaction with its details, categorize the spending, or highlight the largest expense. And here is the main prompt ${prompt.text}"
          },
        ],
      },
    );

    output = await Apis().geminiApiPost(val, content);
    content.add({
        "role": "model",
        "parts": [
          {
            "text": output
          },
        ],
    });
    history.add({'id': "historyId", 'prompt': val, 'output': output, 'rating':0.0});
    setState(() {
      loading = false;
    });
    log(output.toString());
    prompt.clear();
  }

  // runPromptGemini(val) async {
  //   setState(() {
  //     loading = true;
  //   });
  //   // ... your existing code to add content and history ...

  //   output = await Apis().geminiApiPost(val, content);
  //   content.add({
  //     "role": "model",
  //     "parts": [
  //       {
  //         "text": output
  //       },
  //     ],
  //   });
  //   history.add({'id': "historyId", 'prompt': val, 'output': output, 'rating':0.0});

  //   setState(() {
  //     loading = false;
  //   });

  //   // Add this new code for scrolling
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _scrollController.animateTo(
  //       _scrollController.position.maxScrollExtent,
  //       duration: Duration(milliseconds: 300),
  //       curve: Curves.easeOut,
  //     );
  //   });

  //   log(output.toString());
  //   prompt.clear();
  // }

  // runPromptCohere(val) async {
  //   setState(() {
  //     loading = true;
  //   });
  //   content.add(
  //     {
  //       "role": "user",
  //       "content": [
  //         {
  //           "type": "text",
  //           "text": prompt.text
  //         }
  //       ]
  //     }
  //   );

  //   output = await Apis().cohereApiPost(val, content);
  //   content.add({
  //       "role": "assistant",
  //       "content": [
  //         {
  //           "type": "text",
  //           "text": output
  //         }
  //       ]
  //   });
  //   history.add({'id': "historyId", 'prompt': val, 'output': output, 'rating':0.0});
  //   setState(() {
  //     loading = false;
  //   });
  //   prompt.clear();


  //   log(content.toString());
  //   Future.delayed(Duration(milliseconds: 2), () {
  //     scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  //   });
  // }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Finance Assistant', style: titlestyle,),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: _buildSuggestionChips()),
          Expanded(
            flex: 4,
            child: loading ? Center(child: CircularProgressIndicator(),) :   
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(history.length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(left: 10.sp),
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(15.sp),
                          ),
                          child: SelectableText(history[index]['prompt'], style: lighttitlestyle.copyWith(color: Colors.white),),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.all(12.sp),
                        margin: EdgeInsets.symmetric(horizontal: 12.sp),
                        decoration: BoxDecoration(
                          color: primaryClr,
                          borderRadius: BorderRadius.circular(15.sp)
                        ),
                        child: Text(history[index]['output'], style: lighttitlestyle.copyWith(color: Colors.white),),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  );
                },),
              ),
            ),
          ),
          _buildMessageInput()
        ],
      )
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(2.w).copyWith(bottom: 20.sp),
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
                controller: prompt,
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
                onSubmitted: (value) => runPromptGemini(prompt.text),
              ),
            ),
          ),
          SizedBox(width: 1.5.w),
          Container(
            width: 6.h,
            height: 6.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryClr, primaryClr.withAlpha(100) ],
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
              onPressed: () {
                runPromptGemini(prompt.text);
              }/* _sendMessage */,
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
        onTap: () => runPromptGemini(suggestion.text),
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

}