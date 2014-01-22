unit uDaoVendas;

interface

uses uClassVenda, SqlExpr, Forms, SysUtils, Dialogs, DBClient, Provider, DB, uDataModulo, uClassFuncoes, uClassItemVenda;

type
   TDaoVendas = class
   private
      FConexao : TSQLConnection;
      function PreencherObjeto(prcdsVenda: TClientDataSet): TVenda;
   public
      constructor Create;
      procedure Incluir( proVenda : TVenda );
      procedure Alterar( proVenda : TVenda );
      procedure Excluir( priCodigo : Integer );

      function BuscarTodos: TClientDataSet;
      function BuscarPorCodigo( prsCodigo : string) : TVenda;

      function BuscarItensVendasPorId( priIdVenda : Integer ) : TClientDataSet;
   end;

implementation

{ TDaoVendas }

procedure TDaoVendas.Alterar(proVenda: TVenda);
begin

end;

function TDaoVendas.BuscarItensVendasPorId( priIdVenda : Integer ) : TClientDataSet;
var lqryVariavel : TSQLQuery;
    ldtpVariavel : TDataSetProvider;
    lcdsVariavel : TClientDataSet;
begin
   lqryVariavel := TSQLQuery.Create( Application );
   ldtpVariavel := TDataSetProvider.Create( Application );
   lcdsVariavel := TClientDataSet.Create( Application );
   try
      lqryVariavel.Close;
      lqryVariavel.SQLConnection := FConexao;
      lqryVariavel.SQL.Text := 'SELECT * FROM ITENSVENDAS '+
                               'WHERE IDVENDA=:parIdVenda';
      lqryVariavel.ParamByName('parIdVenda').AsInteger := priIdVenda;

      ldtpVariavel.Name := 'ldtpVariavel';
      ldtpVariavel.DataSet := lqryVariavel;

      lcdsVariavel.Close;
      lcdsVariavel.ProviderName := ldtpVariavel.Name;
      lcdsVariavel.Open;

      Result := lcdsVariavel;
   finally
      FreeAndNil( lqryVariavel );
      FreeAndNil( ldtpVariavel );
   end;
end;

function TDaoVendas.BuscarPorCodigo(prsCodigo: string): TVenda;
begin

end;

function TDaoVendas.BuscarTodos: TClientDataSet;
var lqryVariavel : TSQLQuery;
    ldtpVariavel : TDataSetProvider;
    lcdsVariavel : TClientDataSet;
begin
   lqryVariavel := TSQLQuery.Create( Application );
   ldtpVariavel := TDataSetProvider.Create( Application );
   lcdsVariavel := TClientDataSet.Create( Application );
   try
      lqryVariavel.Close;
      lqryVariavel.SQLConnection := FConexao;
      lqryVariavel.SQL.Text := 'SELECT * FROM VENDAS';

      ldtpVariavel.Name := 'ldtpVariavel';
      ldtpVariavel.DataSet := lqryVariavel;

      lcdsVariavel.Close;
      lcdsVariavel.ProviderName := ldtpVariavel.Name;
      lcdsVariavel.Open;

      Result := lcdsVariavel;
   finally
      FreeAndNil( lqryVariavel );
      FreeAndNil( ldtpVariavel );
   end;
end;

constructor TDaoVendas.Create;
begin
   FConexao := dtmPrincipal.dbxPrincipal;
end;

procedure TDaoVendas.Excluir(priCodigo: Integer);
begin

end;

procedure TDaoVendas.Incluir(proVenda: TVenda);
var lqryModific : TSQLQuery;
    lsIDVenda : String;
    liContador : Integer;
    loItemVendas : TItemVenda;
begin
   lqryModific := TSQLQuery.Create( Application );
   try
      try
         lqryModific.SQLConnection := FConexao;
         lqryModific.SQL.Text := 'INSERT INTO Vendas ( DATACADASTRO, CODIGOVENDEDOR, CODIGOCLIENTE, NOMECLIENTE, VALORVENDA, TIPOPAGAMENTO, PARCELAS ) '+
                                 'VALUES '+
                                 '(:parDATACADASTRO, :parCODIGOVENDEDOR, :parCODIGOCLIENTE, :parNOMECLIENTE, :parVALORVENDA, :parTIPOPAGAMENTO, :parPARCELAS)';
         lqryModific.ParamByName('parDATACADASTRO').AsDate := proVenda.DATACADASTRO;
         lqryModific.ParamByName('parCODIGOVENDEDOR').AsInteger := proVenda.CODIGOVENDEDOR;
         lqryModific.ParamByName('parCODIGOCLIENTE').AsInteger := proVenda.CODIGOCLIENTE;
         lqryModific.ParamByName('parNOMECLIENTE').AsString := proVenda.NOMECLIENTE;
         lqryModific.ParamByName('parVALORVENDA').AsFloat := proVenda.VALORVENDA;
         lqryModific.ParamByName('parTIPOPAGAMENTO').AsInteger := proVenda.TIPOPAGAMENTO;
         lqryModific.ParamByName('parPARCELAS').AsInteger := proVenda.PARCELAS;
         lqryModific.ExecSQL;

         lsIdVenda := LerGenerator( 'GEN_VENDAS_ID', 1, 8, False );

         for loItemVendas in proVenda.ITENSVENDAS do
         begin
           lqryModific.SQLConnection := FConexao;
           lqryModific.SQL.Text := 'INSERT INTO ItensVendas ( IDVENDA, DATACADASTRO, CODIGOPRODUTO, DESCRICAOPRODUTO, QUANTIDADE, '+
                                   ' VALORUNITARIO, VALORTOTAL ) '+
                                   'VALUES '+
                                   '(:parIDVENDA, :parDATACADASTRO, :parCODIGOPRODUTO, :parDESCRICAOPRODUTO, :parQUANTIDADE, '+
                                   ' :parVALORUNITARIO, :parVALORTOTAL )';
           lqryModific.ParamByName('parIDVENDA').AsInteger := StrToInt( lsIdVenda ) -1;
           lqryModific.ParamByName('parDATACADASTRO').AsDate := loItemVendas.DATACADASTRO;
           lqryModific.ParamByName('parCODIGOPRODUTO').AsInteger := loItemVendas.CODIGOPRODUTO;
           lqryModific.ParamByName('parDESCRICAOPRODUTO').AsString := loItemVendas.DESCRICAOPRODUTO;
           lqryModific.ParamByName('parQUANTIDADE').AsInteger := loItemVendas.QUANTIDADE;
           lqryModific.ParamByName('parVALORUNITARIO').AsFloat := loItemVendas.VALORUNITARIO;
           lqryModific.ParamByName('parVALORTOTAL').AsFloat := loItemVendas.VALORTOTAL;
           lqryModific.ExecSQL;
         end;
      except
         On E: Exception do
         begin
            MessageDlg('Não foi possivel gravar na tabela Vendas ' + E.Message, mtError, [mbOK], 0);
            Exit;
         end;
      end;
   finally
      FreeAndNil( lqryModific );
   end;
end;

function TDaoVendas.PreencherObjeto(prcdsVenda: TClientDataSet): TVenda;
begin

end;

end.
