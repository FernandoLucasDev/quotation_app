import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotation/data/api/exchange_api.dart';
import 'package:quotation/domain/repositories/exchange_repositorie.dart';
import 'package:quotation/services/quotation_service.dart';
import 'package:quotation/view_model/quotation_view_model.dart';
import 'package:quotation/views/quotation_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ExchangeApi>(
          create: (_) => ExchangeApi(),
        ),
        ProxyProvider<ExchangeApi, ExchangeRepository>(
          update: (_, api, __) => ExchangeRepository(api: api),
        ),
        ChangeNotifierProxyProvider<ExchangeRepository, QuotationViewModel>(
          create: (_) => QuotationViewModel(
            service: QuotationService(
              exchangeRepository: ExchangeRepository(api: ExchangeApi()),
            ),
          ),
          update: (_, repository, model) => model!..updateRepository(repository),
        ),
      ],
      child: MaterialApp(
        title: 'Quotation App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: QuotationScreen(),
      ),
    );
  }
}
