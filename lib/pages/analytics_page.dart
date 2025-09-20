import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../features/analytics/analytics_models.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late AnalyticsData _analyticsData;
  String _selectedPeriod = 'This Month';

  @override
  void initState() {
    super.initState();
    _analyticsData = AnalyticsData.demoData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Analytics',
          style: GoogleFonts.inter(
            fontSize: 2.5.h,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedPeriod = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'This Week', child: Text('This Week')),
              const PopupMenuItem(value: 'This Month', child: Text('This Month')),
              const PopupMenuItem(value: 'This Year', child: Text('This Year')),
            ],
            child: Container(
              margin: EdgeInsets.only(right: 2.w),
              padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 0.8.h),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(2.5.h),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _selectedPeriod,
                    style: GoogleFonts.inter(fontSize: 1.7.h),
                  ),
                  SizedBox(width: 0.5.w),
                  Icon(Icons.keyboard_arrow_down, size: 2.h),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Budget Overview Card
            _buildBudgetOverviewCard(),
            SizedBox(height: 3.h),
            
            // Insights Section
            _buildInsightsSection(),
            SizedBox(height: 3.h),
            
            // Spending Categories Chart
            _buildSpendingCategoriesChart(),
            SizedBox(height: 3.h),
            
            // Monthly Trend Chart
            _buildMonthlyTrendChart(),
            SizedBox(height: 3.h),
            
            // Category Breakdown List
            _buildCategoryBreakdownList(),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetOverviewCard() {
    final budgetUsed = _analyticsData.totalSpent / _analyticsData.monthlyBudget;
    final isOverBudget = budgetUsed > 1.0;
    
    return Container(
      padding: EdgeInsets.all(2.5.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isOverBudget 
            ? [Colors.red[400]!, Colors.red[600]!]
            : [Colors.blue[400]!, Colors.blue[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(2.h),
        boxShadow: [
          BoxShadow(
            color: (isOverBudget ? Colors.red : Colors.blue).withOpacity(0.3),
            blurRadius: 1.2.h,
            offset: Offset(0, 0.5.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Budget Overview',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 2.2.h,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(1.5.h),
                ),
                child: Text(
                  _selectedPeriod,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 1.5.h,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CHF ${_analyticsData.totalSpent.toStringAsFixed(0)}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 3.5.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'of CHF ${_analyticsData.monthlyBudget.toStringAsFixed(0)}',
                    style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 1.7.h,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'CHF ${_analyticsData.budgetRemaining.toStringAsFixed(0)}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 2.5.h,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'remaining',
                    style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 1.5.h,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 2.h),
          LinearProgressIndicator(
            value: budgetUsed.clamp(0.0, 1.0),
            backgroundColor: Colors.white.withOpacity(0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 1.h,
          ),
          SizedBox(height: 1.h),
          Text(
            '${(budgetUsed * 100).toStringAsFixed(1)}% of budget used',
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.9),
              fontSize: 1.5.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Insights',
          style: GoogleFonts.inter(
            fontSize: 2.5.h,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 2.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: 1.5.w,
            mainAxisSpacing: 1.5.h,
          ),
          itemCount: _analyticsData.insights.length,
          itemBuilder: (context, index) {
            final insight = _analyticsData.insights[index];
            return _buildInsightCard(insight);
          },
        ),
      ],
    );
  }

  Widget _buildInsightCard(SpendingInsight insight) {
    Color trendColor;
    switch (insight.trend) {
      case 'up':
        trendColor = Colors.red;
        break;
      case 'down':
        trendColor = Colors.green;
        break;
      default:
        trendColor = Colors.orange;
    }

    return Container(
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(1.5.h),
        border: Border.all(color: Colors.grey[200]!),
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
          Row(
            children: [
              Text(
                insight.icon,
                style: TextStyle(fontSize: 2.5.h),
              ),
              const Spacer(),
              Icon(
                insight.trend == 'up' 
                  ? Icons.trending_up 
                  : insight.trend == 'down' 
                    ? Icons.trending_down 
                    : Icons.trending_flat,
                color: trendColor,
                size: 2.h,
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            insight.title,
            style: GoogleFonts.inter(
              fontSize: 1.7.h,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            insight.value,
            style: GoogleFonts.inter(
              fontSize: 2.2.h,
              fontWeight: FontWeight.bold,
              color: trendColor,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            insight.description,
            style: GoogleFonts.inter(
              fontSize: 1.3.h,
              color: Colors.grey[600],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildSpendingCategoriesChart() {
    final dataMap = <String, double>{};
    for (var category in _analyticsData.categories) {
      dataMap[category.name] = category.amount;
    }

    final colorList = _analyticsData.categories
        .map((category) => Color(int.parse(category.color.replaceAll('#', '0xFF'))))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Spending by Category',
          style: GoogleFonts.inter(
            fontSize: 2.5.h,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 2.h),
        Container(
          padding: EdgeInsets.all(2.5.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2.h),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 0.5.h,
                offset: Offset(0, 0.2.h),
              ),
            ],
          ),
          child: PieChart(
            dataMap: dataMap,
            animationDuration: const Duration(milliseconds: 800),
            chartLegendSpacing: 4.w,
            chartRadius: 30.w,
            colorList: colorList,
            initialAngleInDegree: 0,
            chartType: ChartType.ring,
            ringStrokeWidth: 4.w,
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendShape: BoxShape.circle,
              legendTextStyle: TextStyle(fontSize: 1.5.h),
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
              decimalPlaces: 0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMonthlyTrendChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Monthly Spending Trend',
          style: GoogleFonts.inter(
            fontSize: 2.5.h,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 2.h),
        Container(
          height: 25.h,
          padding: EdgeInsets.all(2.5.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2.h),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 0.5.h,
                offset: Offset(0, 0.2.h),
              ),
            ],
          ),
          child: _buildSimpleBarChart(),
        ),
      ],
    );
  }

  Widget _buildSimpleBarChart() {
    final maxAmount = _analyticsData.monthlyData
        .map((e) => e.amount)
        .reduce((a, b) => a > b ? a : b);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: _analyticsData.monthlyData.map((data) {
        final height = (data.amount / maxAmount) * 15.h;
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'CHF ${data.amount.toStringAsFixed(0)}',
              style: GoogleFonts.inter(
                fontSize: 1.2.h,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 0.5.h),
            Container(
              width: 4.w,
              height: height,
              decoration: BoxDecoration(
                color: Colors.blue[400],
                borderRadius: BorderRadius.circular(0.5.h),
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              data.month,
              style: GoogleFonts.inter(
                fontSize: 1.5.h,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildCategoryBreakdownList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category Breakdown',
          style: GoogleFonts.inter(
            fontSize: 2.5.h,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 2.h),
        ..._analyticsData.categories.map((category) {
          final percentage = (category.amount / _analyticsData.totalSpent) * 100;
          return Container(
            margin: EdgeInsets.only(bottom: 1.5.h),
            padding: EdgeInsets.all(2.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(1.5.h),
              border: Border.all(color: Colors.grey[200]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 0.5.h,
                  offset: Offset(0, 0.2.h),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 5.h,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: Color(int.parse(category.color.replaceAll('#', '0xFF'))).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(1.h),
                  ),
                  child: Center(
                    child: Text(
                      category.icon,
                      style: TextStyle(fontSize: 2.5.h),
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.name,
                        style: GoogleFonts.inter(
                          fontSize: 2.h,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        '${percentage.toStringAsFixed(1)}% of total spending',
                        style: GoogleFonts.inter(
                          fontSize: 1.5.h,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'CHF ${category.amount.toStringAsFixed(0)}',
                  style: GoogleFonts.inter(
                    fontSize: 2.h,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}