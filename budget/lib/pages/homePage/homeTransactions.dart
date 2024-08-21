import 'package:budget/database/tables.dart';
import 'package:budget/functions.dart';
import 'package:budget/pages/transactionFilters.dart';
import 'package:budget/struct/settings.dart';
import 'package:budget/widgets/transactionEntries.dart';
import 'package:flutter/material.dart';
import 'package:budget/globalState.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeTransactions extends StatelessWidget {
  const HomeTransactions({
    super.key,
    required this.selectedSlidingSelector,
  });
  final int selectedSlidingSelector;
  @override
  Widget build(BuildContext context) {
    SearchFilters searchFilters = SearchFilters(
      expenseIncome:
          appStateSettings["homePageTransactionsListIncomeAndExpenseOnly"] ==
                  true
              ? [
                  if (selectedSlidingSelector == 2) ExpenseIncome.expense,
                  if (selectedSlidingSelector == 3) ExpenseIncome.income
                ]
              : [],
      positiveCashFlow:
          appStateSettings["homePageTransactionsListIncomeAndExpenseOnly"] ==
                  false
              ? selectedSlidingSelector == 2
                  ? false
                  : selectedSlidingSelector == 3
                      ? true
                      : null
              : null,
      walletPks: globalState.selectedAccountIds,
    );
    int numberOfFutureDays = appStateSettings["futureTransactionDaysHomePage"];
    return TransactionEntries(
      showNumberOfDaysUntilForFutureDates: true,
      renderType: TransactionEntriesRenderType.implicitlyAnimatedNonSlivers,
      showNoResults: true,
      DateTime.now().justDay(monthOffset: -1),
      DateTime.now().justDay(dayOffset: numberOfFutureDays),
      dateDividerColor: Colors.transparent,
      useHorizontalPaddingConstrained: false,
      pastDaysLimitToShow: 5,
      limitPerDay: 50,
      searchFilters: searchFilters,
      enableFutureTransactionsCollapse: false,
      noResultsMessage: "no-transactions-found".tr(),
      noResultsPadding: EdgeInsetsDirectional.symmetric(horizontal: 25, vertical: 25),
    );
  }
}
