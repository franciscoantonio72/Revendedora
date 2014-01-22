unit uControllerCliente;

interface

uses uClassCliente, DBClient, uDaoCliente, SysUtils;

type
   TControllerCliente = class
   public
      procedure Incluir( proCliente : TCliente );
      procedure Alterar( proCliente : TCliente );
      procedure Excluir( priCodigo : Integer );

      function BuscarTodos: TClientDataset;
      function BuscarPorCodigo( prsCodigo : string ): TCliente;
   end;

implementation

{ TControllerCliente }

procedure TControllerCliente.Alterar(proCliente: TCliente);
var loDaoCliente : TDAOCliente;
begin
   loDaoCliente := TDAOCliente.Create;
   try
      loDaoCliente.Alterar( proCliente );
   finally
      FreeAndNil( loDaoCliente );
   end;
end;

function TControllerCliente.BuscarPorCodigo(prsCodigo: string): TCliente;
var loDaoCliente : TDaoCliente;
    loCliente : TCliente;
begin
   loDaoCliente := TDaoCliente.Create;
   try
      loCliente := loDaoCliente.BuscarPorCodigo( prsCodigo );

      Result := loCliente;
   finally
      FreeAndNil( loDaoCliente );
   end;
end;

function TControllerCliente.BuscarTodos: TClientDataset;
var loDaoCliente : TDaoCliente;
begin
   loDaoCliente := TDaoCliente.Create;
   Result := loDaoCliente.BuscarTodos;
end;

procedure TControllerCliente.Excluir(priCodigo: Integer);
var loDaoCliente : TDaoCliente;
begin
   loDaoCliente := TDaoCliente.Create;
   try
      loDaoCliente.Excluir( priCodigo );
   finally
      FreeAndNil( loDaoCliente );
   end;
end;

procedure TControllerCliente.Incluir(proCliente: TCliente);
var loDaoCliente : TDaoCliente;
begin
   loDaoCliente := TDAOCliente.Create;
   try
      loDaoCliente.Incluir( proCliente );
   finally
      FreeAndNil( loDaoCliente );
   end;
end;

end.
