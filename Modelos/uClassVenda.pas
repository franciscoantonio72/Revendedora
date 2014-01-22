unit uClassVenda;

interface

uses uClassItemVenda, Classes, Generics.Collections;

type
  TVenda = class
  private
    FNOMECLIENTE: string;
    FVALORVENDA: Real;
    FTIPOPAGAMENTO: INTEGER;
    FID: Integer;
    FCODIGOCLIENTE: INTEGER;
    FPARCELAS: INTEGER;
    FDATACADASTRO: TDate;
    FCODIGOVENDEDOR: INTEGER;
    FITENSVENDAS: TList<TITEMVENDA>;
    procedure SetCODIGOCLIENTE(const Value: INTEGER);
    procedure SetCODIGOVENDEDOR(const Value: INTEGER);
    procedure SetDATACADASTRO(const Value: TDate);
    procedure SetID(const Value: Integer);
    procedure SetNOMECLIENTE(const Value: string);
    procedure SetPARCELAS(const Value: INTEGER);
    procedure SetTIPOPAGAMENTO(const Value: INTEGER);
    procedure SetVALORVENDA(const Value: Real);
    procedure SetITENSVENDAS(const Value: TList<TITEMVENDA>);
  published
    property ID : Integer read FID write SetID;
    property DATACADASTRO : TDate read FDATACADASTRO write SetDATACADASTRO;
    property CODIGOVENDEDOR : INTEGER read FCODIGOVENDEDOR write SetCODIGOVENDEDOR;
    property CODIGOCLIENTE :  INTEGER read FCODIGOCLIENTE write SetCODIGOCLIENTE;
    property NOMECLIENTE   :  String read FNOMECLIENTE write SetNOMECLIENTE;
    property VALORVENDA    :  Real read FVALORVENDA write SetVALORVENDA;
    property TIPOPAGAMENTO :  INTEGER read FTIPOPAGAMENTO write SetTIPOPAGAMENTO;
    property PARCELAS      :  INTEGER read FPARCELAS write SetPARCELAS;
    property ITENSVENDAS : TList<TITEMVENDA> read FITENSVENDAS write SetITENSVENDAS;
  public
     constructor Create;
  end;


implementation

{ TVenda }

constructor TVenda.Create;
begin
//   FITENSVENDAS := TList.Create;
end;

procedure TVenda.SetCODIGOCLIENTE(const Value: INTEGER);
begin
  FCODIGOCLIENTE := Value;
end;

procedure TVenda.SetCODIGOVENDEDOR(const Value: INTEGER);
begin
  FCODIGOVENDEDOR := Value;
end;

procedure TVenda.SetDATACADASTRO(const Value: TDate);
begin
  FDATACADASTRO := Value;
end;

procedure TVenda.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TVenda.SetITENSVENDAS(const Value: TList<TITEMVENDA>);
begin
  FITENSVENDAS := Value;
end;

procedure TVenda.SetNOMECLIENTE(const Value: string);
begin
  FNOMECLIENTE := Value;
end;

procedure TVenda.SetPARCELAS(const Value: INTEGER);
begin
  FPARCELAS := Value;
end;

procedure TVenda.SetTIPOPAGAMENTO(const Value: INTEGER);
begin
  FTIPOPAGAMENTO := Value;
end;

procedure TVenda.SetVALORVENDA(const Value: Real);
begin
  FVALORVENDA := Value;
end;

end.
