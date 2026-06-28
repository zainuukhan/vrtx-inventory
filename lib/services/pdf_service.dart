import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/invoice.dart';

class PdfService {
  static Future<File> generateInvoice(Invoice invoice) async {
    final pdf = pw.Document();

    final logo = await rootBundle.load("assets/logo.png");
    final image = pw.MemoryImage(logo.buffer.asUint8List());

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(24),

        build: (context) => [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Image(image, width: 70, height: 70),

              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    "VRTX Inventory",
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),

                  pw.Text("Invoice", style: const pw.TextStyle(fontSize: 18)),
                ],
              ),
            ],
          ),

          pw.SizedBox(height: 25),

          pw.Divider(),

          pw.SizedBox(height: 15),

          infoRow("Invoice ID", invoice.invoiceId),
          infoRow("Customer", invoice.customerName),
          infoRow("Phone", invoice.phone.isEmpty ? "-" : invoice.phone),
          infoRow(
            "Date",
            DateFormat("dd MMM yyyy  hh:mm a").format(invoice.dateTime),
          ),

          pw.SizedBox(height: 20),

          buildTable(invoice),

          pw.SizedBox(height: 25),

          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Container(
              width: 220,
              child: pw.Column(
                children: [
                  totalRow("Total Sale", invoice.totalSale),
                  totalRow("Total Profit", invoice.totalProfit),
                ],
              ),
            ),
          ),

          pw.SizedBox(height: 40),

          pw.Center(
            child: pw.Text(
              "Thank you for your business!",
              style: const pw.TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );

    final directory = await getApplicationDocumentsDirectory();

    final file = File("${directory.path}/${invoice.invoiceId}.pdf");

    await file.writeAsBytes(await pdf.save());

    return file;
  }

  static pw.Widget infoRow(String title, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        children: [
          pw.SizedBox(
            width: 90,
            child: pw.Text(
              title,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Text(value),
        ],
      ),
    );
  }

  static pw.Widget totalRow(String title, double value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 5),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Text("Rs ${value.toStringAsFixed(0)}"),
        ],
      ),
    );
  }

  static pw.Widget buildTable(Invoice invoice) {
    return pw.Table.fromTextArray(
      border: pw.TableBorder.all(),

      headers: const ["Product", "Qty", "Price", "Total"],

      data: invoice.items.map((e) {
        return [
          e.productName,
          e.quantity.toString(),
          e.sellingPrice.toStringAsFixed(0),
          e.totalSale.toStringAsFixed(0),
        ];
      }).toList(),
    );
  }
}
