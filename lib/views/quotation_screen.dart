import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotation/components/common/app_loader.dart';
import 'package:quotation/components/common/header.dart';
import 'package:quotation/components/cards/currency_card.dart';
import 'package:quotation/components/cards/custom_quotation.dart';
import 'package:quotation/components/common/titled_separator.dart';
import 'package:quotation/data/api/exchange_api.dart';
import 'package:quotation/domain/repositories/exchange_repositorie.dart';
import 'package:quotation/services/quotation_service.dart';
import 'package:quotation/utils/bid_formatters.dart';
import 'package:quotation/utils/colors.dart';
import 'package:quotation/view_model/quotation_view_model.dart';

class QuotationScreen extends StatefulWidget {
  const QuotationScreen({super.key});

  @override
  State<QuotationScreen> createState() => _QuotationScreenState();
}

class _QuotationScreenState extends State<QuotationScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<QuotationViewModel>().fetchQuotations());
  }

  Future<void> _refresh() async {
    await context.read<QuotationViewModel>().fetchQuotations();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<QuotationViewModel>();
    final exchangeRepository = ExchangeRepository(api: ExchangeApi());
    final quotationService = QuotationService(exchangeRepository: exchangeRepository);

    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          children: [
            Header(),
            const TitledSeparator(title: "Quotations"),
            if (viewModel.isLoading)
              const AppLoader()
            else if (viewModel.quotationUSD != null &&
                viewModel.quotationEUR != null &&
                viewModel.quotationBTC != null)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomQuotation(
                    selectedCurrencyFrom: "USD",
                    selectedCurrencyTo: "BRL",
                    service: quotationService,
                  ),
                  if (viewModel.quotationUSD != null)
                    CurrencyCard(
                      currency: "US Dollar [USD]",
                      bid: formatToTwoDecimalPlaces(viewModel.quotationUSD?['bid'] ?? 0.0),
                      max: formatToTwoDecimalPlaces(viewModel.quotationUSD?['high'] ?? 0.0),
                      min: formatToTwoDecimalPlaces(viewModel.quotationUSD?['low'] ?? 0.0),
                      isValuating: viewModel.quotationUSD?['isCurrencyValuating'] ?? false,
                    ),
                  if (viewModel.quotationEUR != null)
                    CurrencyCard(
                      currency: "Euro [EUR]",
                      bid: formatToTwoDecimalPlaces(viewModel.quotationEUR?['bid'] ?? 0.0),
                      max: formatToTwoDecimalPlaces(viewModel.quotationEUR?['high'] ?? 0.0),
                      min: formatToTwoDecimalPlaces(viewModel.quotationEUR?['low'] ?? 0.0),
                      isValuating: viewModel.quotationEUR?['isCurrencyValuating'] ?? false,
                    ),
                  if (viewModel.quotationBTC != null)
                    CurrencyCard(
                      currency: "Bitcoin [BTC]",
                      bid: formatBitcoinValue(viewModel.quotationBTC?['bid'] ?? 0.0),
                      max: formatBitcoinValue(viewModel.quotationBTC?['high'] ?? 0.0),
                      min: formatBitcoinValue(viewModel.quotationBTC?['low'] ?? 0.0),
                      isValuating: viewModel.quotationBTC?['isCurrencyValuating'] ?? false,
                    ),
                ],
              )

            else
              const Text(
                'No data at the moment',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
