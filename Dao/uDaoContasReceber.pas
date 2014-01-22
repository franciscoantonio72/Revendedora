unit uDaoContasReceber;

interface

uses uClassContasReceber, SqlExpr, Forms, SysUtils, Dialogs, DBClient, Provider, DB, uDataModulo, Generics.Collections;

type
   TDaoContasReceber = class
   private
      FConexao : TSQLConnection;

   public
      constructor Create;
      procedure Incluir( proContasReceber : TList<TContasReceber> );
   end;

implementation

{ TDaoContasReceber }

constructor TDaoContasReceber.Create;
begin
   FConexao := dtmPrincipal.dbxPrincipal;
end;

procedure TDaoContasReceber.Incluir(proContasReceber: TList<TContasReceber>);
var lqryModific : TSQLQuery;
    loContasReceber : TContasReceber;
begin
   lqryModific := TSQLQuery.Create( Application );
   try
      for loContasReceber in proContasReceber do
      begin
        try
           lqryModific.SQLConnection := FConexao;
           lqryModific.SQL.Text := 'INSERT INTO ContasReceber ( IDVENDA, DATA, DATAVENCIMENTO, CODIGOCLIENTE, VALORCREDITO, '+
                                   'VALORDEBITO, PARCELA, TIPO, CODIGOPAGAMENTO ) '+
                                   'VALUES '+
                                   '(:parIDVENDA, :parDATA, :parDATAVENCIMENTO, :parCODIGOCLIENTE, :parVALORCREDITO, '+
                                   ':parVALORDEBITO, :parPARCELA, :parTIPO, :parCODIGOPAGAMENTO )';
           lqryModific.ParamByName('parIDVENDA').AsInteger := loContasReceber.IDVENDA;
           lqryModific.ParamByName('parDATA').AsDate := loContasReceber.DATA;
           lqryModific.ParamByName('parDATAVENCIMENTO').AsDate := loContasReceber.DATAVENCIMENTO;
           lqryModific.ParamByName('parCODIGOCLIENTE').AsInteger := loContasReceber.CODIGOCLIENTE;
           lqryModific.ParamByName('parVALORCREDITO').AsFloat := loContasReceber.VALORCREDITO;
           lqryModific.ParamByName('parVALORDEBITO').AsFloat := loContasReceber.VALORDEBITO;
           lqryModific.ParamByName('parPARCELA').AsInteger := loContasReceber.PARCELA;
           lqryModific.ParamByName('parTIPO').AsString := loContasReceber.TIPO;
           lqryModific.ParamByName('parCODIGOPAGAMENTO').AsInteger := loContasReceber.CODIGOTIPOPAGAMENTO;
           lqryModific.ExecSQL;
        except
           On E: Exception do
           begin
              MessageDlg('Não foi possivel gravar na tabela Contas Receber ' + E.Message, mtError, [mbOK], 0);
              Exit;
           end;
        end;
      end;
   finally
      FreeAndNil( lqryModific );
   end;
end;

end.
