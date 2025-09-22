# Cursor Rules

- No secrets in code. Env via Firebase Functions config.
- Support Firebase Emulators in debug (localhost).

## Flutter (/app_flutter)

- Packages: firebase_core, firebase_auth, cloud_firestore, firebase_storage, cloud_functions,
  flutter_riverpod, go_router, intl, fl_chart, cached_network_image
- Screens: Home, Transactions, Insights, Settings
- Components: KpiCard, TransactionItem, ChartCard, FilterChip, QaBottomSheet
- Features:
  - Demo Mode: Button "Load Demo Data" (calls cloud function), "Clear Demo Data".
  - Home chips call qa() and show QaBottomSheet.
  - Transactions list shows logoUrl (fallback icon) + “Why?” dialog (uses `reason`).
  - Insights reads insights/{currentMonth}.
  - Settings: Export CSV button (calls exportCsv), Privacy blur toggle.

## Functions (/functions, TypeScript)

- Callable:
  - seedDemoData({clear?: boolean}) -> write demo rows, then compute insights
  - qa({type, params}) -> swisscomInvoices, summerHolidayTotal, mostExpensiveMonth,
    byCountry, atmCount(lastYear), fixedCosts, subscriptions, transportSplit
  - exportCsv() -> writes exports/{uid}/latest.csv, returns signed URL
- Helpers: insights.ts, logos.ts (placeholder ok)
- Keep rule-based categorisation now; IBM later.
