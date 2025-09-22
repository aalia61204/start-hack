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
              servicesTile(),
              recentTransactionsCard(),
              financialInsightsCard(),
              categorySpendingCard(),
              transactionHistoryCard(),
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade800,
              primaryClr,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: primaryClr.withOpacity(0.2),
              offset: Offset(0, 10),
              blurRadius: 20,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Balance",
              style: lighttitlestyle.copyWith(
                fontSize: 12.sp,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 5.sp),
            Text(
              "CHF 2402.10",
              style: titlestyle.copyWith(
                fontSize: 26.sp,
                color: Colors.white,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  servicesTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Quick Services", style: titlestyle.copyWith(fontSize: 18.sp, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 15.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildServiceItem(
                  icon: Icons.qr_code_scanner,
                  label: "Scan & Pay",
                  color: Colors.deepPurpleAccent.shade400,
                ),
              ),
              SizedBox(width: 12.sp),
              Expanded(
                child: _buildServiceItem(
                  icon: Icons.swap_horiz,
                  label: "Transfer",
                  color: Colors.orange.shade700,
                ),
              ),
              SizedBox(width: 12.sp),
              Expanded(
                child: _buildServiceItem(
                  icon: Icons.history,
                  label: "Statements",
                  color: Colors.teal.shade600,
                ),
              ),
              SizedBox(width: 12.sp),
              Expanded(
                child: _buildServiceItem(
                  icon: Icons.credit_card,
                  label: "Cards",
                  color: Colors.pink.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem({required IconData icon, required String label, required Color color}) {
    return GestureDetector(
      onTap: () {
        print("Tapped on $label service");
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 5.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.sp),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [color.withOpacity(0.9), color],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Icon(icon, size: 22.sp, color: Colors.white),
            ),
            SizedBox(height: 10.sp),
            Text(
              label,
              style: lighttitlestyle.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w600, color: Colors.grey[800]),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
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
            _buildTransactionItem(title: "Uber Eats", date: "Today, 2:30 PM", amount: "-CHF 24.50", icon: Icons.restaurant, color: Colors.red),
            _buildTransactionItem(title: "Salary", date: "Today, 9:00 AM", amount: "+CHF 3,200", icon: Icons.account_balance_wallet, color: Colors.green),
            _buildTransactionItem(title: "Netflix", date: "Yesterday, 6:45 PM", amount: "-CHF 15.99", icon: Icons.movie, color: Colors.red),
            _buildTransactionItem(title: "Gas Station", date: "Yesterday, 4:20 PM", amount: "-CHF 45.20", icon: Icons.local_gas_station, color: Colors.red),
            _buildTransactionItem(title: "Freelance Payment", date: "2 days ago, 3:15 PM", amount: "+CHF 500", icon: Icons.work, color: Colors.green),
          ],
        ),
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
          Text("CHF ${amount.toStringAsFixed(0)}", style: titlestyle.copyWith(fontSize: 12.sp, color: color)),
        ],
      ),
    );
  }

  transactionHistoryCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Transaction History", style: titlestyle.copyWith(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 15.sp),
            _buildTransactionItem(
              title: "Spotify Subscription",
              date: "Nov 20, 2025",
              amount: "-CHF 12.99",
              icon: Icons.music_note,
              color: Colors.green.shade700,
            ),
            _buildTransactionItem(
              title: "Online Shopping",
              date: "Nov 18, 2025",
              amount: "-CHF 75.50",
              icon: Icons.shopping_cart,
              color: Colors.blue.shade700,
            ),
            _buildTransactionItem(
              title: "Coffee Shop",
              date: "Nov 17, 2025",
              amount: "-CHF 4.25",
              icon: Icons.local_cafe,
              color: Colors.brown.shade700,
            ),
            _buildTransactionItem(
              title: "Gym Membership",
              date: "Nov 15, 2025",
              amount: "-CHF 50.00",
              icon: Icons.fitness_center,
              color: Colors.red.shade700,
            ),
            _buildTransactionItem(
              title: "Received from John",
              date: "Nov 12, 2025",
              amount: "+CHF 200.00",
              icon: Icons.person_add,
              color: Colors.indigo.shade700,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String date,
    required String amount,
    required IconData icon,
    required Color color,
  }) {
    bool isCredit = amount.startsWith("+");
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15.sp),
            ),
            child: Icon(icon, color: color, size: 20.sp),
          ),
          SizedBox(width: 15.sp),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: lighttitlestyle.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black87),
                ),
                Text(
                  date,
                  style: lighttitlestyle.copyWith(fontSize: 12.sp, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: titlestyle.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w700, color: isCredit ? Colors.green.shade600 : Colors.red.shade600),
          ),
        ],
      ),
    );
  }
}