class BankModel {
  int? zEILENNR;
  String? tRXDATE;
  double? aMOUNT;
  String? tEXTDEBITOR;
  String? tEXTCREDITOR;
  String? pOINTOFSALEANDLOCATION;
  String? tRXTYPESHORT;
  String? bUCHUNGSARTNAME;
  String? cATEGORY;
  double? aMOUNTNUM;

  BankModel(
      {this.zEILENNR,
      this.tRXDATE,
      this.aMOUNT,
      this.tEXTDEBITOR,
      this.tEXTCREDITOR,
      this.pOINTOFSALEANDLOCATION,
      this.tRXTYPESHORT,
      this.bUCHUNGSARTNAME,
      this.cATEGORY,
      this.aMOUNTNUM});

  BankModel.fromJson(Map<String, dynamic> json) {
    zEILENNR = json['ZEILEN_NR'];
    tRXDATE = json['TRX_DATE'];
    aMOUNT = (json['AMOUNT'] as num?)?.toDouble();
    tEXTDEBITOR = json['TEXT_DEBITOR'];
    tEXTCREDITOR = json['TEXT_CREDITOR'];
    pOINTOFSALEANDLOCATION = json['POINT_OF_SALE_AND_LOCATION'];
    tRXTYPESHORT = json['TRX_TYPE_SHORT'];
    bUCHUNGSARTNAME = json['BUCHUNGS_ART_NAME'];
    cATEGORY = json['CATEGORY'];
    aMOUNTNUM = (json['AMOUNT_NUM'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ZEILEN_NR'] = zEILENNR;
    data['TRX_DATE'] = tRXDATE;
    data['AMOUNT'] = aMOUNT;
    data['TEXT_DEBITOR'] = tEXTDEBITOR;
    data['TEXT_CREDITOR'] = tEXTCREDITOR;
    data['POINT_OF_SALE_AND_LOCATION'] = pOINTOFSALEANDLOCATION;
    data['TRX_TYPE_SHORT'] = tRXTYPESHORT;
    data['BUCHUNGS_ART_NAME'] = bUCHUNGSARTNAME;
    data['CATEGORY'] = cATEGORY;
    data['AMOUNT_NUM'] = aMOUNTNUM;
    return data;
  }
}