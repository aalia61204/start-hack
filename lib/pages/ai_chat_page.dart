import 'package:ai_finance_manager/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("AI Chat", style: titlestyle,),
      ),
      body: Column(
        children: [
          suggestionList(),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) => ListTile(
                title: Text("Rahim Berdiev"),
                subtitle: Text("He"),
              ), 
            )
          ),
          Container(
            height: 35.sp,
            width: 100.w,
            padding: EdgeInsets.all(10.sp),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.sp),
                        borderSide: BorderSide(color: primaryClr, width: 1.sp)
                      )
                    ),
                  )
                ),
                IconButton(
                  onPressed: () {} , 
                  icon: Icon(Icons.send, color: primaryClr,)
                )
              ],
            ),
          ),
        ],
      ), 
    );
  }
  
  suggestionList() {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.symmetric(horizontal: 18.sp).copyWith(bottom: 15.sp),
          child: ListTile(
            title: Text("Summarize my expenses", style: lighttitlestyle,),
          ),
        ),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 18.sp).copyWith(bottom: 15.sp),
          child: ListTile(
            title: Text("Recommend me some saving strategies", style: lighttitlestyle,),
          ),
        ),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 18.sp).copyWith(bottom: 15.sp),
          child: ListTile(
            title: Text("Summarize my expenses", style: lighttitlestyle,),
          ),
        ),
      ],
    );
  }
}