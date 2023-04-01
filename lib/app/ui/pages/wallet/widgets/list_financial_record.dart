import 'package:flutter/material.dart';
import 'package:mercurium_app/app/data/models/financial_record_model.dart';
import 'package:mercurium_app/app/ui/pages/wallet/widgets/item_financial_record.dart';

class ListFinancialRecord extends StatelessWidget {
  final Future<List<FinancialRecordModel>>? future;
  const ListFinancialRecord({
    super.key,
    required this.future,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Center(
              child: Text("Você não está conectado"),
            );
          case ConnectionState.active:
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            List<FinancialRecordModel>? data = snapshot.data;

            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return ItemFinancialRecord(
                    data: data,
                    index: index,
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                  child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.60,
                child: Text(
                  "${snapshot.error}".substring(11),
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ));
            } else {
              return const Center(
                  child: Text(
                "Não tem nada na carteira",
                style: TextStyle(fontSize: 14),
              ));
            }
        }
      },
    );
  }
}
