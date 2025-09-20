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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topProfile(),
              balanceCard(),
              transactionHistoryCard(),
              servicesTile()
            ],
          ),
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
          Text("\$2402.10", style: lighttitlestyle.copyWith(fontSize: 22.sp, color: primaryClr),),
        ],
      ),
    );
  }
  
  transactionHistoryCard() {
    return SizedBox(
      height: 50.sp,
      child: ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 50.sp,
            height: 50.sp,
            padding: EdgeInsets.all(15.sp),
            margin: EdgeInsets.only(right: 10.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.sp),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.sp),
                    color: primaryClr.withAlpha(150)
                  ),
                  child: Icon(Icons.food_bank_outlined, color: Colors.white,)
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Text("\$20.25", style: lighttitlestyle,),
                Text("Uber Eats", style: lighttitlestyle,),
              ],
            ),
          );
        },
        itemExtent: 50.sp,
      ),
    );
  }
  
  servicesTile() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Services", style: titlestyle,),
          SizedBox(
            height: 10.sp,
          ),
          GridView.builder(
            itemCount: 4,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              crossAxisSpacing: 12.sp, 
              mainAxisSpacing: 12.sp,
              childAspectRatio: 1.5
            ),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.sp),
                  color: primaryClr.withAlpha(150),
                ),
                child: Center(child: Text("Service $index", style: titlestyle.copyWith(color: Colors.white),)),
              );
            },
      
          )
        ],
      ),
    );
  }
}