import 'package:flutter/material.dart';

class ReservationModel {
  String clientName, clientId;
  int numofRserve;
  ReservationModel({
    @required this.clientName,
    @required this.clientId,
    @required this.numofRserve,
  });
}
