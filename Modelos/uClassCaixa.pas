unit uClassCaixa;

interface

type
   TCaixa = class
   private
     FVALOR: Real;
     FESTORNO: string;
     FDESCRICAO: string;
     FID: Integer;
     FCODIGOTIPOPAGAMENTO: Integer;
     FTIPO: string;
     FDATA: TDate;
     procedure SetCODIGOTIPOPAGAMENTO(const Value: Integer);
     procedure SetDATA(const Value: TDate);
     procedure SetDESCRICAO(const Value: string);
     procedure SetESTORNO(const Value: string);
     procedure SetID(const Value: Integer);
     procedure SetTIPO(const Value: string);
     procedure SetVALOR(const Value: Real);
   published
      property ID : Integer read FID write SetID;
      property DATA : TDate read FDATA write SetDATA;
      property DESCRICAO : string read FDESCRICAO write SetDESCRICAO;
      property CODIGOTIPOPAGAMENTO : Integer read FCODIGOTIPOPAGAMENTO write SetCODIGOTIPOPAGAMENTO;
      property ESTORNO : string read FESTORNO write SetESTORNO;
      property TIPO : string read FTIPO write SetTIPO;
      property VALOR : Real read FVALOR write SetVALOR;
   end;

implementation

{ TCaixa }

procedure TCaixa.SetCODIGOTIPOPAGAMENTO(const Value: Integer);
begin
  FCODIGOTIPOPAGAMENTO := Value;
end;

procedure TCaixa.SetDATA(const Value: TDate);
begin
  FDATA := Value;
end;

procedure TCaixa.SetDESCRICAO(const Value: string);
begin
  FDESCRICAO := Value;
end;

procedure TCaixa.SetESTORNO(const Value: string);
begin
  FESTORNO := Value;
end;

procedure TCaixa.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TCaixa.SetTIPO(const Value: string);
begin
  FTIPO := Value;
end;

procedure TCaixa.SetVALOR(const Value: Real);
begin
  FVALOR := Value;
end;

end.

