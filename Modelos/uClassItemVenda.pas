unit uClassItemVenda;

interface

type
   TItemVenda = class
  private
    FDESCRICAOPRODUTO: string;
    FCODIGOPRODUTO: Integer;
    FVALORUNITARIO: Real;
    FID: Integer;
    FVALORTOTAL: Real;
    FIDVENDA: Integer;
    FQUANTIDADE: Integer;
    FDATACADASTRO: TDate;
    procedure SetCODIGOPRODUTO(const Value: Integer);
    procedure SetDATACADASTRO(const Value: TDate);
    procedure SetDESCRICAOPRODUTO(const Value: string);
    procedure SetID(const Value: Integer);
    procedure SetIDVENDA(const Value: Integer);
    procedure SetQUANTIDADE(const Value: Integer);
    procedure SetVALORTOTAL(const Value: Real);
    procedure SetVALORUNITARIO(const Value: Real);
  published
    property ID                : Integer read FID write SetID;
    property IDVENDA           : Integer read FIDVENDA write SetIDVENDA;
    property DATACADASTRO      : TDate read FDATACADASTRO write SetDATACADASTRO;
    property CODIGOPRODUTO     : Integer read FCODIGOPRODUTO write SetCODIGOPRODUTO;
    property DESCRICAOPRODUTO  : string read FDESCRICAOPRODUTO write SetDESCRICAOPRODUTO;
    property QUANTIDADE        : Integer read FQUANTIDADE write SetQUANTIDADE;
    property VALORUNITARIO     : Real read FVALORUNITARIO write SetVALORUNITARIO;
    property VALORTOTAL        : Real read FVALORTOTAL write SetVALORTOTAL;
   end;

implementation

{ TItemVenda }

procedure TItemVenda.SetCODIGOPRODUTO(const Value: Integer);
begin
  FCODIGOPRODUTO := Value;
end;

procedure TItemVenda.SetDATACADASTRO(const Value: TDate);
begin
  FDATACADASTRO := Value;
end;

procedure TItemVenda.SetDESCRICAOPRODUTO(const Value: string);
begin
  FDESCRICAOPRODUTO := Value;
end;

procedure TItemVenda.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TItemVenda.SetIDVENDA(const Value: Integer);
begin
  FIDVENDA := Value;
end;

procedure TItemVenda.SetQUANTIDADE(const Value: Integer);
begin
  FQUANTIDADE := Value;
end;

procedure TItemVenda.SetVALORTOTAL(const Value: Real);
begin
  FVALORTOTAL := Value;
end;

procedure TItemVenda.SetVALORUNITARIO(const Value: Real);
begin
  FVALORUNITARIO := Value;
end;

end.
