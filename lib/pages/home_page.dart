import 'package:ai_finance_manager/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      padding: EdgeInsets.all(1.2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 2.5.h,
              ),
              SizedBox(
                width: 2.w,
              ),
              Text(
                "Rahim Berdiev",
                style: GoogleFonts.inter(
                  fontSize: 2.2.h,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {}, 
            icon: Icon(
              Icons.notifications,
              size: 2.8.h,
              color: Colors.grey[600],
            ),
          )
        ],
      ),
    );
  }
  
  balanceCard() {
    return Padding(
      padding: EdgeInsets.all(1.2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Balance", 
            style: GoogleFonts.inter(
              fontSize: 2.5.h,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            "CHF 2,402.10", 
            style: GoogleFonts.inter(
              fontSize: 3.5.h,
              fontWeight: FontWeight.bold,
              color: primaryClr,
            ),
          ),
        ],
      ),
    );
  }
  
  transactionHistoryCard() {
    return Container(
      height: 18.h,
      padding: EdgeInsets.symmetric(horizontal: 1.2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Transactions",
            style: GoogleFonts.inter(
              fontSize: 2.5.h,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 1.5.h),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 12.h,
                  height: 12.h,
                  padding: EdgeInsets.all(1.8.h),
                  margin: EdgeInsets.only(right: 1.5.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.5.h),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 0.5.h,
                        offset: Offset(0, 0.2.h),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(1.2.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1.5.h),
                          color: primaryClr.withAlpha(150)
                        ),
                        child: Icon(
                          Icons.food_bank_outlined, 
                          color: Colors.white,
                          size: 2.5.h,
                        ),
                      ),
                      SizedBox(height: 1.5.h),
                      Text(
                        "CHF 20.25", 
                        style: GoogleFonts.inter(
                          fontSize: 1.8.h,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        "Uber Eats", 
                        style: GoogleFonts.inter(
                          fontSize: 1.4.h,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
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