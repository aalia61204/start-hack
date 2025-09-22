import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/themes.dart';
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
          style: titlestyle.copyWith(fontSize: 18.sp),
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
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _selectedPeriod,
                    style: lighttitlestyle.copyWith(fontSize: 14.sp),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Budget Overview Card
            _buildBudgetOverviewCard(),
            const SizedBox(height: 24),
            
            // Insights Section
            _buildInsightsSection(),
            const SizedBox(height: 24),
            
            // Spending Categories Chart
            _buildSpendingCategoriesChart(),
            const SizedBox(height: 24),
            
            // Monthly Trend Chart
            _buildMonthlyTrendChart(),
            const SizedBox(height: 24),
            
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
      padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isOverBudget 
            ? [Colors.red[400]!, Colors.red[600]!]
            : [Colors.blue.shade800, primaryClr],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.sp),
        boxShadow: [
          BoxShadow(
            color: (isOverBudget ? Colors.red : primaryClr).withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 3,
            offset: const Offset(0, 4),
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
                style: lighttitlestyle.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _selectedPeriod,
                  style: lighttitlestyle.copyWith(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CHF ${_analyticsData.totalSpent.toStringAsFixed(0)}',
                    style: titlestyle.copyWith(
                      color: Colors.white,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    'of CHF ${_analyticsData.monthlyBudget.toStringAsFixed(0)}',
                    style: lighttitlestyle.copyWith(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'CHF ${_analyticsData.budgetRemaining.toStringAsFixed(0)}',
                    style: titlestyle.copyWith(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'remaining',
                    style: lighttitlestyle.copyWith(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: budgetUsed.clamp(0.0, 1.0),
            backgroundColor: Colors.white.withOpacity(0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 8,
          ),
          const SizedBox(height: 8),
          Text(
            '${(budgetUsed * 100).toStringAsFixed(1)}% of budget used',
            style: lighttitlestyle.copyWith(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12.sp,
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
          style: titlestyle.copyWith(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15.sp),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
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
    IconData trendIcon;

    switch (insight.trend) {
      case 'up':
        trendColor = Colors.red.shade600;
        trendIcon = Icons.trending_up;
        break;
      case 'down':
        trendColor = Colors.green.shade600;
        trendIcon = Icons.trending_down;
        break;
      default:
        trendColor = Colors.grey.shade500;
        trendIcon = Icons.trending_flat;
    }

    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                  color: trendColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.sp),
                ),
                child: Icon(trendIcon, color: trendColor, size: 20.sp),
              ),
              const Spacer(),
              Text(
                insight.value,
                style: titlestyle.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: trendColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.sp),
          Text(
            insight.title,
            style: titlestyle.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4.sp),
          Text(
            insight.description,
            style: lighttitlestyle.copyWith(
              fontSize: 11.sp,
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
          style: titlestyle.copyWith(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15.sp),
        Container(
          padding: EdgeInsets.all(20.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.sp),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: PieChart(
            dataMap: dataMap,
            animationDuration: const Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width / 2.5,
            colorList: colorList,
            initialAngleInDegree: 0,
            chartType: ChartType.disc,
            ringStrokeWidth: 32,
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendTextStyle: lighttitlestyle.copyWith(fontSize: 12.sp),
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: false,
              showChartValues: false,
              showChartValuesInPercentage: false,
              showChartValuesOutside: false,
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
          style: titlestyle.copyWith(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15.sp),
        Container(
          height: 200,
          padding: EdgeInsets.all(20.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.sp),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 4),
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
        final height = (data.amount / maxAmount) * 120;
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'CHF ${data.amount.toStringAsFixed(0)}',
              style: lighttitlestyle.copyWith(
                fontSize: 10.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 4.sp),
            Container(
              width: 30,
              height: height,
              decoration: BoxDecoration(
                color: primaryClr,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(height: 8.sp),
            Text(
              data.month,
              style: lighttitlestyle.copyWith(
                fontSize: 12.sp,
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
          style: titlestyle.copyWith(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15.sp),
        ..._analyticsData.categories.map((category) {
          final percentage = (_analyticsData.totalSpent > 0) ? (category.amount / _analyticsData.totalSpent) * 100 : 0;
          return Container(
            margin: EdgeInsets.only(bottom: 12.sp),
            padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18.sp),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 40.sp,
                  height: 40.sp,
                  decoration: BoxDecoration(
                    color: Color(int.parse(category.color.replaceAll('#', '0xFF'))).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.sp),
                  ),
                  child: Center(
                    child: Text(
                      category.icon,
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ),
                ),
                SizedBox(width: 16.sp),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.name,
                        style: titlestyle.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4.sp),
                      Text(
                        '${percentage.toStringAsFixed(1)}% of total spending',
                        style: lighttitlestyle.copyWith(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'CHF ${category.amount.toStringAsFixed(0)}',
                  style: titlestyle.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
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