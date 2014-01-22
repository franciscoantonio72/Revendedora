unit uclassContasReceber;

interface

Type
   TContasReceber = class
  private
    FVALORCREDITO: Real;
    FVALORDEBITO: Real;
    FDATAVENCIMENTO: TDate;
    FID: Integer;
    FCODIGOCLIENTE: Integer;
    FIDVENDA: Integer;
    FDATA: TDate;
    FPARCELA: Integer;
    FTIPO: string;
    FCODIGOTIPOPAGAMENTO: Integer;
    procedure SetCODIGOCLIENTE(const Value: Integer);
    procedure SetDATA(const Value: TDate);
    procedure SetDATAVENCIMENTO(const Value: TDate);
    procedure SetID(const Value: Integer);
    procedure SetIDVENDA(const Value: Integer);
    procedure SetPARCELA(const Value: Integer);
    procedure SetVALORCREDITO(const Value: Real);
    procedure SetVALORDEBITO(const Value: Real);
    procedure SetTIPO(const Value: string);
    procedure SetCODIGOTIPOPAGAMENTO(const Value: Integer);
  published
      property ID : Integer read FID write SetID;
      property IDVENDA : Integer read FIDVENDA write SetIDVENDA;
      property DATA : TDate read FDATA write SetDATA;
      property DATAVENCIMENTO : TDate read FDATAVENCIMENTO write SetDATAVENCIMENTO;
      property CODIGOCLIENTE : Integer read FCODIGOCLIENTE write SetCODIGOCLIENTE;
      property VALORCREDITO : Real read FVALORCREDITO write SetVALORCREDITO;
      property VALORDEBITO : Real read FVALORDEBITO write SetVALORDEBITO;
      property PARCELA : Integer read FPARCELA write SetPARCELA;
      property TIPO : string read FTIPO write SetTIPO;
      property CODIGOTIPOPAGAMENTO : Integer read FCODIGOTIPOPAGAMENTO write SetCODIGOTIPOPAGAMENTO;
   end;

implementation

{ TContasReceber }

procedure TContasReceber.SetCODIGOCLIENTE(const Value: Integer);
begin
  FCODIGOCLIENTE := Value;
end;

procedure TContasReceber.SetCODIGOTIPOPAGAMENTO(const Value: Integer);
begin
  FCODIGOTIPOPAGAMENTO := Value;
end;

procedure TContasReceber.SetDATA(const Value: TDate);
begin
  FDATA := Value;
end;

procedure TContasReceber.SetDATAVENCIMENTO(const Value: TDate);
begin
  FDATAVENCIMENTO := Value;
end;

procedure TContasReceber.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TContasReceber.SetIDVENDA(const Value: Integer);
begin
  FIDVENDA := Value;
end;

procedure TContasReceber.SetPARCELA(const Value: Integer);
begin
  FPARCELA := Value;
end;

procedure TContasReceber.SetTIPO(const Value: string);
begin
  FTIPO := Value;
end;

procedure TContasReceber.SetVALORCREDITO(const Value: Real);
begin
  FVALORCREDITO := Value;
end;

procedure TContasReceber.SetVALORDEBITO(const Value: Real);
begin
  FVALORDEBITO := Value;
end;

end.
