class SpendingCategory {
  final String name;
  final double amount;
  final String color;
  final String icon;

  const SpendingCategory({
    required this.name,
    required this.amount,
    required this.color,
    required this.icon,
  });
}

class MonthlySpending {
  final String month;
  final double amount;
  final int year;

  const MonthlySpending({
    required this.month,
    required this.amount,
    required this.year,
  });
}

class SpendingInsight {
  final String title;
  final String description;
  final String value;
  final String trend; // 'up', 'down', 'stable'
  final String icon;

  const SpendingInsight({
    required this.title,
    required this.description,
    required this.value,
    required this.trend,
    required this.icon,
  });
}

class AnalyticsData {
  final List<SpendingCategory> categories;
  final List<MonthlySpending> monthlyData;
  final List<SpendingInsight> insights;
  final double totalSpent;
  final double monthlyBudget;
  final double budgetRemaining;

  const AnalyticsData({
    required this.categories,
    required this.monthlyData,
    required this.insights,
    required this.totalSpent,
    required this.monthlyBudget,
    required this.budgetRemaining,
  });

  // Demo data for the analytics page
  static AnalyticsData get demoData => AnalyticsData(
        categories: const [
          SpendingCategory(
            name: 'Food & Dining',
            amount: 850.0,
            color: '#FF6B6B',
            icon: '🍽️',
          ),
          SpendingCategory(
            name: 'Transportation',
            amount: 420.0,
            color: '#4ECDC4',
            icon: '🚗',
          ),
          SpendingCategory(
            name: 'Shopping',
            amount: 680.0,
            color: '#45B7D1',
            icon: '🛍️',
          ),
          SpendingCategory(
            name: 'Entertainment',
            amount: 320.0,
            color: '#96CEB4',
            icon: '🎬',
          ),
          SpendingCategory(
            name: 'Utilities',
            amount: 180.0,
            color: '#FFEAA7',
            icon: '⚡',
          ),
          SpendingCategory(
            name: 'Healthcare',
            amount: 150.0,
            color: '#DDA0DD',
            icon: '🏥',
          ),
        ],
        monthlyData: const [
          MonthlySpending(month: 'Jan', amount: 2200.0, year: 2024),
          MonthlySpending(month: 'Feb', amount: 1950.0, year: 2024),
          MonthlySpending(month: 'Mar', amount: 2400.0, year: 2024),
          MonthlySpending(month: 'Apr', amount: 2100.0, year: 2024),
          MonthlySpending(month: 'May', amount: 2600.0, year: 2024),
          MonthlySpending(month: 'Jun', amount: 2300.0, year: 2024),
        ],
        insights: const [
          SpendingInsight(
            title: 'Top Spending Category',
            description: 'Food & Dining is your biggest expense this month',
            value: 'CHF 850',
            trend: 'up',
            icon: '📈',
          ),
          SpendingInsight(
            title: 'Budget Status',
            description: 'You\'re 15% over budget this month',
            value: 'CHF 2,600',
            trend: 'up',
            icon: '⚠️',
          ),
          SpendingInsight(
            title: 'Savings Rate',
            description: 'You saved 8% more than last month',
            value: '12%',
            trend: 'up',
            icon: '💰',
          ),
          SpendingInsight(
            title: 'Average Daily Spend',
            description: 'Your daily average is CHF 87',
            value: 'CHF 87',
            trend: 'stable',
            icon: '📊',
          ),
        ],
        totalSpent: 2600.0,
        monthlyBudget: 5000.0,
        budgetRemaining: 2400.0,
      );
}
