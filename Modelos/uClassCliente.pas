unit uClassCliente;

interface

type
   TCliente = class
  private
    FBAIRRO: string;
    FUF: string;
    FCODIGO: Integer;
    FCOMISSAO: Real;
    FOPERADOR: string;
    FDATACADASTRO: TDate;
    FTELEFONE1: string;
    FCIDADE: string;
    FENDERECO: string;
    FCELULAR: string;
    FNOME: string;
    procedure SetBAIRRO(const Value: string);
    procedure SetCELULAR(const Value: string);
    procedure SetCIDADE(const Value: string);
    procedure SetCODIGO(const Value: Integer);
    procedure SetCOMISSAO(const Value: Real);
    procedure SetDATACADASTRO(const Value: TDate);
    procedure SetENDERECO(const Value: string);
    procedure SetOPERADOR(const Value: string);
    procedure SetTELEFONE1(const Value: string);
    procedure SetUF(const Value: string);
    procedure SetNOME(const Value: string);
   published
      property BAIRRO : string read FBAIRRO write SetBAIRRO;
      property CELULAR : string read FCELULAR write SetCELULAR;
      property CIDADE : string read FCIDADE write SetCIDADE;
      property CODIGO : Integer read FCODIGO write SetCODIGO;
      property COMISSAO : Real read FCOMISSAO write SetCOMISSAO;
      property DATACADASTRO : TDate read FDATACADASTRO write SetDATACADASTRO;
      property ENDERECO : string read FENDERECO write SetENDERECO;
      property OPERADOR : string read FOPERADOR write SetOPERADOR;
      property TELEFONE1 : string read FTELEFONE1 write SetTELEFONE1;
      property UF : string read FUF write SetUF;
      property NOME : string read FNOME write SetNOME;
   end;

implementation

{ TCliente }

procedure TCliente.SetBAIRRO(const Value: string);
begin
  FBAIRRO := Value;
end;

procedure TCliente.SetCELULAR(const Value: string);
begin
  FCELULAR := Value;
end;

procedure TCliente.SetCIDADE(const Value: string);
begin
  FCIDADE := Value;
end;

procedure TCliente.SetCODIGO(const Value: Integer);
begin
  FCODIGO := Value;
end;

procedure TCliente.SetCOMISSAO(const Value: Real);
begin
  FCOMISSAO := Value;
end;

procedure TCliente.SetDATACADASTRO(const Value: TDate);
begin
  FDATACADASTRO := Value;
end;

procedure TCliente.SetENDERECO(const Value: string);
begin
  FENDERECO := Value;
end;

procedure TCliente.SetNOME(const Value: string);
begin
  FNOME := Value;
end;

procedure TCliente.SetOPERADOR(const Value: string);
begin
  FOPERADOR := Value;
end;

procedure TCliente.SetTELEFONE1(const Value: string);
begin
  FTELEFONE1 := Value;
end;

procedure TCliente.SetUF(const Value: string);
begin
  FUF := Value;
end;

end.
