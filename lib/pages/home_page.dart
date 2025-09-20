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
              recentTransactionsCard(),
              financialInsightsCard(),
              categorySpendingCard(),
              transactionHistoryCard(),
              // incomeVsExpensesCard(),
              // spendingChartCard(),
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
                backgroundColor: primaryClr.withAlpha(50),
                radius: 20.sp,
                child: Icon(Icons.person_outline_rounded, size: 20.sp, color: primaryClr,),
              ),
              SizedBox(
                width: 15,
              ),
              Text("Rahim Berdiev", style: titlestyle,),
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
          Text("CHF 2402.10", style: lighttitlestyle.copyWith(fontSize: 22.sp, color: primaryClr),),
        ],
      ),
    );
  }
  
  financialInsightsCard() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(15.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.sp),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Financial Insights", style: titlestyle),
            SizedBox(height: 15.sp),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Monthly Income", style: lighttitlestyle.copyWith(fontSize: 12.sp, color: Colors.grey[600])),
                      Text("CHF 3,200", style: titlestyle.copyWith(fontSize: 16.sp, color: primaryClr)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Monthly Expenses", style: lighttitlestyle.copyWith(fontSize: 12.sp, color: Colors.grey[600])),
                      Text("CHF 2,150", style: titlestyle.copyWith(fontSize: 16.sp, color: Colors.red[600])),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Savings Rate", style: lighttitlestyle.copyWith(fontSize: 12.sp, color: Colors.grey[600])),
                      Text("32.8%", style: titlestyle.copyWith(fontSize: 16.sp, color: Colors.green[600])),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  spendingChartCard() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(15.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.sp),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Spending Trend", style: titlestyle),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
                  decoration: BoxDecoration(
                    color: primaryClr.withAlpha(50),
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                  child: Text("This Month", style: lighttitlestyle.copyWith(fontSize: 10.sp, color: primaryClr)),
                ),
              ],
            ),
            SizedBox(height: 15.sp),
            Container(
              height: 120.sp,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildBarChart(60.sp, "Mon"),
                  _buildBarChart(80.sp, "Tue"),
                  _buildBarChart(45.sp, "Wed"),
                  _buildBarChart(90.sp, "Thu"),
                  _buildBarChart(70.sp, "Fri"),
                  _buildBarChart(100.sp, "Sat"),
                  _buildBarChart(85.sp, "Sun"),
                ],
              ),
            ),
            SizedBox(height: 10.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Weekly Total: CHF 530", style: lighttitlestyle.copyWith(fontSize: 12.sp, color: Colors.grey[600])),
                Text("↑ 12% vs last week", style: lighttitlestyle.copyWith(fontSize: 12.sp, color: Colors.red[600])),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart(double height, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 20.sp,
          height: height,
          decoration: BoxDecoration(
            color: primaryClr.withAlpha(150),
            borderRadius: BorderRadius.circular(4.sp),
          ),
        ),
        SizedBox(height: 5.sp),
        Text(label, style: lighttitlestyle.copyWith(fontSize: 10.sp, color: Colors.grey[600])),
      ],
    );
  }

  incomeVsExpensesCard() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(15.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.sp),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Income vs Expenses", style: titlestyle),
            SizedBox(height: 15.sp),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 80.sp,
                        height: 80.sp,
                        child: Stack(
                          children: [
                            CircularProgressIndicator(
                              value: 0.67,
                              strokeWidth: 8.sp,
                              backgroundColor: Colors.grey[200],
                              valueColor: AlwaysStoppedAnimation<Color>(primaryClr),
                            ),
                            Center(
                              child: Text("67%", style: titlestyle.copyWith(fontSize: 14.sp, color: primaryClr)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.sp),
                      Text("Income", style: lighttitlestyle.copyWith(fontSize: 12.sp)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 80.sp,
                        height: 80.sp,
                        child: Stack(
                          children: [
                            CircularProgressIndicator(
                              value: 0.45,
                              strokeWidth: 8.sp,
                              backgroundColor: Colors.grey[200],
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.red[600]!),
                            ),
                            Center(
                              child: Text("45%", style: titlestyle.copyWith(fontSize: 14.sp, color: Colors.red[600])),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.sp),
                      Text("Expenses", style: lighttitlestyle.copyWith(fontSize: 12.sp)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.sp),
            Container(
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8.sp),
              ),
              child: Row(
                children: [
                  Icon(Icons.trending_up, color: Colors.green[600], size: 16.sp),
                  SizedBox(width: 8.sp),
                  Expanded(
                    child: Text("You're saving CHF 1,050 this month!", 
                      style: lighttitlestyle.copyWith(fontSize: 12.sp, color: Colors.green[700])),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  categorySpendingCard() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(15.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.sp),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Spending by Category", style: titlestyle),
            SizedBox(height: 15.sp),
            _buildCategoryItem("Food & Dining", 450, primaryClr, Icons.restaurant),
            _buildCategoryItem("Transportation", 320, Colors.blue, Icons.directions_car),
            _buildCategoryItem("Shopping", 280, Colors.purple, Icons.shopping_bag),
            _buildCategoryItem("Entertainment", 180, Colors.orange, Icons.movie),
            _buildCategoryItem("Utilities", 150, Colors.red, Icons.home),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String category, double amount, Color color, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.sp),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(
              color: color.withAlpha(50),
              borderRadius: BorderRadius.circular(8.sp),
            ),
            child: Icon(icon, color: color, size: 16.sp),
          ),
          SizedBox(width: 12.sp),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category, style: lighttitlestyle.copyWith(fontSize: 13.sp)),
                Container(
                  height: 4.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.sp),
                    color: Colors.grey[200],
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: amount / 500,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.sp),
                        color: color,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text("CHF ${amount.toStringAsFixed(0)}", 
            style: titlestyle.copyWith(fontSize: 12.sp, color: color)),
        ],
      ),
    );
  }

  recentTransactionsCard() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(15.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.sp),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Recent Transactions", style: titlestyle),
                TextButton(
                  onPressed: () {},
                  child: Text("View All", style: lighttitlestyle.copyWith(fontSize: 12.sp, color: primaryClr)),
                ),
              ],
            ),
            SizedBox(height: 10.sp),
            _buildTransactionItem("Uber Eats", "Today, 2:30 PM", "-CHF 24.50", Icons.restaurant, Colors.red),
            _buildTransactionItem("Salary", "Today, 9:00 AM", "+CHF 3,200", Icons.account_balance_wallet, Colors.green),
            _buildTransactionItem("Netflix", "Yesterday, 6:45 PM", "-CHF 15.99", Icons.movie, Colors.red),
            _buildTransactionItem("Gas Station", "Yesterday, 4:20 PM", "-CHF 45.20", Icons.local_gas_station, Colors.red),
            _buildTransactionItem("Freelance Payment", "2 days ago, 3:15 PM", "+CHF 500", Icons.work, Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(String title, String time, String amount, IconData icon, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.sp),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(
              color: color.withAlpha(50),
              borderRadius: BorderRadius.circular(8.sp),
            ),
            child: Icon(icon, color: color, size: 16.sp),
          ),
          SizedBox(width: 12.sp),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: lighttitlestyle.copyWith(fontSize: 13.sp)),
                Text(time, style: lighttitlestyle.copyWith(fontSize: 11.sp, color: Colors.grey[600])),
              ],
            ),
          ),
          Text(amount, style: titlestyle.copyWith(fontSize: 13.sp, color: color)),
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
                Text("CHF 20.25", style: lighttitlestyle,),
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