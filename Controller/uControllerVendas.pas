unit uControllerVendas;

interface

uses uClassVenda, DBClient, uDaoVendas, SysUtils;

type
   TControllerVendas = class
   public
      procedure Incluir( proVenda : TVenda );
      procedure Alterar( proVenda : TVenda );
      procedure Excluir( priCodigo : Integer );

      function BuscarTodos: TClientDataset;
      function BuscarPorCodigo( prsCodigo : string ): TVenda;

      function BuscarItensVendasPorId( priIdVenda : Integer ) : TClientDataSet;
   end;

implementation

{ TControllerVendas }

procedure TControllerVendas.Alterar(proVenda: TVenda);
var loDaoVenda : TDaoVendas;
begin
   loDaoVenda := TDaoVendas.Create;
   try
      loDaoVenda.Alterar( proVenda );
   finally
      FreeAndNil( loDaoVenda );
   end;
end;

function TControllerVendas.BuscarItensVendasPorId( priIdVenda : Integer ): TClientDataSet;
var loDaoVenda : TDaoVendas;
begin
   loDaoVenda := TDaoVendas.Create;
   Result := loDaoVenda.BuscarItensVendasPorId( priIdVenda );
end;

function TControllerVendas.BuscarPorCodigo(prsCodigo: string): TVenda;
var loDaoVenda : TDaoVendas;
    loVenda : TVenda;
begin
   loDaoVenda := TDaoVendas.Create;
   try
      loVenda := loDaoVenda.BuscarPorCodigo( prsCodigo );

      Result := loVenda;
   finally
      FreeAndNil( loDaoVenda );
   end;
end;

function TControllerVendas.BuscarTodos: TClientDataset;
var loDaoVenda : TDaoVendas;
begin
   loDaoVenda := TDaoVendas.Create;
   Result := loDaoVenda.BuscarTodos;
end;

procedure TControllerVendas.Excluir(priCodigo: Integer);
var loDaoVenda : TDaoVendas;
begin
   loDaoVenda := TDaoVendas.Create;
   try
      loDaoVenda.Excluir( priCodigo );
   finally
      FreeAndNil( loDaoVenda );
   end;
end;

procedure TControllerVendas.Incluir(proVenda: TVenda);
var loDaoVenda : TDaoVendas;
begin
   loDaoVenda := TDaoVendas.Create;
   try
      loDaoVenda.Incluir( proVenda );
   finally
      FreeAndNil( loDaoVenda );
   end;
end;

end.
