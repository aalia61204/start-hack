class BankModel {
  int? zEILENNR;
  String? mONEYACCOUNTNAME;
  String? mACCURRYID;
  String? mACCURRYNAME;
  String? mACCTYPE;
  String? pRODUKT;
  String? kUNDENNAME;
  String? tRXID;
  String? tRXTYPEID;
  String? tRXTYPESHORT;
  String? tRXTYPENAME;
  String? bUCHUNGSARTSHORT;
  String? bUCHUNGSARTNAME;
  String? vALDATE;
  String? tRXDATE;
  int? dIRECTION;
  double? aMOUNT; // This remains a double
  String? tRXCURRYID;
  String? tRXCURRYNAME;
  String? tEXTSHORTCREDITOR;
  String? tEXTCREDITOR;
  String? tEXTSHORTDEBITOR;
  String? tEXTDEBITOR;
  String? pOINTOFSALEANDLOCATION;
  String? aCQUIRERCOUNTRYID;
  String? aCQUIRERCOUNTRYNAME;
  String? cARDID;
  String? cREDACCTEXT;
  String? cREDIBAN;
  String? cREDADDRTEXT;
  String? cREDREFNR;
  String? cREDINFO;

  BankModel({
    this.zEILENNR,
    this.mONEYACCOUNTNAME,
    this.mACCURRYID,
    this.mACCURRYNAME,
    this.mACCTYPE,
    this.pRODUKT,
    this.kUNDENNAME,
    this.tRXID,
    this.tRXTYPEID,
    this.tRXTYPESHORT,
    this.tRXTYPENAME,
    this.bUCHUNGSARTSHORT,
    this.bUCHUNGSARTNAME,
    this.vALDATE,
    this.tRXDATE,
    this.dIRECTION,
    this.aMOUNT,
    this.tRXCURRYID,
    this.tRXCURRYNAME,
    this.tEXTSHORTCREDITOR,
    this.tEXTCREDITOR,
    this.tEXTSHORTDEBITOR,
    this.tEXTDEBITOR,
    this.pOINTOFSALEANDLOCATION,
    this.aCQUIRERCOUNTRYID,
    this.aCQUIRERCOUNTRYNAME,
    this.cARDID,
    this.cREDACCTEXT,
    this.cREDIBAN,
    this.cREDADDRTEXT,
    this.cREDREFNR,
    this.cREDINFO,
  });

  BankModel.fromJson(Map<String, dynamic> json) {
    zEILENNR = json['ZEILEN_NR'];
    mONEYACCOUNTNAME = json['MONEY_ACCOUNT_NAME'];
    mACCURRYID = json['MAC_CURRY_ID']?.toString();
    mACCURRYNAME = json['MAC_CURRY_NAME'];
    mACCTYPE = json['MACC_TYPE'];
    pRODUKT = json['PRODUKT'];
    kUNDENNAME = json['KUNDEN_NAME'];
    tRXID = json['TRX_ID']?.toString();
    tRXTYPEID = json['TRX_TYPE_ID']?.toString();
    tRXTYPESHORT = json['TRX_TYPE_SHORT'];
    tRXTYPENAME = json['TRX_TYPE_NAME'];
    bUCHUNGSARTSHORT = json['BUCHUNGS_ART_SHORT'];
    bUCHUNGSARTNAME = json['BUCHUNGS_ART_NAME'];
    vALDATE = json['VAL_DATE'];
    tRXDATE = json['TRX_DATE'];
    dIRECTION = json['DIRECTION'];
    aMOUNT = json['AMOUNT']?.toDouble(); // Converted to double
    tRXCURRYID = json['TRX_CURRY_ID']?.toString();
    tRXCURRYNAME = json['TRX_CURRY_NAME'];
    tEXTSHORTCREDITOR = json['TEXT_SHORT_CREDITOR'];
    tEXTCREDITOR = json['TEXT_CREDITOR'];
    tEXTSHORTDEBITOR = json['TEXT_SHORT_DEBITOR'];
    tEXTDEBITOR = json['TEXT_DEBITOR'];
    pOINTOFSALEANDLOCATION = json['POINT_OF_SALE_AND_LOCATION'];
    aCQUIRERCOUNTRYID = json['ACQUIRER_COUNTRY_ID']?.toString();
    aCQUIRERCOUNTRYNAME = json['ACQUIRER_COUNTRY_NAME'];
    cARDID = json['CARD_ID'];
    cREDACCTEXT = json['CRED_ACC_TEXT'];
    cREDIBAN = json['CRED_IBAN'];
    cREDADDRTEXT = json['CRED_ADDR_TEXT'];
    cREDREFNR = json['CRED_REF_NR'];
    cREDINFO = json['CRED_INFO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ZEILEN_NR'] = zEILENNR;
    data['MONEY_ACCOUNT_NAME'] = mONEYACCOUNTNAME;
    data['MAC_CURRY_ID'] = mACCURRYID;
    data['MAC_CURRY_NAME'] = mACCURRYNAME;
    data['MACC_TYPE'] = mACCTYPE;
    data['PRODUKT'] = pRODUKT;
    data['KUNDEN_NAME'] = kUNDENNAME;
    data['TRX_ID'] = tRXID;
    data['TRX_TYPE_ID'] = tRXTYPEID;
    data['TRX_TYPE_SHORT'] = tRXTYPESHORT;
    data['TRX_TYPE_NAME'] = tRXTYPENAME;
    data['BUCHUNGS_ART_SHORT'] = bUCHUNGSARTSHORT;
    data['BUCHUNGS_ART_NAME'] = bUCHUNGSARTNAME;
    data['VAL_DATE'] = vALDATE;
    data['TRX_DATE'] = tRXDATE;
    data['DIRECTION'] = dIRECTION;
    data['AMOUNT'] = aMOUNT;
    data['TRX_CURRY_ID'] = tRXCURRYID;
    data['TRX_CURRY_NAME'] = tRXCURRYNAME;
    data['TEXT_SHORT_CREDITOR'] = tEXTSHORTCREDITOR;
    data['TEXT_CREDITOR'] = tEXTCREDITOR;
    data['TEXT_SHORT_DEBITOR'] = tEXTSHORTDEBITOR;
    data['TEXT_DEBITOR'] = tEXTDEBITOR;
    data['POINT_OF_SALE_AND_LOCATION'] = pOINTOFSALEANDLOCATION;
    data['ACQUIRER_COUNTRY_ID'] = aCQUIRERCOUNTRYID;
    data['ACQUIRER_COUNTRY_NAME'] = aCQUIRERCOUNTRYNAME;
    data['CARD_ID'] = cARDID;
    data['CRED_ACC_TEXT'] = cREDACCTEXT;
    data['CRED_IBAN'] = cREDIBAN;
    data['CRED_ADDR_TEXT'] = cREDADDRTEXT;
    data['CRED_REF_NR'] = cREDREFNR;
    data['CRED_INFO'] = cREDINFO;
    return data;
  }
}