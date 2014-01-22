unit uDaoCliente;

interface

uses uClassCliente, SqlExpr, Forms, SysUtils, Dialogs, DBClient, Provider, DB, uDataModulo;

type
   TDAOCliente = class
   private
      FConexao : TSQLConnection;
      function PreencherObjeto(prcdsCliente: TClientDataSet): TCliente;
   public
      constructor Create;
      procedure Incluir( proCliente : TCliente );
      procedure Alterar( proCliente : TCliente );
      procedure Excluir( priCodigo : Integer );

      function BuscarTodos: TClientDataSet;
      function BuscarPorCodigo( prsCodigo : string) : TCliente;
   end;

implementation

{ TDAOCliente }

procedure TDAOCliente.Alterar(proCliente: TCliente);
var lqryModific : TSQLQuery;
begin
   lqryModific := TSQLQuery.Create( Application );
   try
      try
         lqryModific.SQLConnection := FConexao;
         lqryModific.SQL.Text := 'UPDATE Clientes SET BAIRRO = :parBAIRRO, '+
                                 '                    CELULAR = :parCELULAR, '+
                                 '                    CIDADE = :parCIDADE, '+
                                 '                    COMISSAO = :parCOMISSAO, '+
                                 '                    DATACADASTRO = :parDATACADASTRO, '+
                                 '                    ENDERECO = :parENDERECO, '+
                                 '                    NOME = :parNOME, '+
                                 '                    OPERADOR = :parOPERADOR, '+
                                 '                    TELEFONE = :parTELEFONE1, '+
                                 'WHERE Codigo=:parCodigo';
         lqryModific.ParamByName('parCodigo').AsInteger := proCliente.CODIGO;
         lqryModific.ParamByName('parCELULAR').AsString := proCliente.CELULAR;
         lqryModific.ParamByName('parCIDADE').AsString := proCliente.CIDADE;
         lqryModific.ParamByName('parCOMISSAO').AsFloat := proCliente.COMISSAO;
         lqryModific.ParamByName('parDATACADASTRO').AsDate := proCliente.DATACADASTRO;
         lqryModific.ParamByName('parENDERECO').AsString := proCliente.ENDERECO;
         lqryModific.ParamByName('parNOME').AsString := proCliente.NOME;
         lqryModific.ParamByName('parOPERADOR').AsString := proCliente.OPERADOR;
         lqryModific.ParamByName('parTELEFONE1').AsString := proCliente.TELEFONE1;
         lqryModific.ExecSQL;
      except
         On E: Exception do
         begin
            MessageDlg('Não foi possivel gravar na tabela Clientes ' + E.Message, mtError, [mbOK], 0);
            Exit;
         end;
      end;
   finally
      FreeAndNil( lqryModific );
   end;
end;

function TDAOCliente.BuscarPorCodigo(prsCodigo: string): TCliente;
var lcdsTemp : TClientDataSet;
    lqryTemp : TSQLQuery;
    ldtsTemp : TDataSetProvider;
    loCliente : TCliente;
begin
   lqryTemp := TSQLQuery.Create(Application);
   try
      lqryTemp.SQLConnection := FConexao;
      lqryTemp.SQL.Text := 'SELECT * FROM Clientes '+
                           'WHERE Codigo=:parCodigo';
      lqryTemp.ParamByName('parCodigo').AsString := prsCodigo;

      ldtsTemp := TDataSetProvider.Create(Application);
      ldtsTemp.Name := 'ldtsTempCliente';
      ldtsTemp.DataSet := lqryTemp;

      lcdsTemp := TClientDataSet.Create(Application);
      lcdsTemp.ProviderName := ldtsTemp.Name;
      lcdsTemp.Open;

      loCliente := PreencherObjeto( lcdsTemp );

      Result := loCliente;
   finally
      FreeAndNil( lqryTemp );
      FreeAndNil( ldtsTemp );
   end;
end;

function TDAOCliente.BuscarTodos: TClientDataSet;
var lcdsTemp : TClientDataSet;
    lqryTemp : TSQLQuery;
    ldtsTemp : TDataSetProvider;
begin
   lqryTemp := TSQLQuery.Create(Application);
   try
      lqryTemp.SQLConnection := FConexao;
      lqryTemp.SQL.Text := 'SELECT * FROM Clientes';

      ldtsTemp := TDataSetProvider.Create(Application);
      ldtsTemp.Name := 'ldtsTempCliente';
      ldtsTemp.DataSet := lqryTemp;

      lcdsTemp := TClientDataSet.Create(Application);
      lcdsTemp.ProviderName := ldtsTemp.Name;
      lcdsTemp.Open;

      Result := lcdsTemp;
   finally
      FreeAndNil( lqryTemp );
      FreeAndNil( ldtsTemp );
   end;
end;

constructor TDAOCliente.Create;
begin
   FConexao := dtmPrincipal.dbxPrincipal;
end;

procedure TDAOCliente.Excluir(priCodigo: Integer);
var lqryModific : TSQLQuery;
begin
   lqryModific := TSQLQuery.Create( Application );
   try
      try
         lqryModific.SQLConnection := FConexao;
         lqryModific.SQL.Text := 'DELETE FROM Clientes '+
                                 'WHERE Codigo=:parCodigo';
         lqryModific.ParamByName('parCodigo').AsInteger := priCodigo;
         lqryModific.ExecSQL;
      Except
         On E: Exception do
         begin
            MessageDlg('Não foi possivel excluir na tabela Clientes ' + E.Message, mtError, [mbOK], 0);
            Exit;
         end;
      end;
   finally
      FreeAndNil( lqryModific );
   end;
end;

procedure TDAOCliente.Incluir(proCliente: TCliente);
var lqryModific : TSQLQuery;
begin
   lqryModific := TSQLQuery.Create( Application );
   try
      try
         lqryModific.SQLConnection := FConexao;
         lqryModific.SQL.Text := 'INSERT INTO Clientes ( CELULAR, CIDADE, COMISSAO, DATACADASTRO, '+
                                 'ENDERECO, NOME, OPERADOR, TELEFONE, BAIRRO ) '+
                                 'VALUES '+
                                 '(:parCELULAR, :parCIDADE, :parCOMISSAO, :parDATACADASTRO, :parENDERECO, :parNOME, :parOPERADOR, '+
                                 ' :parTELEFONE1, :parBAIRRO)';
         lqryModific.ParamByName('parBAIRRO').AsString := proCliente.BAIRRO;
         lqryModific.ParamByName('parCELULAR').AsString := proCliente.CELULAR;
         lqryModific.ParamByName('parCIDADE').AsString := proCliente.CIDADE;
         lqryModific.ParamByName('parCOMISSAO').AsFloat := proCliente.COMISSAO;
         lqryModific.ParamByName('parDATACADASTRO').AsDate := proCliente.DATACADASTRO;
         lqryModific.ParamByName('parENDERECO').AsString := proCliente.ENDERECO;
         lqryModific.ParamByName('parNOME').AsString := proCliente.NOME;
         lqryModific.ParamByName('parOPERADOR').AsString := proCliente.OPERADOR;
         lqryModific.ParamByName('parTELEFONE1').AsString := proCliente.TELEFONE1;
         lqryModific.ExecSQL;
      except
         On E: Exception do
         begin
            MessageDlg('Não foi possivel gravar na tabela Clientes ' + E.Message, mtError, [mbOK], 0);
            Exit;
         end;
      end;
   finally
      FreeAndNil( lqryModific );
   end;
end;

function TDAOCliente.PreencherObjeto(prcdsCliente: TClientDataSet): TCliente;
var loCliente : TCliente;
begin
   loCliente := TCliente.Create;
   With loCliente do
   begin
      CODIGO := prcdsCliente.FieldByName('CODIGO').AsInteger;
      BAIRRO := prcdsCliente.FieldByName('BAIRRO').AsString;
      CELULAR    := prcdsCliente.FieldByName('CELULAR').AsString;
      CIDADE    := prcdsCliente.FieldByName('CIDADE').AsString;
      COMISSAO    := prcdsCliente.FieldByName('COMISSAO').AsFloat ;
      DATACADASTRO    := prcdsCliente.FieldByName('DATACADASTRO').AsDateTime;
      ENDERECO    := prcdsCliente.FieldByName('ENDERECO').AsString ;
      NOME    := prcdsCliente.FieldByName('NOME').AsString ;
      OPERADOR    := prcdsCliente.FieldByName('OPERADOR').AsString ;
      TELEFONE1    := prcdsCliente.FieldByName('TELEFONE1').AsString ;
   end;

   Result := loCliente;
end;

end.
