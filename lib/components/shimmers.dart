import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget ShimmerCardBanner() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Card(
      elevation: 5,
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 400,
              height: 150,
              color: Colors.white, // Use any color for shimmer effect
            ),
          ],
        ),
      ),
    ),
  );
}

Widget ShimmerCardInvoice() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 60,
              height: 40,
              color: Colors.white, // Use any color for shimmer effect
            ),
          ],
        ),
      ),
    ),
  );
}

Widget ShimmerCardsInvoices() {
  return Row(
    children: [
      ShimmerCardInvoice(),
      ShimmerCardInvoice(),
      ShimmerCardInvoice(),
    ],
  );
}

Widget ShimmerCardsTable() {
  return Center(
    child: Container(
        padding: EdgeInsets.all(16.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Table(
            children: [
              TableRow(
                children: [
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                ],
              ),
              TableRow(
                children: [
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                ],
              ),
              TableRow(
                children: [
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                ],
              ),
              TableRow(
                children: [
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                ],
              ),
              TableRow(
                children: [
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                ],
              ),
              TableRow(
                children: [
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                ],
              ),
              // Add more TableRow widgets as needed
            ],
          ),
        )),
  );
}

Widget ShimmerCardsTable2() {
  return Center(
    child: Container(
        padding: EdgeInsets.all(16.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Table(
            children: [
              TableRow(
                children: [
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                ],
              ),
              TableRow(
                children: [
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                ],
              ),
              TableRow(
                children: [
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                ],
              ),
              TableRow(
                children: [
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                ],
              ),
              TableRow(
                children: [
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                ],
              ),
              TableRow(
                children: [
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                  ShimmerTableCell(),
                ],
              ),
              // Add more TableRow widgets as needed
            ],
          ),
        )),
  );
}

Widget ShimmerTableCell() {
  return TableCell(
    child: Container(
      margin: EdgeInsets.all(20.0),
      height: 25.0, // Adjust height according to your design
      color: Colors.white,
    ),
  );
}

Widget ShimmerWeb() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 100, // Ajusta la altura según tus necesidades
            color: Colors.white,
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 30, // Ajusta la altura según tus necesidades
            color: Colors.white,
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 30, // Ajusta la altura según tus necesidades
            color: Colors.white,
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 50, // Ajusta la altura según tus necesidades
            color: Colors.white,
          ),
        ],
      ),
    ),
  );
}

Widget ShimmerAddress() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 10, // Ajusta la altura según tus necesidades
            color: Colors.white,
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 10, // Ajusta la altura según tus necesidades
            color: Colors.white,
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 10, // Ajusta la altura según tus necesidades
            color: Colors.white,
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 10, // Ajusta la altura según tus necesidades
            color: Colors.white,
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 10, // Ajusta la altura según tus necesidades
            color: Colors.white,
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 10, // Ajusta la altura según tus necesidades
            color: Colors.white,
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 10, // Ajusta la altura según tus necesidades
            color: Colors.white,
          ),
        ],
      ),
    ),
  );
}

Widget ShimmerInvoices() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 70, // Ajusta la altura según tus necesidades
            color: Colors.white,
          ),
          SizedBox(height: 15),
          Container(
            width: double.infinity,
            height: 70, // Ajusta la altura según tus necesidades
            color: Colors.white,
          ),
          SizedBox(height: 15),
          Container(
            width: double.infinity,
            height: 70, // Ajusta la altura según tus necesidades
            color: Colors.white,
          ),
          SizedBox(height: 15),
          Container(
            width: double.infinity,
            height: 70, // Ajusta la altura según tus necesidades
            color: Colors.white,
          ),
          SizedBox(height: 15),
          Container(
            width: double.infinity,
            height: 70, // Ajusta la altura según tus necesidades
            color: Colors.white,
          ),
          SizedBox(height: 15),
        ],
      ),
    ),
  );
}


Widget ShimmerPaymentMethods() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildShimmerItem(),
          SizedBox(height: 30),
          _buildShimmerItem(),
          SizedBox(height: 30),
          _buildShimmerItem(),
          SizedBox(height: 30),
          _buildShimmerItem(),
          SizedBox(height: 30),
          _buildShimmerItem(),
          SizedBox(height: 30),
        ],
      ),
    ),
  );
}

Widget ShimmerPaymentMethods2() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildShimmerItem(),
          SizedBox(height: 30),
          _buildShimmerItem(),
          SizedBox(height: 30),
        ],
      ),
    ),
  );
}

Widget _buildShimmerItem() {
  return Container(
    width: double.infinity,
    height: 70, // Ajusta la altura según tus necesidades
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.0), // Ajusta el radio del borde
    ),
  );
}