import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mercurium_app/app/data/models/financial_record_model.dart';
import 'package:mercurium_app/app/domain/repositories/financial_record_repository.dart';

class FinancialRecordeFirestoreImp implements FinancialRecordRepository {
  final financialRecordRef =
      FirebaseFirestore.instance.collection('financial_record');

  final userRef = FirebaseAuth.instance;

  @override
  Future<List<FinancialRecordModel>> getFinancialRecordsByType(
      String? type) async {
    List<FinancialRecordModel> financialRecordSerialized = [];

    try {
      var financialRecordFirestoreResult = await financialRecordRef
          .where("userId", isEqualTo: userRef.currentUser!.uid)
          .where("type", isEqualTo: type)
          .get();

      for (var financialRecord in financialRecordFirestoreResult.docs) {
        financialRecordSerialized.add(
          FinancialRecordModel.fromJson(
            {
              "id": financialRecord.id,
              "userId": financialRecord.data()["userId"],
              "value": financialRecord.data()["value"],
              "createdAt": financialRecord.data()["createdAt"],
              "receivedAt": financialRecord.data()["receivedAt"],
              "description": financialRecord.data()["description"],
              "type": financialRecord.data()["type"],
              "category": financialRecord.data()["category"],
            },
          ),
        );
      }
    } catch (e) {
      throw Exception(
        "Não foi possível encontrar os dados, tente novamente mais tarde",
      );
    }

    if (financialRecordSerialized.isEmpty) {
      throw Exception(
        "Não tem nada na carteira",
      );
    }

    return financialRecordSerialized;
  }

  @override
  Future<List<FinancialRecordModel>> getAllFinancialRecords() async {
    List<FinancialRecordModel> financialRecordSerialized = [];

    try {
      var financialRecordFirestoreResult = await financialRecordRef
          .where("userId", isEqualTo: userRef.currentUser!.uid)
          .get();

      for (var financialRecord in financialRecordFirestoreResult.docs) {
        financialRecordSerialized.add(
          FinancialRecordModel.fromJson(
            {
              "id": financialRecord.id,
              "userId": financialRecord.data()["userId"],
              "value": financialRecord.data()["value"],
              "createdAt": financialRecord.data()["createdAt"],
              "receivedAt": financialRecord.data()["receivedAt"],
              "description": financialRecord.data()["description"],
              "type": financialRecord.data()["type"],
              "category": financialRecord.data()["category"],
            },
          ),
        );
      }
    } catch (e) {
      throw Exception(
        "Não foi possível encontrar os dados, tente novamente mais tarde",
      );
    }

    if (financialRecordSerialized.isEmpty) {
      throw Exception(
        "Não tem nada na carteira",
      );
    }

    return financialRecordSerialized;
  }

  @override
  Future<double> getActualBalance() async {
    double receivedValue = 0;

    try {
      var financialRecordFirestoreResult = await financialRecordRef
          .where('receivedAt', isLessThan: DateTime.now())
          .get();

      for (var financialRecord in financialRecordFirestoreResult.docs) {
        var data = financialRecord.data();

        if (data["type"] == "A receber" &&
            data["userId"] == userRef.currentUser!.uid) {
          receivedValue += data["value"].toDouble();
        }
      }
    } catch (e) {
      throw Exception(
        "Sem conexão",
      );
    }

    return double.parse((receivedValue).toStringAsFixed(2));
  }

  @override
  Future<double> getBalance() async {
    double receivedValue = 0;
    double spentValue = 0;

    try {
      var financialRecordFirestoreResult = await financialRecordRef
          .where("userId", isEqualTo: userRef.currentUser!.uid)
          .get();

      for (var financialRecord in financialRecordFirestoreResult.docs) {
        var data = financialRecord.data();

        if (data["type"] == "A pagar") {
          spentValue += data["value"].toDouble();
        }
        if (data["type"] == "A receber") {
          receivedValue += data["value"].toDouble();
        }
      }
    } catch (e) {
      throw Exception(
        "Sem conexão",
      );
    }

    return double.parse((receivedValue - spentValue).toStringAsFixed(2));
  }

  @override
  Future<double> getBalanceByType(String? type) async {
    double totalValue = 0;

    try {
      var financialRecordFirestoreResult = await financialRecordRef
          .where("type", isEqualTo: type)
          .where("userId", isEqualTo: userRef.currentUser!.uid)
          .get();

      for (var financialRecord in financialRecordFirestoreResult.docs) {
        totalValue += financialRecord.data()["value"].toDouble();
      }
    } catch (e) {
      throw Exception(
        "Sem conexão",
      );
    }

    return totalValue;
  }

  @override
  Future<bool> deleteFinancialRecord(String id) async {
    bool itHasBeenDeleted = false;

    try {
      await financialRecordRef.doc(id).delete();

      itHasBeenDeleted = true;
    } catch (e) {
      itHasBeenDeleted = false;
    }

    return itHasBeenDeleted;
  }

  @override
  Future<bool> createFinancialRecord(
      FinancialRecordModel financialRecordModel) async {
    bool itHasBeenCreated = false;

    try {
      await financialRecordRef.add({
        "userId": userRef.currentUser!.uid,
        "description": financialRecordModel.description,
        "category": financialRecordModel.category,
        "createdAt": financialRecordModel.createdAt,
        "receivedAt": financialRecordModel.receivedAt,
        "value": financialRecordModel.value,
        "type": financialRecordModel.type,
      });

      itHasBeenCreated = true;
    } catch (e) {
      itHasBeenCreated = false;
    }

    return itHasBeenCreated;
  }

  @override
  Future<bool> updateFinancialRecord(
      FinancialRecordModel financialRecordModel) async {
    bool itHasBeenUpdated = false;

    try {
      await financialRecordRef.doc(financialRecordModel.id).update({
        "description": financialRecordModel.description,
        "category": financialRecordModel.category,
        "receivedAt": financialRecordModel.receivedAt,
        "value": financialRecordModel.value,
        "type": financialRecordModel.type,
      });

      itHasBeenUpdated = true;
    } catch (e) {
      itHasBeenUpdated = false;
    }

    return itHasBeenUpdated;
  }
}
