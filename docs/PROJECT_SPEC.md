# PROJECT SPEC — SGKB AI Finance Manager (Flutter + Firebase)

## Goal

A self-contained AI Finance Manager app with demo data (no file upload).

## MVP Features

- Seed demo transactions (no Excel upload)
- Auto-categorise each row with a reason (rules now; IBM later)
- Merchant logos (cached or category icon fallback)
- Q&A chips:
  Swisscom invoices, Summer holiday total, Most expensive month,
  Spend by country, ATM withdrawals (last year),
  Monthly fixed costs, Subscriptions total, Transport split (Car vs Public)
- Monthly insights document for fast UI (per YYYY-MM)
- Export CSV of enriched data

## Stack

Flutter (Riverpod, go_router, fl_chart, cached_network_image)
Firebase: Auth, Firestore, Storage, Functions (TypeScript)
AI: IBM categorisation server-side (optional), rules fallback OK.

## Firestore sketch

users/{uid}
transactions/{trxId}
insights/{YYYY-MM}
merchants/{merchantId}
