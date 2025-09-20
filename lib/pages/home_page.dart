import 'package:ai_finance_manager/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topProfile(),
            balanceCard(),
            transactionHistoryCard()
          ],
        ),
      ),
    );
  }
  
  topProfile() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
              ),
              SizedBox(
                width: 15,
              ),
              Text("Rahim Berdiev"),
            ],
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
        ],
      ),
    );
  }
  
  balanceCard() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Balance", style: titlestyle,),
          Text("\$2402.10", style: lighttitlestyle.copyWith(fontSize: 22.sp, color: Colors.purple),),
        ],
      ),
    );
  }
  
  transactionHistoryCard() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          width: 50.sp,
          height: 50.sp,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),

          ),
          child: Column(
            children: [
              Icon(Icons.food_bank_outlined),
              Text("\$20.25", style: lighttitlestyle,),
              Text("Uber Eats", style: lighttitlestyle,),
            ],
          ),
        );
      },
      itemExtent: 50.sp,
    );
  }
}