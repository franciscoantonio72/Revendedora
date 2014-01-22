unit uClassFuncoes;

interface

uses DB, DBClient, SysUtils, SqlExpr, Forms, Provider, Dialogs, Classes,
  Windows, ComCtrls, bsSkinCtrls, uVariaveisGlobais, madExcept, SqlTimSt, MAPI,
  IdMessage, IdSMTP, IdBaseComponent, IdComponent, IdIOHandler, IdIOHandlerSocket, IdSSLOpenSSL, WinInet,
  IdPOP3, IdUserPassProvider, IdSASLLogin, IdAttachmentFile, uMensagens, StdCtrls,
  RDprint, frxClass, StrUtils, uDataModulo;

Type
  TCxDlgTipo    = ( ctAviso, ctErro, ctInforma, ctConfirma, ctTimer, ctDespertador, ctPessoal );
  TCxDlgBtn     = ( cbSim, cbNao, cbOK, cbCancela, cbSimNao, cbOkCancela );
  TCxDlgBotoes  = Set Of TCxDlgBtn;
  TTipoRegistro = ( trBinaryData, trBool, trCurrency, trDate, trDateTime, trFloat, trInteger, trString, trTime );
  TTipoSQL      = ( tsSelect, tsInsert, tsUpdate );

  const // Valores constantes para o Extenso
     Centenas: array[1..9] of string[12]=('CEM','DUZENTOS','TREZENTOS','QUATROCENTOS', 'QUINHENTOS','SEISCENTOS','SETECENTOS', 'OITOCENTOS','NOVECENTOS');
     Dezenas : array[2..9] of string[10]=('VINTE','TRINTA','QUARENTA','CINQUENTA', 'SESSENTA','SETENTA','OITENTA','NOVENTA');
     Dez     : array[0..9] of string[10]=('DEZ','ONZE','DOZE','TREZE','QUATORZE', 'QUINZE','DEZESSEIS','DEZESSETE', 'DEZOITO','DEZENOVE');
     Unidades: array[1..9] of string[10]=('UM','DOIS','TRES','QUATRO','CINCO', 'SEIS','SETE','OITO','NOVE'); MoedaSingular = 'REAL';
     MoedaPlural  = 'REAIS';
     CentSingular = 'CENTAVO';
     CentPlural   = 'CENTAVOS';
     Zero         = 'ZERO';

Type
   TEmail = Class
      Private
         FDe : String;
         FPara    : String;
         FAssunto : String;
         FTexto   : String;
         FAnexos  : String;
         FServidorPOP3 : String;
         FUsuarioPOP3 : String;
         FSenhaPOP3 : String;
         FServidorSMTP : String;
         FTipodeAutenticacao : TIdSMTPAuthenticationType;
         FUsuarioSMTP : String;
         FSenhaSMTP : String;
         FConfirmaLeitura : Boolean;
         FPortaSMTP: Integer;
         Frequerloginsmtp: Boolean;
         procedure SetDe(const Value: String);
         procedure SetPara(const Value: String);
         procedure SetAssunto(const Value: String);
         procedure SetTexto(const Value: String);
         procedure SetAnexos(const Value: String);
         procedure SetServidorPOP3(const Value: String);
         procedure SetUsuarioPOP3(const Value: String);
         procedure SetSenhaPOP3(const Value: String);
         procedure SetServidorSMTP(const Value: String);
         procedure SetTipodeAutenticacao(const Value: TIdSMTPAuthenticationType);
         procedure SetUsuarioSMTP(const Value: String);
         procedure SetSenhaSMTP(const Value: String);
         procedure SetConfirmaLeitura(const Value: Boolean);
         procedure SetPortaSMTP(const Value: Integer);
         procedure Setrequerloginsmtp(const Value: Boolean);
      Public
         property De : String read FDe write SetDe;
         property Para    : String read FPara write SetPara;
         property Assunto : String read FAssunto write SetAssunto;
         property Texto   : String read FTexto write SetTexto;
         property Anexos  : String read FAnexos write SetAnexos;
         property ServidorPOP3 : String read FServidorPOP3 write SetServidorPOP3;
         property UsuarioPOP3 : String read FUsuarioPOP3 write SetUsuarioPOP3;
         property SenhaPOP3 : String read FSenhaPOP3 write SetSenhaPOP3;
         property ServidorSMTP : String read FServidorSMTP write SetServidorSMTP;
         property PortaSMTP : Integer read FPortaSMTP write SetPortaSMTP;
         property TipodeAutenticacao : TIdSMTPAuthenticationType read FTipodeAutenticacao write SetTipodeAutenticacao;
         property UsuarioSMTP : String read FUsuarioSMTP write SetUsuarioSMTP;
         property SenhaSMTP : String read FSenhaSMTP write SetSenhaSMTP;
         property ConfirmaLeitura : Boolean read FConfirmaLeitura write SetConfirmaLeitura;
         property requerloginsmtp : Boolean read Frequerloginsmtp write Setrequerloginsmtp;
      Constructor Create;
      Function EnviarEmail: integer;
      Function Indy_EnviarEmail : Boolean;
end;


Function CriarCampo( fFieldKind : TFieldKind; fDataSet : TDataSet; fFieldName: String; fDataType : TFieldType; fSize : Integer; fDisplayLabel: string = ''; fVisible: boolean = true ) : Tfield ;
Function IncZero( fsVlrString:  String; Tamanho: Word; fbApagarBranco : Boolean = False ): String;
Function Sequencia( fSQLConnection : TSQLConnection; fCampo: String; fIncrementa: Boolean = True; fTabela : String = ''; fCodEmp : String = ''; fVerTab : String = ''; fverCampo : String = '' ): Integer;
Function SubstString( lstrOriginal, fStrDel : String; fStrIns : String = '';DigitoADigito: Boolean = True ): String;
Function BuscaTabelas( fSQLConnection: TSQLConnection ): TStringList;
Function CarregarResourceTXT( fsNameResource : String ) : TStringList;
Function VerificaEstrutura( flstEstruturaLOCAL, flstEstruturaTEC_AI, flstEstruturaTEC_LZ, flstTabelas: TStrings; fProgresso: TProgressBar = Nil; fStatusBar: TStatusBar=Nil; fGauge: TbsSkinGauge = Nil ) : Boolean;
Function ConverteSQL( fStr : String;  fTipoBD : String ) : String;
Function ConstruirSQL( fTipoSQL : TTipoSQL; fsTabela, fsCampos : String; fsRestricao  : String = ''; fsCodEmp  : String = '' ) : String;
function ProcedureExiste( prsNomeProcedure : String ) : Boolean;
function ExcluirDependencias( const proSQLConnection : TSQLConnection; const prsObjeto : String; fProgresso: TProgressBar = Nil; fObject : TObject = Nil ) : Boolean;
Function BuscaCampos( fsTabela: String; fSQLConnection: TSQLConnection ): TStringList;
Function ProcuraTipo( fTipoCampo: TFieldType; fDriverDestino : String = '' ): String;
function ObjetoFirebirdExiste( prsTipoObjeto : String; prsNomeObjeto : String ) : Boolean;
procedure LogBook( fOperador: String; fData: TDateTime; fHora, fOperacao: String);
Function HoraServidor : String;
Function SoData( fData: TDateTime; fDataStr: String = '' ): TDate;
Function EnviarEmail(const De, Para, Assunto, Texto, Arquivo: string; Confirma: Boolean): integer;
function ExcluirTriggersDependentes( const proSQLConnection : TSQLConnection; const prsObjeto : String; fProgresso: TProgressBar = Nil; fObject : TObject = Nil ) : Boolean;
Function CaixaMensagem( vMensagem: AnsiString; vFigura: TCxDlgTipo; vBotoes: TCxDlgBotoes; vFoco: Integer): Boolean;
Function Centraliza( fTamFundo, fTamObjeto : Integer ) : Integer;
Procedure ListaPeriodo( fComponente1: TComponent; fComponente2: TComponent; fItem: Integer; fData : TDateTime );
Procedure ConfiguraRel( fNomeForm : String; fRelatorio : TObject; fCriarCabecalho : Boolean = True; fRDPrint : TRdPrint = Nil; fPagina : Integer = 1; fTipoCab: integer = 1 );
Function IncDigito(VlrString:  String; Digito: String; Tamanho: Word; Lado: Word): String;
Function LerGenerator( fsNome : String; fiIncremento : Integer; fiTamanho : Integer; fbAtualizar : Boolean; prConexao: TSQLConnection = nil ) : String;
//procedure CapturarDadosDaEmpresaEmUso( const prsCodigoEmpresa : String );

var
  pRespMsg : String;
  gsFirebirdDBVersion  : String;
  gsFirebirdODSVersion : String;

implementation

//uses uControllerEmpresa, uClassEmpresa;

Function CriarCampo( fFieldKind : TFieldKind; fDataSet : TDataSet; fFieldName: String; fDataType : TFieldType; fSize : Integer; fDisplayLabel: string = ''; fVisible: boolean = true ) : Tfield ;
Var lfldTemp   : TField;
    lFieldDefs : TFieldDefs;
    liCont     : Word;
begin
   Result := nil;
   If fDataSet.FindField( fFieldName ) = Nil Then
   Begin
      If ( fDataSet.Fields.Count = 0 ) And
         ( ( fDataSet.ClassType <> TClientDataSet ) Or
           ( ( fDataSet.ClassType = TClientDataSet ) And ( TClientDataSet( fDataSet ).ProviderName <> '' ) ) ) Then
      Begin
         fDataSet.Close;
         If fDataSet.ClassType = TClientDataSet Then
            TClientDataSet( fDataSet ).StoreDefs := True;
         fDataSet.FieldDefs.Clear;
         fDataSet.FieldDefs.Update;
         lFieldDefs := fDataSet.FieldDefs;

         For liCont := 1 To fDataSet.FieldDefs.Count Do
         Begin
            lfldTemp := lFieldDefs[ liCont - 1 ].FieldClass.Create( Nil );
            If lFieldDefs[ liCont - 1 ].DataType = ftString Then
               lfldTemp.Size := lFieldDefs[ liCont - 1 ].Size;
            lfldTemp.FieldName  := lFieldDefs[ liCont - 1 ].Name;
            lfldTemp.FieldKind  := fkData;
            lfldTemp.DataSet    := fDataSet;
            lfldTemp.Index      := fDataSet.FieldCount;
            lfldTemp.Name       := fDataSet.Name + lfldTemp.FieldName;
            lfldTemp.Visible    := True;
         End;
      End;

      If fDataType = ftString Then
      Begin
         lfldTemp := TStringField.Create( Nil );
         lfldTemp.Size := fSize;
      End
      Else If fDataType = ftDateTime Then
         lfldTemp := TDateTimeField.Create( Nil )

      Else If fDataType = ftInteger Then
         lfldTemp := TIntegerField.Create( Nil )

      Else If fDataType = ftFloat Then
         lfldTemp := TFloatField.Create( Nil )

      Else If fDataType = ftSmallint  Then
         lfldTemp := TSmallintField.Create( Nil )

      Else If fDataType = ftWord  Then
         lfldTemp := TWordField.Create( Nil )

      Else If fDataType = ftBoolean  Then
         lfldTemp := TBooleanField.Create( Nil )

      Else If fDataType = ftCurrency  Then
         lfldTemp := TCurrencyField.Create( Nil )

      Else If fDataType = ftBCD  Then
         lfldTemp := TBCDField.Create( Nil )

      Else If fDataType = ftDate  Then
         lfldTemp := TDateField.Create( Nil )

      Else If fDataType = ftTime  Then
         lfldTemp := TTimeField.Create( Nil )

      Else If fDataType = ftBytes  Then
         lfldTemp := TBytesField.Create( Nil )

      Else If fDataType = ftVarBytes  Then
         lfldTemp := TVarBytesField.Create( Nil )

      Else If fDataType = ftAutoInc  Then
         lfldTemp := TAutoIncField.Create( Nil )

      Else If fDataType = ftBlob  Then
         lfldTemp := TBlobField.Create( Nil )

      Else If fDataType = ftMemo  Then
         lfldTemp := TMemoField.Create( Nil )

      Else If fDataType = ftGraphic  Then
         lfldTemp := TGraphicField.Create( Nil )

      Else If fDataType = ftWideString  Then
         lfldTemp := TWideStringField.Create( Nil )

      Else If fDataType = ftLargeInt  Then
         lfldTemp := TLargeIntField.Create( Nil )

      Else If fDataType = ftADT  Then
         lfldTemp := TADTField.Create( Nil )

      Else If fDataType = ftArray  Then
         lfldTemp := TArrayField.Create( Nil )

      Else If fDataType = ftReference Then
         lfldTemp := TReferenceField.Create( Nil )

      Else If fDataType = ftTimeStamp Then
         lfldTemp := TSQLTimeStampField.Create( Nil )

      Else If fDataType = ftFMTBcd Then
         lfldTemp := TFMTBcdField.Create( Nil )

      Else
         lfldTemp := TField.Create( Nil );

      lfldTemp.FieldName       := fFieldName;
      lfldTemp.FieldKind       := fFieldKind;
      lfldTemp.DataSet         := fDataSet;
      lfldTemp.Index           := fDataSet.FieldCount;
      lfldTemp.Name            := fDataSet.Name + lfldTemp.FieldName;
      if fDisplayLabel <> '' then
         lfldTemp.DisplayLabel := fDisplayLabel;
      lfldTemp.Visible         := fVisible;
      Result := lfldTemp;
   End;
End;

Function IncZero( fsVlrString:  String; Tamanho: Word; fbApagarBranco : Boolean = False ): String;
Begin
   If fbApagarBranco Then
   Begin
      While Pos( ' ', fsVlrString ) > 0 Do
         Delete( fsVlrString, Pos( ' ', fsVlrString ), 1 );
   End;

   fsVlrString := Trim( fsVlrString );
   While Length( fsVlrString ) < Tamanho Do
      fsVlrString := '0' + fsVlrString;
   Result := fsVlrString;
End;

Function Sequencia( fSQLConnection : TSQLConnection; fCampo: String; fIncrementa: Boolean = True; fTabela : String = ''; fCodEmp : String = ''; fVerTab : String = ''; fverCampo : String = '' ): Integer;
Var lqryModific  : TSQLQuery;
    ldtpVariavel : TDataSetProvider;
    lcdsMax      : TClientDataSet;
    liNovoCod    : Integer;
Begin
   If ( AnsiUpperCase( fTabela ) = 'SEQUENCIAS' ) Then
   Begin
      // TSQLQuery
      lqryModific               := TSQLQuery.Create( Application );
      lqryModific.SQLConnection := fSQLConnection;
      lqryModific.SQL.Text      := 'Select ' + fCampo + ' From Sequencias';
      If ( Trim( fCodEmp ) <> '' ) Then
      Begin
         lqryModific.SQL.Text := 'Select ' + fCampo + ' From Sequencias '+
                                 'Where CodigoEmpresa=:parCodigoEmpresa';
         lqryModific.ParamByName('parCodigoEmpresa').AsInteger := StrToInt( fCodEmp );
      End;

      // DataSetProvider
      ldtpVariavel         := TDataSetProvider.Create( Application );
      ldtpVariavel.DataSet := lqryModific;
      ldtpVariavel.Name    := 'ldtpVariavel';

      // ClientDataSet
      lcdsMax              := TClientDataSet.Create( Application );
      lcdsMax.ProviderName := ldtpVariavel.Name;
      lcdsMax.Open;

      liNovoCod := 1;
      If lcdsMax.FieldByName( fCampo ).AsInteger > 0 Then
         liNovoCod := lcdsMax.FieldByName( fCampo ).AsInteger + 1;

      If fIncrementa Then
      Begin
         // -> Verifincando se a sequencia já existe
         If ( Trim( fVerTab ) <> '' ) Then
         Begin
            lqryModific.Close;
            lqryModific.Params.Clear;
            lqryModific.SQLConnection := fSQLConnection;
            lqryModific.SQL.Text      := 'Select '+ fVerCampo +' From '+ fVerTab +' Where '+
                                         ' '+ fVerCampo +'=:parNovoCod '+
                                         'Where CodigoEmpresa=:parCodigoEmpresa';
            lqryModific.ParamByName('parCodigoEmpresa').AsInteger := StrToInt( fCodEmp );
            lqryModific.Prepared := True;

            While True Do
            Begin
               lqryModific.Close;
               //lqryModific.ParamByName( 'parCod_Emp' ).AsString  := gsCodEmp;
               lqryModific.ParamByName( 'parNovoCod' ).AsInteger := liNovoCod;

               lcdsMax.Close;
               lcdsMax.ProviderName := ldtpVariavel.Name;
               lcdsMax.Open;

               If lcdsMax.IsEmpty Then // se não existi a sequencia sai
                  Break;

               liNovoCod := liNovoCod + 1;
            End;
            lqryModific.Close;
            lqryModific.Prepared := False;
         End;
         // <- Verifincando se a sequencia já existe

         Try
            lqryModific.Close;
            lqryModific.Params.Clear;
            lqryModific.SQLConnection := fSQLConnection;
            lqryModific.SQL.Text      := 'Update ' + fTabela + ' Set ' + fCampo + '=:par1';
            lqryModific.ParamByName( 'par1' ).AsInteger := liNovoCod;
            If Trim( fCodEmp ) <> '' Then
            Begin
               lqryModific.SQL.Text := 'Update ' + fTabela + ' Set ' + fCampo + '=:par1 Where CodigoEmpresa=:parCodEmp';
               lqryModific.ParamByName( 'par1' ).AsInteger      := liNovoCod;
               lqryModific.ParamByName( 'parCodEmp' ).AsInteger := StrToInt( fCodEmp );
            End;
            lqryModific.ExecSQL;
         Except
            On E: Exception Do
            Begin
               MessageDlg( 'Não foi possível gerar a nova sequência ( ' + fCampo +  ' ) "' + E.Message + '"', mtError, [ mbOK ], 0 );
               Result := 0;
               FreeAndNil( lqryModific );
               FreeAndNil( lcdsMax );
               FreeAndNil( ldtpVariavel );
               Exit;
            End;
         End;
         FreeAndNil( lqryModific );
      End;
      FreeAndNil( lcdsMax );
      FreeAndNil( ldtpVariavel );
      Result := liNovoCod;
   End
   Else
   Begin
      // TSQLQuery
      lqryModific               := TSQLQuery.Create( Application );
      lqryModific.SQLConnection := fSQLConnection;
      lqryModific.SQL.Text      := 'Select Max( ' + fCampo + ' ) From ' + fTabela;
      If ( Trim( fCodEmp ) <> '' ) Then
      Begin
         lqryModific.SQL.Text := 'SELECT MAX( ' + fCampo + ' ) FROM ' + fTabela +
                                 ' Where CodigoEmpresa=:parCodigoEmpresa';
         lqryModific.ParamByName('parCodigoEmpresa').AsInteger := StrToInt( fCodEmp );
      End;

      // DataSetProvider
      ldtpVariavel         := TDataSetProvider.Create( Application );
      ldtpVariavel.DataSet := lqryModific;
      ldtpVariavel.Name    := 'ldtpVariavel';

      // ClientDataSet
      lcdsMax              := TClientDataSet.Create( Application );
      lcdsMax.ProviderName := ldtpVariavel.Name;
      lcdsMax.Open;

      liNovoCod := 1;
      If lcdsMax.Fields[ 0 ].AsInteger > 0 Then
         liNovoCod := lcdsMax.Fields[ 0 ].AsInteger + 1;

      FreeAndNil( lcdsMax );
      FreeAndNil( ldtpVariavel );
      FreeAndNil( lqryModific );

      Result := liNovoCod;
   End;
End;

Function SubstString( lstrOriginal, fStrDel : String; fStrIns : String = '';DigitoADigito: Boolean = True ): String;
var I : Word;
    liPos: Word;
begin
   If DigitoADigito Then
   Begin
      For I := 1 To Length( fstrDel ) Do
      Begin
         While Pos( fstrDel[ I ], lstrOriginal ) > 0 Do
         Begin
            liPos := Pos( fstrDel[ I ], lstrOriginal );
            Delete( lstrOriginal, liPos, 1 );
            Insert( fStrIns, lstrOriginal, liPos );
         End;
      End;
   End
   Else
   Begin
      While Pos( fstrDel, lstrOriginal ) > 0 Do
      Begin
         liPos := Pos( fstrDel, lstrOriginal );
         Delete( lstrOriginal, liPos, Length( fstrDel ) );
         Insert( fStrIns, lstrOriginal, liPos );
      End;
   End;
   Result := lstrOriginal;
end;

Function BuscaTabelas( fSQLConnection: TSQLConnection ): TStringList;
Var llstTemp  : TStringList;
    lqryTemp : TSQLQuery;
    ldspTemp : TDataSetProvider;
    lcdsTemp : TClientDataSet;
Begin
   llstTemp  := TStringList.Create;

   lqryTemp               := TSQLQuery.Create( Application );
   lqryTemp.SQLConnection := fSQLConnection;
   lqryTemp.SQL.Text      := 'SELECT RDB$RELATION_NAME as tabelas '+
                             'FROM RDB$RELATIONS '+
                             'WHERE RDB$VIEW_BLR IS NULL AND '+
                             '      (RDB$SYSTEM_FLAG = 0 OR RDB$SYSTEM_FLAG IS NULL) '+
                             'ORDER BY 1';

   ldspTemp         := TDataSetProvider.Create( Application );
   ldspTemp.DataSet := lqryTemp;
   ldspTemp.Name    := 'ldspTemp';

   lcdsTemp              := TClientDataSet.Create( Application );
   lcdsTemp.ProviderName := ldspTemp.Name;
   lcdsTemp.Open;
   while not lcdsTemp.EOF do
   begin
      llstTemp.Add( AnsiUpperCase( Trim( lcdsTemp.FieldByName( 'Tabelas' ).AsString ) ) );

      lcdsTemp.Next;
   end;
   lcdsTemp.Close;
   FreeAndNil( lcdsTemp );
   FreeAndNil( ldspTemp );
   FreeAndNil( lqryTemp );

   Result := llstTemp;
End;

Function CarregarResourceTXT( fsNameResource : String ) : TStringList;
Begin
   Result := TStringList.Create;
   If LoadResource( HInstance, FindResource(HInstance, PWideChar(fsNameResource) , 'TEXT' ) ) <> 0 Then
      TStringList( Result ).LoadFromStream( TResourceStream.Create( HInstance, fsNameResource, 'TEXT' ) );
End;

Function VerificaEstrutura( flstEstruturaLOCAL, flstEstruturaTEC_AI, flstEstruturaTEC_LZ, flstTabelas: TStrings; fProgresso: TProgressBar = Nil; fStatusBar: TStatusBar=Nil; fGauge: TbsSkinGauge = Nil ) : Boolean;
var lsTemp, lsSQL, lsLinha, lsTabela, lsErroGeral, lsVariaveis, lsNomeCampo, lsCampo, lsTipo : String;
    I, Z, liPosNomeTab, liTamanho, liCont : Integer;
    llstTemp, llstCampos1, llstCampos2 : TStringList;
    ltxtTemp : TextFile;

    lqryModificVerEst : TSQLQuery;

    lQryDependencias : TSQLQuery;
    ldspDependencias : TDataSetProvider;
    lcdsDependencias : TClientDataSet;

    lQryNova : TSQLQuery;
    ldspNova : TDataSetProvider;
    lcdsNova : TClientDataSet;

    lQryAtual : TSQLQuery;
    ldspAtual : TDataSetProvider;
    lcdsAtual : TClientDataSet;

    lqryProcedures : TSQLQuery;
    ldspProcedures : TDataSetProvider;
    lcdsProcedures : TClientDataSet;

    lqryTriggers : TSQLQuery;
    ldspTriggers : TDataSetProvider;
    lcdsTriggers : TClientDataSet;

    llstProcedureReSource : TStringList;
    lsNomeProcedure, lsNomeTrigger : String;
    liIndex, liIndiceInicial : Integer;
    llstTriggerReSource, llstTriggers : TStringList;
    lqryModific, lqryValidarTriggers : TSQLQuery;
    lcdsValidarTriggers : TClientDataSet;
    ldspValidarTriggers : TDataSetProvider;
begin
   Result := False;

   lcdsProcedures := TClientDataSet.Create( Application );
   lcdsTriggers   := TClientDataSet.Create( Application );
   Try
      lqryProcedures := TSQLQuery.Create( Application );
      ldspProcedures := TDataSetProvider.Create( Application );
      Try
         // -> Localizando Procedures do banco de dados PRINCIPAL
         lqryProcedures.Close;
         lqryProcedures.SQLConnection := dtmPrincipal.dbxPrincipal;
         lqryProcedures.Params.Clear;
         lqryProcedures.SQL.Text      := 'Select RDB$Procedure_Name, RDB$Procedure_Source ' +
                                         'From RDB$Procedures ' +
                                         'Order By RDB$Procedure_Name';

         ldspProcedures.DataSet := lqryProcedures;
         ldspProcedures.Name    := 'ldspProcedures';

         lcdsProcedures.Close;
         lcdsProcedures.ProviderName := ldspProcedures.Name;
         lcdsProcedures.Open;
      Finally
         FreeAndNil( ldspProcedures );
         FreeAndNil( lqryProcedures );
      End;

      lqryTriggers := TSQLQuery.Create( Application );
      ldspTriggers := TDataSetProvider.Create( Application );
      Try
         // -> Localizando Triggers do banco de dados PRINCIPAL
         lqryTriggers.Close;
         lqryTriggers.SQLConnection := dtmPrincipal.dbxPrincipal;
         lqryTriggers.Params.Clear;
         lqryTriggers.SQL.Text      := 'Select RDB$Trigger_Name ' +
                                       'From RDB$Triggers ' +
                                       'Order By RDB$Trigger_Name';

         ldspTriggers.DataSet := lqryTriggers;
         ldspTriggers.Name    := 'ldspTriggers';

         lcdsTriggers.Close;
         lcdsTriggers.ProviderName := ldspTriggers.Name;
         lcdsTriggers.Open;
      Finally
         FreeAndNil( ldspTriggers );
         FreeAndNil( lqryTriggers );
      End;
   Finally
      FreeAndNil( lcdsTriggers );
      FreeAndNil( lcdsProcedures );
   End;

   ////// *** Tabela de Erros *** //////
   // 0 - Tabela não existe
   // 1 - Novo Campo
   // 2 - Campo excluído
   ////// *** Tabela de Erros *** //////

//   AssignFile( ltxtTemp, gsPath + 'Logs\' + FormatDateTime( 'ddhhmmss', Now ) + '.EST' );
//   ReWrite( ltxtTemp );

   llstCampos1 := TStringList.Create;
   llstCampos2 := TStringList.Create;

   lsVariaveis := 'VARCHAR, CHAR, BLOB';
   lsErroGeral := '';
   If Not DirectoryExists( gsPath + 'Temp\' ) Then
      CreateDir( gsPath + 'Temp\' );

   llstTemp := TStringList.Create;
   While flstTabelas.Count > 0 Do
   begin
      llstTemp.Add( flstTabelas[ 0 ] );
      flstTabelas.Delete( 0 );
   End;

   flstTabelas.Clear;
   While llstTemp.Count > 0 Do
   Begin
      If ( Copy( llstTemp[ 0 ], 1, Length( 'T_TMP_' ) ) <> 'T_TMP_' ) And
         ( Copy( llstTemp[ 0 ], 1, Length( 'T_SALDOS_' ) ) <> 'T_SALDOS_' ) And
         ( Copy( llstTemp[ 0 ], 1, Length( 'T_CTASPAGAR_' ) )<> 'T_CTASPAGAR_' ) And
         ( Copy( llstTemp[ 0 ], 1, Length( 'T_CTASRECEBER_' ) ) <> 'T_CTASRECEBER_' ) Then
      Begin
         flstTabelas.Add( llstTemp[ 0 ] );
      End;
      llstTemp.Delete( 0 );
   End;

   lQryDependencias               := TSQLQuery.Create( Application );
   lQryDependencias.SQLConnection := dtmPrincipal.dbxPrincipal;

   ldspDependencias         := TDataSetProvider.Create( Application );
   ldspDependencias.DataSet := lQryDependencias;
   ldspDependencias.Name    := 'ldspDependencias';

   lcdsDependencias              := TClientDataSet.Create( Application );
   lcdsDependencias.ProviderName := ldspDependencias.Name;

   lqryModificVerEst := TSQLQuery.Create( Application );
   // -> Tabelas de A-I
   For I := 1 To flstEstruturaTEC_AI.Count Do
   Begin
      lsTabela     := Copy( flstEstruturaTEC_AI[ 0 ], Pos( '[', flstEstruturaTEC_AI[ 0 ] ) + 1, Pos( ']', flstEstruturaTEC_AI[ 0 ] ) - 1 - Pos( '[', flstEstruturaTEC_AI[ 0 ] ) );
      lsLinha      := flstEstruturaTEC_AI[ 0 ];
      liPosNomeTab := Pos( '[', lsLinha );
      Delete( lsLinha, liPosNomeTab, Pos( ']', lsLinha ) - liPosNomeTab + 1 );
      Insert( lsTabela, lsLinha, liPosNomeTab );

      If flstTabelas.IndexOf( lsTabela ) = -1 Then // Se a tabela não existir ...
      Begin
         Try
            lqryModificVerEst.Close;
            lqryModificVerEst.SQLConnection := dtmPrincipal.dbxPrincipal;
            lqryModificVerEst.SQL.Text      := ConverteSQL ( lsLinha, gsTipoBD );
            lqryModificVerEst.ExecSQL;
         Except
            On E: Exception Do
            Begin
               FreeAndNil( lqryModificVerEst );
               MessageDlg( 'Não foi possível criar a tabela "'+ lsTabela +'". "' + E.Message + '"', mtError, [ mbOk ], 0 );
               Exit;
            End;
         End;

//         WriteLn( ltxtTemp, 'Tabela criada "' + lsTabela + '"' );

         flstEstruturaTEC_AI.Delete(0);
      End
      Else // -> Se a tabela existir ...
      Begin
         If flstEstruturaLOCAL.IndexOf( flstEstruturaTEC_AI[ 0 ] ) = -1 Then
         Begin
            // Deletando as depencias da tabela
            lQryDependencias.Close;
            lQryDependencias.Params.Clear;
            lQryDependencias.SQLConnection := dtmPrincipal.dbxPrincipal;
            lQryDependencias.SQL.Text      := 'SELECT RDB$DEPENDENT_NAME, RDB$DEPENDENT_TYPE '+
                                              'FROM RDB$DEPENDENCIES '+
                                              'WHERE RDB$DEPENDED_ON_NAME='+ QuotedStr( lsTabela )+' '+
                                              'GROUP BY RDB$DEPENDENT_NAME, RDB$DEPENDENT_TYPE';

            lcdsDependencias.Close;
            lcdsDependencias.ProviderName := ldspDependencias.Name;
            lcdsDependencias.Open;
            While Not lcdsDependencias.Eof Do
            Begin
               If lcdsDependencias.FieldByName( 'RDB$DEPENDENT_TYPE' ).AsInteger = 2 Then // Triggers
               Begin
                  Try
                     lqryModificVerEst.Close;
                     lqryModificVerEst.SQLConnection := dtmPrincipal.dbxPrincipal;
                     lqryModificVerEst.SQL.Text      := 'Drop Trigger '+ Trim( lcdsDependencias.FieldByName( 'RDB$DEPENDENT_NAME' ).AsString );
                     lqryModificVerEst.ExecSQL;
                  Except
                  End;
               End
               Else If lcdsDependencias.FieldByName( 'RDB$DEPENDENT_TYPE' ).AsInteger = 5 Then // procedure
               Begin
                  Try
                     if ProcedureExiste( Trim( lcdsDependencias.FieldByName( 'RDB$DEPENDENT_NAME' ).AsString ) ) then
                     Begin
                        ExcluirDependencias(dtmPrincipal.dbxPrincipal, lcdsDependencias.FieldByName( 'RDB$DEPENDENT_NAME' ).AsString);
                        lqryModificVerEst.Close;
                        lqryModificVerEst.SQLConnection := dtmPrincipal.dbxPrincipal;
                        lqryModificVerEst.SQL.Text      := 'Drop Procedure '+ Trim( lcdsDependencias.FieldByName( 'RDB$DEPENDENT_NAME' ).AsString );
                        lqryModificVerEst.ExecSQL;
                     End;
                  Except
                  End;

                  Try
                     if ProcedureExiste( lcdsDependencias.FieldByName( 'RDB$DEPENDENT_NAME' ).AsString ) then
                     Begin
                        lqryModificVerEst.Close;
                        lqryModificVerEst.SQLConnection := dtmPrincipal.dbxPrincipal;
                        lqryModificVerEst.SQL.Text      := 'Delete From RDB$Procedure_parameters '+
                                                           'Where rdb$procedure_name='+ QuotedStr( Trim( lcdsDependencias.FieldByName( 'RDB$DEPENDENT_NAME' ).AsString ) );
                        lqryModificVerEst.ExecSQL;
                     End;
                  Except
                  End;
               End;

               lcdsDependencias.Next;
            End;

            lsSQL := Copy( flstEstruturaTEC_AI[ 0 ], Pos( ']', flstEstruturaTEC_AI[ 0 ] ) + 1, Length( flstEstruturaTEC_AI[ 0 ] ) );
            Try
               lqryModificVerEst.Close;
               lqryModificVerEst.SQL.Clear;
               lqryModificVerEst.SQLConnection := dtmPrincipal.dbxPrincipal;
               lqryModificVerEst.SQL.Text      := 'RECREATE TABLE ' + lsTabela + '__TMP__' + lsSQL;
               lqryModificVerEst.ExecSQL;

               lqryModificVerEst.Close;
               lqryModificVerEst.SQL.Clear;
               lqryModificVerEst.SQLConnection := dtmPrincipal.dbxPrincipal;
               lqryModificVerEst.SQL.Text      := 'COMMIT';
               lqryModificVerEst.ExecSQL;
            Except
               On E: Exception Do
               Begin
                  FreeAndNil( lcdsDependencias );
                  FreeAndNil( ldspDependencias );
                  FreeAndNil( lQryDependencias );
                  FreeAndNil( lqryModificVerEst );
                  MessageDlg( 'Não foi possível recriar a tabela "'+ lsTabela +'". "' + E.Message + '"', mtError, [ mbOk ], 0 );
                  Exit;
               End;
            End;

            // -> Buscando os campos da tabela
            llstTemp := BuscaCampos( lsTabela, dtmPrincipal.dbxPrincipal );

            llstCampos1.Clear;
            llstCampos2.Clear;
            For liCont := 0 To llstTemp.Count - 1 Do
            Begin
               lsTemp    := llstTemp[ liCont ];
               lsCampo   := Copy( lsTemp, 1, Pos( ';', lsTemp ) - 1 );
               Delete( lsTemp, 1, Pos( ';', lsTemp ) );
               lsTipo    := Copy( lsTemp, 1, Pos( ';', lsTemp ) - 1 );
               Delete( lsTemp, 1, Pos( ';', lsTemp ) );
               liTamanho := StrToInt( lsTemp );

               If ( liTamanho = -1 ) Or ( lsTipo = 'BLOB' ) Or ( lsTipo = 'FLOAT' ) Then
               Begin
                  llstCampos1.Add( lsCampo );
                  llstCampos2.Add( lsCampo + ' ' + lsTipo );
               End
               Else
               Begin
                  llstCampos1.Add( lsCampo );
                  llstCampos2.Add( lsCampo + ' ' + lsTipo + ' (' + IntToStr( liTamanho ) + ')');
               End;
            End;
            llstCampos1.Sorted := True;
            llstCampos2.Sorted := True;
            // <- Buscando os campos da tabela

            lQryNova               := TSQLQuery.Create( Application );
            lQryNova.SQLConnection := dtmPrincipal.dbxPrincipal;

            ldspNova               := TDataSetProvider.Create( Application );
            ldspNova.DataSet       := lQryNova;
            ldspNova.Name          := 'ldspNova';

            lcdsNova               := TClientDataSet.Create( Application );
            lcdsNova.ProviderName  := ldspNova.Name;

            lQryAtual               := TSQLQuery.Create( Application );
            lQryAtual.SQLConnection := dtmPrincipal.dbxPrincipal;
            lQryAtual.SQL.Text      := 'SELECT * FROM ' + lsTabela +' Where 1=2';

            ldspAtual               := TDataSetProvider.Create( Application );
            ldspAtual.DataSet       := lQryAtual;
            ldspAtual.Name          := 'ldspAtual';

            lcdsAtual               := TClientDataSet.Create( Application );
            lcdsAtual.ProviderName  := ldspAtual.Name;
            lcdsAtual.Open;

            lQryNova.SQL.Clear;
            lQryNova.SQL.Text := 'SELECT * FROM ' + lsTabela + '__TMP__';

            lcdsNova.Close;
            lcdsNova.ProviderName := ldspNova.Name;
            lcdsNova.Open;

            For Z := 1 To lcdsNova.Fields.Count Do
            Begin
               lsTipo := ProcuraTipo( lcdsNova.Fields[ Z - 1 ].DataType, gsTipoBD );

               // Verificando se é campo varchar com + de 255 caracteres
               If ( ( lcdsNova.Fields[ Z - 1 ].DataType = ftBlob ) Or
                    ( lcdsNova.Fields[ Z - 1 ].DataType = ftMemo ) ) And
                    ( lcdsNova.Fields[ Z - 1 ].Size > 1 ) Then
               Begin
                  lsTipo := 'VARCHAR';
               End;

               If ( lcdsNova.Fields[ Z - 1 ].DataType = ftFloat ) or ( lcdsNova.Fields[ Z - 1 ].DataType = ftFMTBcd ) Then
               Begin
                  If Pos( lcdsNova.Fields[ Z - 1 ].FieldName + ' ', lsSQL ) > 0 Then
                  Begin
                     lsTemp := Copy( lsSQL, Pos( lcdsNova.Fields[ Z - 1 ].FieldName + ' ', lsSQL ), Length( lsSQL ) );
                     lsTemp := AnsiUpperCase( Trim( Copy( lsTemp, 1, Pos( ')', lsTemp ) ) ) );
                     If ( Copy( lsTemp, Pos( ' ', lsTemp )+1, 7 ) = 'NUMERIC' ) then
                     begin
                        lsTemp := AnsiUpperCase( Trim( Copy( lsTemp, 1, Pos( ')', lsTemp ) ) ) );
                        lsTemp := Trim( Copy( lsTemp, Pos( ' ', lsTemp ), Length( lsTemp ) ) );
                        lsTipo := 'NUMERIC';
                     end;
                  End;
               End;

               liTamanho := -1;
               If Pos( AnsiUpperCase( lsTipo ) + ',', AnsiUpperCase( lsVariaveis ) ) > 0 Then
                  liTamanho := lcdsNova.Fields[ Z - 1 ].Size;
               If lsTipo = 'NUMERIC' Then
                  liTamanho := 0;
               If lsTipo = 'DATE' Then
                  liTamanho := -1;
               If lsTipo = 'FLOAT' Then
                  liTamanho := -1;

               lsNomeCampo := lcdsNova.Fields[ Z - 1 ].FieldName;

               If lcdsAtual.FieldDefs.IndexOf( lsNomeCampo ) > -1 Then
               Begin
                  If ( ( liTamanho = -1 ) And ( llstCampos2.IndexOf( lsNomeCampo + ' ' + lsTipo ) > -1 ) Or
                     ( ( liTamanho > -1 ) And ( llstCampos2.IndexOf( lsNomeCampo + ' ' + lsTipo + ' (' + IntToStr( liTamanho ) + ')' ) > -1 ) ) ) Then
                  Begin
                     If llstCampos1.IndexOf( lsNomeCampo ) > -1 Then
                     Begin
                        llstCampos2.Delete(llstCampos1.IndexOf( lsNomeCampo ));
                        llstCampos1.Delete(llstCampos1.IndexOf( lsNomeCampo ));
                     End;
                  End
                  Else // O nome confere mas o tipo e o tamanho não
                  Begin
                     Try // Tenta converter o campo
                        lqryModificVerEst.Close;
                        lqryModificVerEst.SQL.Text := ConverteSQL ( 'ALTER TABLE '+lsTabela+' ALTER '+lsNomeCampo + ' TYPE ' + lsTipo, gsTipoBD ) ;
                        If liTamanho > -1 Then
                        Begin
                           lqryModificVerEst.Close;
                           lqryModificVerEst.SQL.Text := ConverteSQL ( 'ALTER TABLE '+lsTabela+' ALTER '+lsNomeCampo + ' TYPE ' + lsTipo + ' (' + IntToStr( liTamanho ) + ')', gsTipoBD );
                           If AnsiUpperCase( Trim( lsTipo ) ) = 'NUMERIC' Then
                              lqryModificVerEst.SQL.Text := ConverteSQL ( 'ALTER TABLE '+lsTabela+' ALTER '+lsNomeCampo + ' TYPE ' + lsTemp, gsTipoBD );

                           If AnsiUpperCase( Trim( lsTipo ) ) = 'VARCHAR' Then
                           Begin
                              lqryModificVerEst.ExecSQL;

                              lQryAtual.Close;
                              lqryAtual.SQLConnection := dtmPrincipal.dbxPrincipal;
                              lQryAtual.SQL.Text      := 'Select * From ' + lsTabela +' Where 1=2';

                              lcdsAtual.Close;
                              lcdsAtual.ProviderName := ldspAtual.Name;
                              lcdsAtual.Open;
                              If lcdsAtual.FieldDefs[ lcdsAtual.FieldDefs.IndexOf( lsNomeCampo ) ].Size < liTamanho Then
                              Begin
                                 lqryModificVerEst.Close;
                                 lqryModificVerEst.SQLConnection := dtmPrincipal.dbxPrincipal;
                                 lqryModificVerEst.SQL.Text      := ConverteSQL ( 'ALTER TABLE '+lsTabela+' ALTER '+lsNomeCampo + ' TYPE ' + lsTipo + ' (' + IntToStr( liTamanho ) + ')', gsTipoBD );
                              End;
                           End;
                        End;
                        lqryModificVerEst.ExecSQL;

//                        WriteLn( ltxtTemp, 'Campo "' + lsNomeCampo + '" atualizado na Tabela "' + lsTabela + '"' );
                     Except // Se não conseguiu converter, exclui e cria o campo novamente
                        Try
                           lqryModificVerEst.Close;
                           lqryModificVerEst.SQLConnection := dtmPrincipal.dbxPrincipal;
                           lqryModificVerEst.SQL.Text      := 'ALTER TABLE ' + lsTabela + ' DROP '+lsNomeCampo;
                           lqryModificVerEst.ExecSQL;
                        Except
                           On E: Exception Do
                           Begin
                              MessageDlg('Não foi possível excluir o campo "'+lsNomeCampo+'" na tabela "'+lsTabela+'" ('+E.Message+')', mtError, [mbOk], 0);
                           End;
                        End;

                        Try
                           lqryModificVerEst.Close;
                           lqryModificVerEst.SQLConnection := dtmPrincipal.dbxPrincipal;
                           lqryModificVerEst.SQL.Text      := ConverteSQL ( 'ALTER TABLE '+lsTabela+' ADD '+lsNomeCampo+' '+lsTipo, gsTipoBD ) ;
                           If liTamanho > -1 Then
                              lqryModificVerEst.SQL.Text := ConverteSQL ( 'ALTER TABLE '+lsTabela+' ADD '+lsNomeCampo+' '+lsTipo+' ('+IntToStr(liTamanho)+')', gsTipoBD );
                           If AnsiUpperCase( Trim( lsTipo ) ) = 'NUMERIC' Then
                              lqryModificVerEst.SQL.Text := ConverteSQL ( 'ALTER TABLE '+lsTabela+' ADD '+lsNomeCampo + ' ' + lsTemp, gsTipoBD );
                           lqryModificVerEst.ExecSQL;
                        Except
                           On E: Exception Do
                           Begin
                              MessageDlg('Não foi possível incluir o campo "'+lsNomeCampo+'" na tabela "'+lsTabela+'" ( '+ lqryModificVerEst.SQL.Text + ' )! ' + E.Message, mtError, [mbOk], 0);
                           End;
                        End;

//                        WriteLn( ltxtTemp, 'Campo "' + lsNomeCampo + '" recriado na Tabela "' + lsTabela + '"' );
                     End;

                     If llstCampos1.IndexOf( lsNomeCampo )>-1 Then
                     Begin
                        llstCampos2.Delete(llstCampos1.IndexOf( lsNomeCampo ));
                        llstCampos1.Delete(llstCampos1.IndexOf( lsNomeCampo ));
                     End;
                  End;
               End
               Else
               Begin
//                  WriteLn( ltxtTemp, 'Campo "' + lsNomeCampo + '" criado na Tabela "' + lsTabela + '"' );

                  Try
                     lqryModificVerEst.Close;
                     lqryModificVerEst.SQLConnection := dtmPrincipal.dbxPrincipal;
                     lqryModificVerEst.SQL.Text    := ConverteSQL ( 'ALTER TABLE '+lsTabela+' ADD '+lsNomeCampo+' '+lsTipo, gsTipoBD );
                     If liTamanho > -1 Then
                        lqryModificVerEst.SQL.Text := ConverteSQL ( 'ALTER TABLE '+lsTabela+' ADD '+lsNomeCampo+' '+lsTipo+' ('+IntToStr(liTamanho)+')', gsTipoBD );
                     If AnsiUpperCase( Trim( lsTipo ) ) = 'NUMERIC' Then
                        lqryModificVerEst.SQL.Text := ConverteSQL ( 'ALTER TABLE '+lsTabela+' ADD '+lsNomeCampo + ' ' + lsTemp, gsTipoBD );
                     lqryModificVerEst.ExecSQL;
                  Except
                     On E: Exception Do
                     Begin
                        MessageDlg('Não foi possível incluir o campo "'+lsNomeCampo+'" na tabela "'+lsTabela+'" ('+E.Message+')', mtError, [mbOk], 0);
                     End;
                  End;
               End;
            End;

            FreeAndNil( lcdsNova );
            FreeAndNil( ldspNova );
            FreeAndNil( lQryNova );

            lqryModificVerEst.Close;
            lqryModificVerEst.SQLConnection := dtmPrincipal.dbxPrincipal;
            lqryModificVerEst.SQL.Text      := 'DROP TABLE ' + lsTabela + '__TMP__';
            Try
               lqryModificVerEst.ExecSQL;
            Except
               On E: Exception Do
               Begin
                  FreeAndNil( lcdsDependencias );
                  FreeAndNil( ldspDependencias );
                  FreeAndNil( lQryDependencias );
                  FreeAndNil( lqryModificVerEst );
                  FreeAndNil( lcdsNova );
                  FreeAndNil( ldspNova );
                  FreeAndNil( lQryNova );
                  FreeAndNil( lcdsAtual );
                  FreeAndNil( ldspAtual );
                  FreeAndNil( lQryAtual );
                  MessageDlg( 'Não foi possível criar a tabela de conferência ("'+E.MEssage+'")', mtError, [mbOk], 0);
                  Exit;
               End;
            End;

            For Z:=1 to llstCampos1.Count do
            Begin
               Try
                  lqryModificVerEst.Close;
                  lqryModificVerEst.SQLConnection := dtmPrincipal.dbxPrincipal;
                  lqryModificVerEst.SQL.Text := 'ALTER TABLE ' + lsTabela + ' DROP ' + llstCampos1[ Z - 1 ];
                  If ( AnsiUpperCase( Trim( gsTipoBD ) ) = 'SQL SERVER' ) Then
                     lqryModificVerEst.SQL.Text := 'ALTER TABLE ' + lsTabela + ' DROP COLUMN ' + llstCampos1[ Z - 1 ];
                  lqryModificVerEst.ExecSQL;
               Except
                  On E: Exception Do
                  Begin
                     FreeAndNil( lcdsDependencias );
                     FreeAndNil( ldspDependencias );
                     FreeAndNil( lQryDependencias );
                     FreeAndNil( lqryModificVerEst );
                     FreeAndNil( lcdsNova );
                     FreeAndNil( ldspNova );
                     FreeAndNil( lQryNova );
                     FreeAndNil( lcdsAtual );
                     FreeAndNil( ldspAtual );
                     FreeAndNil( lQryAtual );
                     MessageDlg('Não foi possível criar a tabela de conferência ("'+E.MEssage+'")', mtError, [mbOk], 0);
                     Exit;
                  End;
               End;
//               WriteLn( ltxtTemp, 'Campo "' + llstCampos1[ Z - 1 ] + '" excluído na Tabela "' + lsTabela + '"' );
            End;
            llstCampos1.Clear;
            llstCampos2.Clear;
            FreeAndNil( lcdsNova );
            FreeAndNil( ldspNova );
            FreeAndNil( lQryNova );
            FreeAndNil( lcdsAtual );
            FreeAndNil( ldspAtual );
            FreeAndNil( lQryAtual );
         End;

         If flstTabelas.IndexOf( lsTabela ) > -1 Then
            flstTabelas.Delete( flstTabelas.IndexOf( lsTabela ) )
         Else
         Begin
            Try
               lqryModificVerEst.Close;
               lqryModificVerEst.SQLConnection := dtmPrincipal.dbxPrincipal;
               lqryModificVerEst.SQL.Text      := ConverteSQL ( lsLinha, gsTipoBD );
               lqryModificVerEst.ExecSQL;
            Except
               On E: Exception Do
               Begin
                  FreeAndNil( lqryModificVerEst );
                  MessageDlg('Não foi possível criar a tabela ('+E.Message+')', mtError, [mbOk], 0);
                  Exit;
               End;
            End;
//            WriteLn( ltxtTemp, 'Tabela "' + lsTabela + '" criada' );
         End;
         flstEstruturaTEC_AI.Delete(0);
      End; // <- Se a tabela existir ...
   End;
   // <- Tabelas de A-I
   FreeAndNil( lcdsDependencias );
   FreeAndNil( ldspDependencias );
   FreeAndNil( lQryDependencias );

   While flstTabelas.Count > 0 Do
   Begin
      If ( Copy( AnsiUpperCase( Trim ( flstTabelas[ 0 ] ) ), 1, 7) = 'T_CHART' ) Or
         ( AnsiUpperCase( Copy( flstTabelas[ 0 ], 1, Length( 'T_TMP_' ) ) ) = 'T_TMP_' ) Then
      Begin
         flstTabelas.Delete( 0 )
      End
      Else
      Begin
         If (MessageDlg( 'A tabela "' + flstTabelas[ 0 ] + '" não faz parte da estrutura atual, deseja descartá-la?', mtConfirmation, [ mbYes, mbNo ], 0 )) = 0 Then
         Begin
            Try
               lqryModificVerEst.Close;
               lqryModificVerEst.SQLConnection := dtmPrincipal.dbxPrincipal;
               lqryModificVerEst.SQL.Text     := 'DROP TABLE ' + flstTabelas[ 0 ];
               lqryModificVerEst.ExecSQL;
            Except
               On E: Exception Do
               Begin
                  FreeAndNil( lqryModificVerEst );
                  MessageDlg( 'Não foi possível excluir a tabela " ' +
                                  flstTabelas[ 0 ] + '" ("' + E.Message + '")', mtError, [ mbOk ], 0 );
                  Exit;
               End;
            End;
//            WriteLn( ltxtTemp, 'Tabela "' + flstTabelas[ 0 ] + '" excluída' );
            flstTabelas.Delete( 0 );
         End
         Else
            flstTabelas.Delete( 0 );
     End;
   End;

   llstTriggerReSource := TStringList.Create;
   llstTriggers := TStringList.Create;
   Try
      For liCont := 1 To 500 Do
      Begin
         If LoadResource( HInstance, FindResource(HInstance, PWideChar( 'PRINC_Trigger' + IntToStr( liCont ) ), 'TEXT' ) ) <> 0 Then
         Begin
            llstTriggerReSource.LoadFromStream( TResourceStream.Create( HInstance, 'PRINC_Trigger' + IntToStr( liCont ), 'TEXT' ) );
            llstTriggers.Add( llstTriggerReSource.Text );
         End;
      End;
   Finally
      FreeAndNil( llstTriggerReSource );
   End;

   lqryModific := TSQLQuery.Create( Application );
   lqryValidarTriggers := TSQLQuery.Create( Application );
   lqryValidarTriggers.SQLConnection := dtmPrincipal.dbxPrincipal;
   ldspValidarTriggers := TDataSetProvider.Create( Application );
   ldspValidarTriggers.Name := 'ldspValidarTriggers';
   ldspValidarTriggers.DataSet :=  lqryValidarTriggers;
   lcdsValidarTriggers := TClientDataSet.Create( Application );

   Try
      While llstTriggers.Count > 0 Do
      Begin
         liIndiceInicial := Length( 'CREATE TRIGGER ' ) + 1;
         If AnsiSameText( Copy( Trim( llstTriggers[ 0 ] ), 1, Length( 'RECREATE TRIGGER' ) ), 'RECREATE TRIGGER' ) Then
            liIndiceInicial := liIndiceInicial + 2;
         lsNomeTrigger := Trim( Copy( Trim( llstTriggers[ 0 ] ), liIndiceInicial, Pos( ' FOR ', Trim( llstTriggers[ 0 ] ) ) - liIndiceInicial ) );

         lqryValidarTriggers.Close;
         lqryValidarTriggers.Params.Clear;
         lqryValidarTriggers.ParamCheck := False;
         lqryValidarTriggers.SQL.Text   := 'Select RDB$Trigger_Name From RDB$Triggers ' +
                                           'Where RDB$Trigger_Name=' + QuotedStr( lsNomeTrigger );

         lcdsValidarTriggers.Close;
         lcdsValidarTriggers.ProviderName := ldspValidarTriggers.Name;
         lcdsValidarTriggers.Open;

         If ( NOT lcdsValidarTriggers.IsEmpty ) Then
         Begin
            Try
               try
                  lqryModific.SQLConnection := dtmPrincipal.dbxPrincipal;
                  lqryModific.Params.Clear;
                  lqryModific.ParamCheck := True;
                  lqryModific.SQL.Text   := 'DROP TRIGGER ' + lsNomeTrigger;
                  lqryModific.ExecSQL;
               finally
                  FreeAndNil(lqryModific);
               end;
            Except
               On E: Exception Do
               Begin
                   MessageDlg( 'Não foi possível excluir a Trigger "' + lsNomeTrigger + '"! ' + E.Message, mtError, [ mbOk ], 0 );
                   Exit;
               End;
            End;
            lcdsValidarTriggers.Close;
            lcdsValidarTriggers.ProviderName := ldspValidarTriggers.Name;
            lcdsValidarTriggers.Open;
         End;

         If lcdsValidarTriggers.IsEmpty Then
         begin
            lqryModific.SQLConnection := dtmPrincipal.dbxPrincipal;
            lqryModific.Params.Clear;
            lqryModific.ParamCheck := False;
            lqryModific.SQL.Text   := Trim( llstTriggers[ 0 ] );
            lqryModific.ExecSQL;
         end;
         lcdsValidarTriggers.Close;
         llstTriggers.Delete( 0 );
      End;
   Finally
      lqryModific.Close;
      FreeAndnil( lqryModific );
   End;

{   If fStatusbar = Nil Then
      ReconstruirStoredProcedures( Nil, True )
   Else
      ReconstruirStoredProcedures( fStatusbar.Panels[ 0 ], True );
 }
   Result := True;
end;

Function ConverteSQL( fStr : String;  fTipoBD : String ) : String;
Var liPos : Integer;
Begin
   fStr := AnsiUpperCase( Trim( fStr ) );
   If AnsiUpperCase( Trim(  fTipoBD ) ) = 'STANDARD' Then
   Begin
      If Copy( fStr, 1, Length( 'Create Table' ) ) = 'CREATE TABLE' Then
      Begin
         While True Do
         Begin
            liPos := Pos( 'BLOB SUB_TYPE 0 SEGMENT SIZE 1', fStr );
            If liPos = 0 Then
               Break;
            Delete( fStr, liPos, Length( 'BLOB SUB_TYPE 0 SEGMENT SIZE 1' ) );
            Insert( 'BLOB', fStr, liPos );
         End;
      End;
   End
   Else If AnsiUpperCase( Trim(  fTipoBD ) ) = 'SQL SERVER' Then
   Begin
      If Copy( fStr, 1, Length( 'Create Table' ) ) = 'CREATE TABLE' Then
      Begin
         While True Do
         Begin
            liPos := Pos( 'DATE,', fStr );
            If ( liPos = 0 ) Then
               Break;
            Delete( fStr, liPos, Length( 'DATE,' ) );
            Insert( 'DATETIME,', fStr, liPos );
         End;
         While True Do
         Begin
            liPos := Pos( 'DATE)', fStr );
            If ( liPos = 0 ) Then
               Break;
            Delete( fStr, liPos, Length( 'DATE)' ) );
            Insert( 'DATETIME)', fStr, liPos );
         End;
         While True Do
         Begin
            liPos := Pos( ' DATE ', fStr );
            If ( liPos = 0 ) Then
               Break;
            Delete( fStr, liPos, Length( ' DATE ' ) );
            Insert( ' DATETIME ', fStr, liPos );
         End;
         While True Do
         Begin
            liPos := Pos( 'BLOB SUB_TYPE 0 SEGMENT SIZE 1', fStr );
            If liPos = 0 Then
               Break;
            Delete( fStr, liPos, Length( 'BLOB SUB_TYPE 0 SEGMENT SIZE 1' ) );
            Insert( 'TEXT', fStr, liPos );
         End;
         While True Do
         Begin
            liPos := Pos( 'BLOB', fStr );
            If liPos = 0 Then
               Break;
            Delete( fStr, liPos, Length( 'BLOB' ) );
            Insert( 'TEXT', fStr, liPos );
         End;
      End;
   End;
   Result := fStr;
End;

function ProcedureExiste( prsNomeProcedure : String ) : Boolean;
begin
   Result := ObjetoFirebirdExiste( 'PROCEDURE', prsNomeProcedure );
end;

function ObjetoFirebirdExiste( prsTipoObjeto : String; prsNomeObjeto : String ) : Boolean;
var lqryObjetoFirebirdExiste : TSQLQuery;
    ldspObjetoFirebirdExiste : TDataSetProvider;
    lcdsObjetoFirebirdExiste : TClientDataSet;
begin
   lqryObjetoFirebirdExiste := TSQLQuery.Create( Application );
   ldspObjetoFirebirdExiste := TDataSetProvider.Create( Application );
   lcdsObjetoFirebirdExiste := TClientDataSet.Create( Application );
   Try
      Try
         lqryObjetoFirebirdExiste.Close;
         lqryObjetoFirebirdExiste.Params.Clear;
         lqryObjetoFirebirdExiste.SQLConnection := DtmPrincipal.DbxPrincipal;
         lqryObjetoFirebirdExiste.SQL.Text      := 'SELECT RDB$' + prsTipoObjeto + '_NAME FROM RDB$' + prsTipoObjeto + 'S ' +
                                                   'WHERE RDB$' + prsTipoObjeto + '_NAME=:par1';
         lqryObjetoFirebirdExiste.ParamByName( 'par1' ).AsString := prsNomeObjeto;

         ldspObjetoFirebirdExiste.DataSet := lqryObjetoFirebirdExiste;
         ldspObjetoFirebirdExiste.Name    := 'ldspObjetoFirebirdExiste';

         lcdsObjetoFirebirdExiste.Close;
         lcdsObjetoFirebirdExiste.ProviderName := ldspObjetoFirebirdExiste.Name;
         lcdsObjetoFirebirdExiste.Open;
         Result := NOT lcdsObjetoFirebirdExiste.EOF;
      Except
         On E: Exception Do
         Begin
            Result := False;
            MessageDlg( 'Não foi possível consultar se o objeto de banco de dados "' + Trim( prsNomeObjeto ) + '" existe! ' + E.Message, mtError, [ mbOk ], 0 );
            Exit;
         End;
      End;
   Finally
      FreeAndNil( lcdsObjetoFirebirdExiste );
      FreeAndNil( ldspObjetoFirebirdExiste );
      FreeAndNil( lqryObjetoFirebirdExiste );
   End;
end;

function ExcluirDependencias( const proSQLConnection : TSQLConnection; const prsObjeto : String; fProgresso: TProgressBar = Nil; fObject : TObject = Nil ) : Boolean;
var lqryDependencias : TSQLQuery;
    ldspDependencias : TDataSetProvider;
    lcdsDependencias : TClientDataSet;
Begin
   ExcluirDependencias := False;

   lqryDependencias := TSQLQuery.Create( Application );
   ldspDependencias := TDataSetProvider.Create( Application );
   lcdsDependencias := TClientDataSet.Create( Application );
   Try
      lqryDependencias.Close;
      lqryDependencias.SQLConnection := proSQLConnection;
      lqryDependencias.Params.Clear;
      lqryDependencias.SQL.Text     := 'select * from ( ' +
                                       '   select ''Procedure'', rdb$procedure_name from rdb$procedures ' +
                                       '     union ' +
                                       '   select ''Trigger'', rdb$trigger_name from rdb$triggers ' +
                                       ' ) (type, name) ' +
                                       'where exists ' +
                                       '   (select * from rdb$dependencies ' +
                                       '    where rdb$dependent_name = name and rdb$depended_on_name=:parrdb$depended_on_name )';
      lqryDependencias.ParamByName( 'parRDB$Depended_On_Name' ).AsString := prsObjeto;

      ldspDependencias.DataSet := lqryDependencias;
      ldspDependencias.Name    := 'ldspDependencias9';

      lcdsDependencias.Close;
      lcdsDependencias.ProviderName := ldspDependencias.Name;
      lcdsDependencias.Open;
      While NOT lcdsDependencias.EOF Do
      Begin
         ExcluirDependencias := True;

         Try
            lqryDependencias.Close;
            lqryDependencias.SQLConnection := proSQLConnection;
            lqryDependencias.Params.Clear;
            lqryDependencias.SQL.Text := 'DROP ' + Trim( lcdsDependencias.FieldByName( 'Type' ).AsString ) + ' ' + Trim( lcdsDependencias.FieldByName( 'Name' ).AsString );
            lqryDependencias.ExecSQL;
         Except
            On E: Exception Do
            Begin
               MessageDlg( 'Não foi possível excluir a dependência "' + Trim( lcdsDependencias.FieldByName( 'Name' ).AsString ) + '" de "' + prsObjeto + '"! ' + E.Message, mtError, [ mbOk ], 0 );
               Exit;
            End;
         End;
         lcdsDependencias.Next;
      End;
      lcdsDependencias.Close;
   Finally
      lcdsDependencias.Close;
      FreeAndNil( lcdsDependencias );

      FreeAndNil( ldspDependencias );

      lqryDependencias.Close;
      FreeAndNil( lqryDependencias );
   End;
End;

Function BuscaCampos( fsTabela: String; fSQLConnection: TSQLConnection ): TStringList;
Var llstTemp  : TStringList;
    lqryBuscaCampos : TSQLQuery;
    ldspBuscaCampos : TDataSetProvider;
    lcdsBuscaCampos : TClientDataSet;
    lsTipo : String;
Begin
   llstTemp  := TStringList.Create;

   // Listar as tabelas do banco de dados
   lqryBuscaCampos               := TSQLQuery.Create( Application );
   lqryBuscaCampos.SQLConnection := fSQLConnection;
   lqryBuscaCampos.SQL.Text      := 'SELECT RF1.RDB$FIELD_NAME AS Campo, '+
                                    '       F.RDB$FIELD_TYPE AS Tipo, '+
                                    '       F.RDB$FIELD_LENGTH AS Tamanho  '+
                                    'FROM RDB$RELATIONS R,  '+
                                    '     RDB$RELATION_FIELDS RF1, '+
                                    '     RDB$FIELDS F '+
                                    'Where R.RDB$RELATION_NAME='+ QuotedStr( fsTabela ) +' AND '+
                                    '      RF1.RDB$RELATION_NAME=R.RDB$RELATION_NAME And '+
                                    '      F.RDB$FIELD_NAME=RF1.RDB$FIELD_SOURCE '+
                                    'ORDER BY 1';

   ldspBuscaCampos         := TDataSetProvider.Create( Application );
   ldspBuscaCampos.DataSet := lqryBuscaCampos;
   ldspBuscaCampos.Name    := 'ldspBuscaCampos';

   lcdsBuscaCampos              := TClientDataSet.Create( Application );
   lcdsBuscaCampos.ProviderName := ldspBuscaCampos.Name;
   lcdsBuscaCampos.Open;
   While Not lcdsBuscaCampos.EOF Do
   Begin
      Case lcdsBuscaCampos.FieldByName( 'Tipo' ).AsInteger Of
           7 : lsTipo := 'SMALLINT';
           8 : lsTipo := 'INTEGER';
          10 : lsTipo := 'FLOAT';
          14 : lsTipo := 'CHAR';
          27 : lsTipo := 'NUMERIC (15,2)'; // 27 = NUMERIC, DECIMAL ou DOUBLE_PRECISION
          35 : lsTipo := 'DATE';
          37 : lsTipo := 'VARCHAR';
         261 : lsTipo := 'BLOB';
      End;

      Case lcdsBuscaCampos.FieldByName( 'Tipo' ).AsInteger Of
           14, 37 :
           Begin
              llstTemp.Add( AnsiUpperCase( Trim( lcdsBuscaCampos.FieldByName( 'Campo' ).AsString ) ) +';'+
              lsTipo +';'+
              lcdsBuscaCampos.FieldByName( 'Tamanho' ).AsString );
           end
           else
           Begin
              llstTemp.Add( AnsiUpperCase( Trim( lcdsBuscaCampos.FieldByName( 'Campo' ).AsString ) ) +';'+
              lsTipo +';'+
              '-1' );
           end;
      End;

      lcdsBuscaCampos.Next;
   End;
   lcdsBuscaCampos.Close;
   FreeAndNil( lcdsBuscaCampos );
   FreeAndNil( ldspBuscaCampos );
   FreeAndNil( lqryBuscaCampos );

   Result := llstTemp;
End;

Function ProcuraTipo( fTipoCampo: TFieldType; fDriverDestino : String = '' ): String;
Var lsTipoBD : String;
Begin
   Result := '';

   lsTipoBD := 'STANDARD';
   If Trim( fDriverDestino ) <> '' Then
      lsTipoBD := fDriverDestino;

   If fTipoCampo = ftString Then
      Result := 'VARCHAR'
   Else If fTipoCampo = ftWideString Then
     Result := 'VARCHAR'
   Else If fTipoCampo = ftSmallint Then
      Result := 'SMALLINT'
   Else If fTipoCampo = ftInteger Then
      Result := 'INTEGER'
   Else If fTipoCampo = ftFMTBcd Then
      Result := 'FLOAT'
   Else If fTipoCampo = ftWord Then
      Result := 'CHAR'
   Else If fTipoCampo = ftBoolean Then
      Result := 'LOGICAL'
   Else If fTipoCampo = ftFloat Then
      Result := 'FLOAT'
   Else If fTipoCampo = ftCurrency Then
      Result := 'FLOAT'
   Else If fTipoCampo = ftBCD Then
      Result := 'FLOAT'
   Else If fTipoCampo = ftSingle Then
      Result := 'FLOAT'
   Else If fTipoCampo = ftDate Then
      Result := 'DATE'
   Else If fTipoCampo = ftTime Then
      Result := 'DATE'
   Else If fTipoCampo = ftDateTime Then
      Result := 'DATE'
   Else If fTipoCampo = ftTimeStamp Then
      Result := 'DATE'
   Else If fTipoCampo = ftBytes Then
      Result := 'CHAR'
   Else If fTipoCampo = ftVarBytes Then
      Result := 'VARCHAR'
   Else If fTipoCampo = ftBlob Then
      Result := 'BLOB'
   Else If fTipoCampo = ftMemo Then
      Result := 'BLOB';

   If ( lsTipoBD = 'MSACCESS' ) Or ( lsTipoBD = 'ODA' ) Then
   Begin
      If fTipoCampo = ftBoolean Then
         Result := 'LOGICAL'
      Else If fTipoCampo = ftBlob Then
         Result := 'MEMO'
      Else If fTipoCampo = ftMemo Then
         Result := 'MEMO'
      Else If fTipoCampo = ftFmtMemo Then
         Result := 'MEMO'
      Else If fTipoCampo = ftParadoxOle Then
         Result := 'LONGBINARY'
      Else If fTipoCampo = ftDBaseOle Then
         Result := 'LONGBINARY'
      Else If fTipoCampo = ftTypedBinary Then
         Result := 'LONGBINARY';
   End
   Else If ( lsTipoBD = 'SQL SERVER' ) Then
   Begin
      If ( fTipoCampo = ftDateTime ) Or
         ( fTipoCampo = ftDate ) Or
         ( fTipoCampo = ftTimeStamp ) Or
         ( fTipoCampo = ftTime ) Then
         Result := 'DATETIME'
      Else If fTipoCampo = ftBoolean Then
         Result := 'INTEGER'
      Else If ( fTipoCampo = ftBlob ) Or
              ( fTipoCampo = ftMemo ) Or
              ( fTipoCampo = ftFmtMemo ) Then
         Result := 'TEXT'
      Else If fTipoCampo = ftParadoxOle Then
         Result := 'LONGBINARY'
      Else If fTipoCampo = ftDBaseOle Then
         Result := 'LONGBINARY'
      Else If fTipoCampo = ftTypedBinary Then
         Result := 'LONGBINARY';
   End;
End;

Function ConstruirSQL( fTipoSQL : TTipoSQL; fsTabela, fsCampos : String; fsRestricao  : String = ''; fsCodEmp  : String = '' ) : String;
Var lsCampos, lsParametros : String;
Begin
   If fTipoSQL = tsSelect Then
   Begin
      lsCampos := fsCampos;
      While Pos( ';', lsCampos ) > 0 Do
      Begin
         Insert( ', ', lsCampos, Pos( ';', lsCampos ) );
         Delete( lsCampos, Pos( ';', lsCampos ), 1 );
      End;
      fsRestricao := fsRestricao + ';';
      While Length( fsRestricao ) > 0 Do
      Begin
         lsParametros := lsParametros + ' And ' + Copy( fsRestricao, 1, Pos( ';', fsRestricao ) - 1 ) + '=:parW' + Copy( fsRestricao, 1, Pos( ';', fsRestricao ) - 1 );
         Delete( fsRestricao, 1, Pos( ';', fsRestricao ) );
      End;
      Delete( lsParametros, 1, 4 );
      Result := 'Select ' + lsCampos + ' FROM ' + fsTabela;
      If Length( lsParametros ) > 0 Then
         Result := 'Select ' + lsCampos + ' FROM ' + fsTabela + ' WHERE ' + lsParametros;
   End
   Else If fTipoSQL = tsInsert Then
   Begin
      lsCampos := fsCampos;
      While Pos( ';', lsCampos ) > 0 Do
      Begin
         Insert( ', ', lsCampos, Pos( ';', lsCampos ) );
         Delete( lsCampos, Pos( ';', lsCampos ), 1 );
      End;
      lsParametros := fsCampos;
      While Pos( ';', lsParametros ) > 0 Do
      Begin
         Insert( ', :par', lsParametros, Pos( ';', lsParametros ) );
         Delete( lsParametros, Pos( ';', lsParametros ), 1 );
      End;
      Result := 'Insert Into ' +  fsTabela + ' ( ' + lsCampos + ' ) Values ( :par' + lsParametros + ' )'
   End
   Else If fTipoSQL = tsUpdate Then
   Begin
      fsCampos := fsCampos + ';';
      While Length( fsCampos ) > 0 Do
      Begin
         lsCampos := lsCampos + ', ' + Copy( fsCampos, 1, Pos( ';', fsCampos ) - 1 ) + '=:par' + Copy( fsCampos, 1, Pos( ';', fsCampos ) - 1 );
         Delete( fsCampos, 1, Pos( ';', fsCampos ) );
      End;
      Delete( lsCampos, 1, 2 );

      fsRestricao := fsRestricao + ';';
      While Length( fsRestricao ) > 0 Do
      Begin
         lsParametros := lsParametros + ' And ' + Copy( fsRestricao, 1, Pos( ';', fsRestricao ) - 1 ) + '=:parW' + Copy( fsRestricao, 1, Pos( ';', fsRestricao ) - 1 );
         Delete( fsRestricao, 1, Pos( ';', fsRestricao ) );
      End;
      Delete( lsParametros, 1, 4 );
      Result := 'Update ' +  fsTabela + ' Set ' + lsCampos + ' Where ' + lsParametros;
   End;
End;

procedure LogBook( fOperador: String; fData: TDateTime; fHora, fOperacao: String );
var lqryModific : TSQLQuery;
    lsSistema   : String;
begin
   lqryModific := TSQLQuery.Create( Application );
   lqryModific.SQLConnection := dtmPrincipal.dbxPrincipal;
   lsSistema := 'A';  // Agencia
   Try
      Try
         lqryModific.SQL.Text := ConstruirSQL( tsInsert, 'T_LogBook',
                                 'Cod_Emp;Sistema;Data_Mov;Data_Cad;Hora;'+
                                 'Ocorrencia;Operador', '' );
         lqryModific.ParamByName( 'parCod_Emp' ).AsString        := gsCodEmp;
         lqryModific.ParamByName( 'parSistema' ).AsString        := lsSistema;
         lqryModific.ParamByName( 'parData_Mov' ).AsSQLTimeStamp := DateTimeToSQLTimeStamp( fData );
         lqryModific.ParamByName( 'parData_Cad' ).AsSQLTimeStamp := DateTimeToSQLTimeStamp( SoData( Now ) );
         lqryModific.ParamByName( 'parHora' ).AsString           := Copy( fHora, 1, 5);
         lqryModific.ParamByName( 'parOcorrencia' ).AsString     := Copy( fOperacao, 1, 100);
         lqryModific.ParamByName( 'parOperador' ).AsString       := gsOperador;
         lqryModific.ExecSQL;
      Except
         On E: Exception Do
            Raise E; // propagando a exceção
      End;
   Finally
      FreeAndNil( lqryModific );
   End;
end;

Function HoraServidor : String;
Var lqryHoraServidor : TSQLQuery;
    ldspHoraServidor : TDataSetProvider;
    lcdsHoraServidor : TClientDataSet;
Begin
   lqryHoraServidor               := TSQLQuery.Create( Application );
   lqryHoraServidor.SQLConnection := dtmPrincipal.dbxPrincipal;
   lqryHoraServidor.SQL.Text      := 'Select cast( ''today'' as Date ) as Hoje, '+
                                     '       cast( ''yesterday'' as Date ) as Ontem, '+
                                     '       cast( ''tomorrow'' as Date ) as Amanha, '+
                                     '       cast( ''now'' as Date ) as Data, '+
                                     '       current_timestamp as Hora '+
                                     'From rdb$database';

   ldspHoraServidor         := TDataSetProvider.Create( Application );
   ldspHoraServidor.DataSet := lqryHoraServidor;
   ldspHoraServidor.Name    := 'ldspHoraServidor';

   lcdsHoraServidor              := TClientDataSet.Create( Application );
   lcdsHoraServidor.ProviderName := ldspHoraServidor.Name;
   lcdsHoraServidor.Open;
   Result := FormatDateTime( 'hh:mm:ss', lcdsHoraServidor.FieldByName('Hora').AsDateTime );
   FreeAndNil( lcdsHoraServidor );
   FreeAndNil( ldspHoraServidor );
   FreeAndNil( lqryHoraServidor );
End;

Function SoData( fData: TDateTime; fDataStr: String = '' ): TDate;
Begin
   Try
      Result := StrToDate( FormatDateTime( 'dd/mm/yyyy', fData ) );

      If Trim ( fDataStr ) <> '' Then // Se a data for em String...
      Begin
         If Length( Trim( fDataStr ) ) = 8 Then
         Begin
            Insert( Copy( FormatDateTime( 'dd/mm/yyyy',  Date ), 7, 2), fDataStr, 7);
            Result := StrToDate( fDataStr );
         End
         Else If Length( Trim( fDataStr ) ) = 19 Then
            Result := StrToDate( Copy( fDataStr, 1, 10 ) )
         Else If Length(Trim( fDataStr ) ) = 17 Then
            Result := StrToDate( Copy( fDataStr, 1, 8 ) );
         // -> Provocando o Erro
         If ( Length( Trim( fDataStr ) ) <> 8 ) And ( Length( Trim( fDataStr ) ) <> 10 ) And
            ( Length( Trim( fDataStr ) ) <> 17 ) And ( Length( Trim( fDataStr ) ) <> 19 ) Then
         Begin
            Result := StrToDate( '' );
            Exit;
         End;
         // <- Provocando o Erro
      End;
   Except
      On E: Exception Do
      Begin
         MessageDlg('Não foi possível converter a data ('+E.Message+')', mtError, [ mbOk ], 0);
         Result :=Date;
      End;
   End;
End;

Function EnviarEmail(const De, Para, Assunto, Texto, Arquivo: string; Confirma: Boolean): integer;
var Msg: TMapiMessage;
    lpSender, lpRecepient: TMapiRecipDesc;
    FileAttach: TMapiFileDesc;
    SM: TFNMapiSendMail;
    MAPIModule: HModule;
    Flags: Cardinal;
begin
   // cria propriedades da mensagem
   FillChar(Msg, SizeOf(Msg), 0);
   with Msg do
   begin
    if (Assunto <> '') then
      lpszSubject := PAnsiChar(Assunto);

    if (Texto <> '') then
      lpszNoteText := PAnsiChar(Texto);

    // remetente
    if (De <> '') then
    begin
     lpSender.ulRecipClass := MAPI_ORIG;
     lpSender.lpszName := PAnsiChar(De);
     lpSender.lpszAddress := PAnsiChar(De);
     lpSender.ulReserved := 0;
     lpSender.ulEIDSize := 0;
     lpSender.lpEntryID := nil;
     lpOriginator := @lpSender;
    end;

    // destinatário
    if (Para <> '') then
    begin
     lpRecepient.ulRecipClass := MAPI_TO;
     lpRecepient.lpszName := PAnsiChar(Para);
     lpRecepient.lpszAddress := PAnsiChar(Para);
     lpRecepient.ulReserved := 0;
     lpRecepient.ulEIDSize := 0;
     lpRecepient.lpEntryID := nil;
     nRecipCount := 1;
     lpRecips := @lpRecepient;
    end
    else
     lpRecips := nil;

    // arquivo anexo
    if (Arquivo = '') then
    begin
     nFileCount := 0;
     lpFiles := nil;
    end
    else
    begin
     FillChar(FileAttach, SizeOf(FileAttach), 0);
     FileAttach.nPosition := Cardinal($FFFFFFFF);
     FileAttach.lpszPathName := PAnsiChar(Arquivo);
     nFileCount := 1;
     lpFiles := @FileAttach;
    end;
    end;

    // carrega dll e o método para envio do email
    MAPIModule := LoadLibrary(PChar(MAPIDLL));
    if MAPIModule = 0 then
     Result := -1
    else
     try
      if Confirma then
        Flags := MAPI_DIALOG or MAPI_LOGON_UI
      else
        Flags := 0;
        @SM := GetProcAddress(MAPIModule, 'MAPISendMail');
        if @SM <> nil then
          Result := SM(0, Application.Handle, Msg, Flags,0)
        else
          Result := 1;
     finally
      FreeLibrary(MAPIModule);
   end;
end;

{ TEmail }

constructor TEmail.Create;
begin
   Self.TipodeAutenticacao := satNone;
   Self.PortaSMTP          := 25;
end;

function TEmail.EnviarEmail: integer;
var lMsg         : TMapiMessage;
    lpSender     : TMapiRecipDesc;
    lpRecepient  : TMapiRecipDesc;
    lFileAttach  : TMapiFileDesc;
    lSM          : TFNMapiSendMail;
    lMAPIModule  : HModule;
    lcFlags      : Cardinal;
begin
   // cria propriedades da mensagem
   FillChar( lMsg, SizeOf( lMsg ), 0);
   With lMsg Do
   Begin
      If Self.Assunto <> '' Then
         lpszSubject := PAnsiChar( Self.Assunto );

      If Self.Texto <> '' Then
         lpszNoteText := PAnsiChar( Self.Texto );

      // remetente
      If Self.De <> '' Then
      Begin
         lpSender.ulRecipClass := MAPI_ORIG;
         lpSender.lpszName     := PAnsiChar( Self.De );
         lpSender.lpszAddress  := PAnsiChar( Self.De );
         lpSender.ulReserved   := 0;
         lpSender.ulEIDSize    := 0;
         lpSender.lpEntryID    := Nil;
         lpOriginator          := @lpSender;
      End;

      // destinatário
      If Self.Para <> '' Then
      Begin
         lpRecepient.ulRecipClass := MAPI_TO;
         lpRecepient.lpszName     := PAnsiChar( Self.Para );
         lpRecepient.lpszAddress  := PAnsiChar( Self.Para );
         lpRecepient.ulReserved   := 0;
         lpRecepient.ulEIDSize    := 0;
         lpRecepient.lpEntryID    := Nil;
         nRecipCount              := 1;
         lpRecips                 := @lpRecepient;
      End
      Else
         lpRecips := Nil;

      // arquivo anexo
      If Trim( Self.Anexos ) = '' Then
      Begin
         nFileCount := 0;
         lpFiles := Nil;
      End
      Else
      Begin
         FillChar( lFileAttach, SizeOf( lFileAttach ), 0 );
         lFileAttach.nPosition    := Cardinal( $FFFFFFFF );
         lFileAttach.lpszPathName := PAnsiChar( Self.Anexos );
         nFileCount := 1;
         lpFiles := @lFileAttach;
      End;
   end;

   // carrega dll e o método para envio do email
   lMAPIModule := LoadLibrary( PChar( MAPIDLL ) );
   If lMAPIModule = 0 Then
      Result := -1
   Else
   Begin
      Try
       If Self.ConfirmaLeitura Then
         lcFlags := MAPI_DIALOG or MAPI_LOGON_UI
       Else
         lcFlags := 0;
         @lSM := GetProcAddress( lMAPIModule, 'MAPISendMail' );
         If @lSM <> Nil Then
            Result := lSM( 0, Application.Handle, lMsg, lcFlags, 0 )
         Else
            Result := 1;
      Finally
         FreeLibrary( lMAPIModule );
      End;
   End;
end;

function TEmail.Indy_EnviarEmail: Boolean;
var lidMessage        : TIdMessage;
    lPOP3             : TIdPOP3;
    lSMTP             : TIdSMTP;
    lUserPassProvider : TIdUserPassProvider;
    lIdSASLLogin      : TIdSASLLogin;
    //lIdAttachment     : TIdAttachment;
    lsAnexos          : String;
begin
   Indy_EnviarEmail := False;

   lidMessage := TIdMessage.Create( Nil );
   Try
      // ...ajusta remetente, destinatário, etc da mensagem...
      lidMessage.From.Name                 := 'Setor de Reserva';
      lidMessage.From.Address              := Self.De;
      lidMessage.Sender.Name               := lidMessage.From.Name;
      lidMessage.Sender.Address            := lidMessage.From.Address;
      lidMessage.Recipients.EMailAddresses := Self.Para;
      lidMessage.CCList.EMailAddresses     := '';
      lidMessage.BccList.EMailAddresses    := '';
      lidMessage.Subject                   := Self.Assunto;
      lidMessage.Body.Text                 := Self.Texto;
      lidMessage.Priority                  := mpNormal;

      // conecta com o servidor POP3
      // alguns provedores exigem isso
      lPOP3 := TIdPOP3.Create( Nil );
      Try
         lPOP3.Host     := Self.ServidorPOP3;
         lPOP3.Username := Self.UsuarioPOP3;
         lPOP3.Password := Self.SenhaPOP3;
         //lPOP3.Connect;
         Try
            lSMTP             := TIdSMTP.Create( Nil );
            lUserPassProvider := TIdUserPassProvider.Create( Nil );
            Try
               lSMTP.Host := Self.ServidorSMTP;
               lSMTP.Port := Self.PortaSMTP;

               // alguns servidores SMTP exigem login
               lSMTP.AuthType := Self.TipodeAutenticacao; // atSASL;
               lUserPassProvider.Username := Self.UsuarioSMTP;
               lUserPassProvider.Password := Self.SenhaSMTP;

               Case lSMTP.AuthType Of
                  satDefault :
                  Begin
                     lSMTP.UserName := Self.UsuarioSMTP;
                     lSMTP.Password := Self.SenhaSMTP;
                  End;
                  satSASL :
                  Begin
                     lIdSASLLogin := TIdSASLLogin.Create( Nil );
                     lSMTP.SASLMechanisms.Add.SASL := lIdSASLLogin;
                  End;
               End;

               lsAnexos := Trim( Self.Anexos );
               If lsAnexos <> '' Then
               Begin
                  If Copy( lsAnexos, 1, Length( lsAnexos ) ) <> ';' Then
                     lsAnexos := Trim( lsAnexos ) + ';';

                  While Pos( ';', lsAnexos ) > 0 Do
                  Begin
                     TIdAttachmentFile.Create( lIdMessage.MessageParts, Copy( lsAnexos, 1, Pos( ';', lsAnexos ) - 1 ) );
                     //TIdAttachment.Create( lidMessage.MessageParts, Copy( lsAnexos, 1, Pos( ';', lsAnexos ) - 1 ) );

                     Delete( lsAnexos, 1, Pos( ';', lsAnexos ) );
                  End;
               End;

               Try
                  lSMTP.Connect;
               Except
                  On E: Exception Do
                  Begin
//                     frmMenu.MSNPopUp.Title := 'Aviso';
//                     frmMenu.MSNPopUp.Text  := 'Não foi possível conectar ao servidor SMTP( ' + Self.ServidorSMTP + ' )! ' + E.Message + ' ' + Self.Texto;
//                     frmMenu.MSNPopUp.ShowPopUp;
                     MessageDlg( 'Não foi possível realizar o envio do Email( Indy )! ' + E.Message, mtError, [ mbOk ], 0 );
                     Exit;
                  End;
               End;

               Try
                 lSMTP.Send( lidMessage );
               Except
                  On E: Exception Do
                  Begin
//                     frmMenu.MSNPopUp.Title := 'Aviso';
//                     frmMenu.MSNPopUp.Text  := 'Não foi possível realizar o envio do Email( Indy )! ' + E.Message + ' ' + Self.Texto;
//                     frmMenu.MSNPopUp.ShowPopUp;
                     MessageDlg( 'Não foi possível realizar o envio do Email( Indy )! ' + E.Message, mtError, [ mbOk ], 0 );
                     Exit;
                  End;
               End;
            Finally
               If lSMTP.AuthType = satSASL Then
                  FreeAndNil( lIdSASLLogin );

               //If Trim( Self.Anexos ) <> '' Then
               //   FreeAndNil( lIdAttachment );

               If lSMTP.Connected then
                  lSMTP.Disconnect;
               FreeAndNil( lSMTP );

               FreeAndNil( lUserPassProvider );
            End;
         Finally
            If lPOP3.Connected Then
               lPOP3.Disconnect;
         End;
      Finally
         FreeAndNil( lPOP3 );
      End;
   Finally
      FreeAndNil( lidMessage );
   End;

   Indy_EnviarEmail := True;
end;

procedure TEmail.SetAnexos(const Value: String);
begin
   FAnexos := Trim( Value );
end;

procedure TEmail.SetAssunto(const Value: String);
begin
   FAssunto := Trim( Value );
end;

procedure TEmail.SetConfirmaLeitura(const Value: Boolean);
begin
   FConfirmaLeitura := Value;
end;

procedure TEmail.SetDe(const Value: String);
begin
   FDe := Trim( Value );
end;

procedure TEmail.SetPara(const Value: String);
begin
   FPara := Trim( Value );
end;

procedure TEmail.SetPortaSMTP(const Value: Integer);
begin
  FPortaSMTP := Value;
end;

procedure TEmail.Setrequerloginsmtp(const Value: Boolean);
begin
  Frequerloginsmtp := Value;
end;

procedure TEmail.SetSenhaPOP3(const Value: String);
begin
   FSenhaPOP3 := Trim( Value );
end;

procedure TEmail.SetSenhaSMTP(const Value: String);
begin
   FSenhaSMTP := Value;
end;

procedure TEmail.SetServidorPOP3(const Value: String);
begin
   FServidorPOP3 := Trim( Value );
end;

procedure TEmail.SetServidorSMTP(const Value: String);
begin
   FServidorSMTP := Trim( Value );
end;

procedure TEmail.SetTexto(const Value: String);
begin
   FTexto := Trim( Value );
end;

procedure TEmail.SetTipodeAutenticacao(const Value: TIdSMTPAuthenticationType);
begin
   FTipodeAutenticacao := Value;
end;

procedure TEmail.SetUsuarioPOP3(const Value: String);
begin
   FUsuarioPOP3 := Value;
end;

procedure TEmail.SetUsuarioSMTP(const Value: String);
begin
   FUsuarioSMTP := Value;
end;

function ExcluirTriggersDependentes( const proSQLConnection : TSQLConnection; const prsObjeto : String; fProgresso: TProgressBar = Nil; fObject : TObject = Nil ) : Boolean;
var lqryTriggers : TSQLQuery;
    ldspTriggers : TDataSetProvider;
    lcdsTriggers : TClientDataSet;
Begin
   ExcluirTriggersDependentes := False;

   lqryTriggers := TSQLQuery.Create( Application );
   ldspTriggers := TDataSetProvider.Create( Application );
   lcdsTriggers := TClientDataSet.Create( Application );
   Try
      lqryTriggers.Close;
      lqryTriggers.SQLConnection := proSQLConnection;
      lqryTriggers.Params.Clear;
      lqryTriggers.SQL.Text     := 'select * from ( ' +
                                       '   select ''Trigger'', rdb$trigger_name from rdb$triggers ' +
                                       ' ) (type, name) ' +
                                       'where exists ' +
                                       '   (select * from rdb$dependencies ' +
                                       '    where rdb$dependent_name = name and rdb$depended_on_name=:parrdb$depended_on_name )';
      lqryTriggers.ParamByName( 'parRDB$Depended_On_Name' ).AsString := prsObjeto;

      ldspTriggers.DataSet := lqryTriggers;
      ldspTriggers.Name    := 'ldspTriggers';

      lcdsTriggers.Close;
      lcdsTriggers.ProviderName := ldspTriggers.Name;
      lcdsTriggers.Open;
      While NOT lcdsTriggers.EOF Do
      Begin
         ExcluirTriggersDependentes := True;

         Try
            lqryTriggers.Close;
            lqryTriggers.SQLConnection := proSQLConnection;
            lqryTriggers.Params.Clear;
            lqryTriggers.SQL.Text := 'DROP ' + Trim( lcdsTriggers.FieldByName( 'Type' ).AsString ) + ' ' + Trim( lcdsTriggers.FieldByName( 'Name' ).AsString );
            lqryTriggers.ExecSQL;
         Except
            On E: Exception Do
            Begin
               MessageDlg( 'Não foi possível excluir a triggers "' + Trim( lcdsTriggers.FieldByName( 'Name' ).AsString ) + '" de "' + prsObjeto + '"! ' + E.Message, mtError, [ mbOk ], 0 );
               Exit;
            End;
         End;
         lcdsTriggers.Next;
      End;
      lcdsTriggers.Close;
   Finally
      lcdsTriggers.Close;
      FreeAndNil( lcdsTriggers );

      FreeAndNil( ldspTriggers );

      lqryTriggers.Close;
      FreeAndNil( lqryTriggers );
   End;
End;

Function CaixaMensagem( vMensagem: AnsiString; vFigura: TCxDlgTipo; vBotoes: TCxDlgBotoes; vFoco: Integer ): Boolean;
var I          : Word;
    vStringTemp: string;
Begin
   Result := False;
   FrmMensagens := TFrmMensagens.Create(Nil);
   FrmMensagens.Refresh;
   With FrmMensagens Do
   Begin
     // Mensagens
     If Pos(Chr(13), vMensagem)>0 Then // Se tiver ENTER
     Begin
       While Pos(Chr(13), vMensagem)>0 Do
       Begin
         Memo1.Lines.Add(Copy(vMensagem, 1, Pos(Chr(13), vMensagem)));
         vStringTemp := vMensagem;
         Delete(vStringTemp, 1, Pos(Chr(13), vMensagem));
         vMensagem   := vStringTemp;
       End;
       Memo1.Lines.Add(vMensagem);
       If (Memo1.Lines.Count = 1) Or (Memo1.Lines.Count = 2) Then
       Begin
         For I := Memo1.Lines.Count DownTo 0 Do
           Memo1.Lines[I] := Memo1.Lines[I-1];
         Memo1.Lines[0]   := '';
       End;
     End
     Else // Se não tiver ENTER
     Begin
       Memo1.Lines.Add(vMensagem);
       If (Memo1.Lines.Count=1) Or (Memo1.Lines.Count=2) Then
       Begin
         Memo1.Clear;
         Memo1.Lines.Add('');
         Memo1.Lines.Add(vMensagem);
       End;
     End;

     // Tipos de Avisos
     ImgAviso.Visible    := False;
     AnimateErro.Visible := False;
     ImgInforma.Visible  := False;
     ImgConfirma.Visible := False;
     ImgPessoal.Visible  := False;
     ImgTimer.Visible    := False;
     If vFigura = ctAVISO Then
     Begin
        FrmMensagens.Caption:='Caixa de Aviso';
        ImgAviso.Visible:=True;
     End
     Else If vFigura = ctERRO Then
     Begin

     End
     Else If vFigura = ctINFORMA Then
     Begin
        FrmMensagens.Caption := 'Caixa Informativa';
        ImgInforma.Visible   := True;
     End
     Else If vFigura = ctCONFIRMA Then
     Begin
        FrmMensagens.Caption := 'Caixa de pedido de confirmação';
        ImgConfirma.Visible  := True;
     End
     Else If vFigura = ctPESSOAL Then
     Begin
        {FrmMensagens.Caption := 'Caixa de Mensagem';
        ImgPessoal.Visible   := True;
        BtnOk.Caption := '&' + Copy( vBotoes, 1, Pos( ',', vBotoes ) - 1 );
        BtnOk.Glyph.Assign(Nil);
        BtnCancela.Glyph.Assign(Nil);
        If Pos( ', ', vBotoes ) = 0 Then
          BtnCancela.Caption := '&' + Copy(vBotoes, Pos(',', vBotoes) + 1, Length(vBotoes)-Pos(',', vBotoes) + 1)
        Else
          BtnCancela.Caption := '&' + Copy(vBotoes, Pos(',', vBotoes)+2, Length(vBotoes)-Pos(',', vBotoes)+3);}
     End
     Else If vFigura = ctTIMER Then
     Begin
        FrmMensagens.Caption              := 'Caixa com timer';
        FrmMensagens.Timer1.Enabled       := True;
        FrmMensagens.ProgressBar1.Visible := True;
        FrmMensagens.Timer2.Enabled       := True;
        ImgTimer.Visible:=True;
     End
     Else
        MessageDlg('Falha interna! Caracterizada como CP', mtError, [mbOk], 0);

     // Tipos de Botões
     If vBotoes = [ cbOK ] Then
     Begin
        BtnCancela.Visible := False;
        BtnOk.Left         := Centraliza( FrmMensagens.Width, BtnOk.Width );
     End
     Else If vBotoes = [ cbOkCancela ] Then
     Begin
        LblFoco.Caption := IntToStr( vFoco );
        BtnOk.Left      := Round( FrmMensagens.Width / 2 ) - BtnOk.Width - 5;
        BtnCancela.Left := Round( FrmMensagens.Width / 2 ) + 5;
     End
     Else If vBotoes = [ cbSimNao ] Then
     Begin
        LblFoco.Caption    := IntToStr( vFoco );
        BtnOk.Caption      := '&Sim';
        BtnCancela.Caption := '&Não';
        BtnOk.Left         := Round( FrmMensagens.Width / 2 ) - BtnOk.Width - 5;
        BtnCancela.Left    := Round( FrmMensagens.Width / 2 ) + 5;
     End
     Else
        MessageDlg('Falha interna no formulário de mensagens personalizadas! '+
                   'Caracterizada como CP', mtError, [mbOk], 0);
     Update;
     Refresh;
     ShowModal;
   End;
   If ( pRespMsg = '&OK' ) Or ( pRespMsg = '&SIM' ) Then
     Result := True;
   FrmMensagens.Free;
End;

Function Centraliza( fTamFundo, fTamObjeto : Integer ) : Integer;
Begin
   Result := Round(fTamFundo/2) - Round(fTamObjeto/2);
End;

Procedure ListaPeriodo( fComponente1: TComponent; fComponente2: TComponent; fItem: Integer; fData : TDateTime );
Var xMeses : Array[ 1..12 ] Of  Integer;
    DiaIni, DiaFim : TDateTime;
    nVar, nVar1    : Integer;
begin
   If fItem < 0 Then
   Begin
      CaixaMensagem( 'Nenhum item foi selecionado!', ctInforma, [ cbOk ], 0 );
      Exit;
   End;
   xMeses[ 1] := 31;
   xMeses[ 2] := 28;
   If StrToInt( FormatDateTime( 'yyyy', fData ) ) Mod 4 = 0 Then
      xMeses[2] := 29;
   xMeses[ 3] := 31;
   xMeses[ 4] := 30;
   xMeses[ 5] := 31;
   xMeses[ 6] := 30;
   xMeses[ 7] := 31;
   xMeses[ 8] := 31;
   xMeses[ 9] := 30;
   xMeses[10] := 31;
   xMeses[11] := 30;
   xMeses[12] := 31;

   DiaIni := StrToDate( '01/' + FormatDateTime( 'mm/yyyy', fData ) );
   DiaFim := StrToDate( IntToStr( xMeses[ StrToInt( FormatDateTime( 'mm', fData ) ) ] ) + FormatDateTime( '/mm/yyyy', fData ) );

   Case fItem Of
   0:Begin // Nenhum
        ( fComponente1 as TCustomEdit ).Text := '01/01/1901';
        ( fComponente2 as TCustomEdit ).Text := '31/12/2200';
     End;
   1:Begin // Ontem
        ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData - 1 );
        ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData - 1 );
     End;
   2:Begin // Hoje
        ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData );
        ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData );
     End;
   3:Begin // Amanhã
        ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData + 1 );
        ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData + 1 );
     End;
   4:Begin // Semana Anterior
        ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData -7 );
        While DayOfWeek( StrToDate( ( fComponente1 as TCustomEdit ).Text ) ) <> 1 Do
           ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', StrToDate( ( fComponente1 as TCustomEdit ).Text ) - 1 );
        ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', StrToDate( ( fComponente1 as TCustomEdit ).Text )+6);
     End;
   5:Begin // Esta semana
        ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData );
        While DayOfWeek (StrToDate( ( fComponente1 as TCustomEdit ).Text )) <> 1 Do
           ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', StrToDate( ( fComponente1 as TCustomEdit ).Text ) - 1 );
        ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', StrToDate( ( fComponente1 as TCustomEdit ).Text )+6);
     End;
   6:Begin // Próxima Semana
        ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData + 7 );
        While DayOfWeek (StrToDate( ( fComponente1 as TCustomEdit ).Text )) <> 1 Do
           ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', StrToDate( ( fComponente1 as TCustomEdit ).Text ) - 1 );
        ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', StrToDate( ( fComponente1 as TCustomEdit ).Text )+6);
     End;
   7:Begin // Quinzena anterior
        ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData - 15 );
        ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData - 15 );
        If FormatDateTime( 'dd', fData ) <= '15' Then
        Begin
           While Copy( ( fComponente1 as TCustomEdit ).Text, 1, 2 ) <> '16' Do
              ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', StrToDate ( ( fComponente1 as TCustomEdit ).Text ) - 1 );
           nVar := StrToInt( Copy( ( fComponente2 as TCustomEdit ).Text, 4, 2 ) );
           While Copy( ( fComponente2 as TCustomEdit ).Text, 1 , 2 ) <> Trim( IntToStr( xMeses[ nVar] ) ) Do
              ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', StrToDate ( ( fComponente2 as TCustomEdit ).Text ) + 1 );
        End;
        If FormatDateTime( 'dd', fData ) > '15' Then
        Begin
           While Copy( ( fComponente1 as TCustomEdit ).Text, 1, 2 ) <> '01' Do
              ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', StrToDate ( ( fComponente1 as TCustomEdit ).Text ) - 1 );
           While Copy( ( fComponente2 as TCustomEdit ).Text, 1, 2 ) <> '15' Do
              ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', StrToDate ( ( fComponente2 as TCustomEdit ).Text ) + 1 );
        End;
     End;
   8:Begin // Esta Quinzena
        ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData );
        ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData );
        If FormatDateTime( 'dd', fData ) <= '15' Then
        Begin
           While Copy( ( fComponente1 as TCustomEdit ).Text, 1, 2 ) <> '01' Do
              ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', StrToDate( ( fComponente1 as TCustomEdit ).Text ) - 1 );
           While Copy( ( fComponente2 as TCustomEdit ).Text, 1, 2 ) <> '15' Do
              ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', StrToDate( ( fComponente2 as TCustomEdit ).Text ) + 1 );
        End;
        If FormatDateTime( 'dd', fData ) > '15' Then
        Begin
           While Copy( ( fComponente1 as TCustomEdit ).Text, 1, 2 ) <> '16' Do
              ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', StrToDate( ( fComponente1 as TCustomEdit ).Text ) - 1 );
           nVar := StrToInt( FormatDateTime( 'mm', fData ) );
           While Copy( ( fComponente2 as TCustomEdit ).Text, 1, 2 ) <> Trim( IntToStr (xMeses[nVar])) Do
              ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', StrToDate ( ( fComponente2 as TCustomEdit ).Text ) + 1 );
        End;
     End;
   9:Begin // Próxima Quinzena
        ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData + 15);
        ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData + 15);
        If FormatDateTime( 'dd', fData ) <= '15' Then
        Begin
           While Copy( ( fComponente1 as TCustomEdit ).Text, 1, 2 ) <> '16' Do
              ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', StrToDate( ( fComponente1 as TCustomEdit ).Text ) - 1 );
           nVar := StrToInt( Copy( ( fComponente2 as TCustomEdit ).Text, 4, 2 ) );
           While Copy( ( fComponente2 as TCustomEdit ).Text, 1, 2 ) <> Trim( IntToStr( xMeses[ nVar ] ) ) Do
              ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', StrToDate( ( fComponente2 as TCustomEdit ).Text ) + 1 );
        End;
        If FormatDateTime( 'dd', fData ) > '15' Then
        Begin
           While Copy( ( fComponente1 as TCustomEdit ).Text, 1, 2 ) <> '01' Do
              ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', StrToDate( ( fComponente1 as TCustomEdit ).Text ) - 1 );
           While Copy( ( fComponente2 as TCustomEdit ).Text, 1, 2 ) <> '15' Do
              ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', StrToDate( ( fComponente2 as TCustomEdit ).Text ) + 1 );
        End;
     End;
   10:Begin // Nos Últimos 15 dias
         ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', fData - 15);
         ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', fData );
      End;
   11:Begin // Nos Próximos 15 dias
         ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', fData );
         ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', fData + 15 );
      End;
   12:Begin // Nos Últimos e Próximos 15 dias
         ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', fData - 15 );
         ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', fData + 15 );
      End;
   13:Begin // Mês Anterior
         ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', DiaIni - 1 );
         ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', DiaIni - 1 );
         While Copy( ( fComponente1 as TCustomEdit ).Text, 1, 2 ) <> '01' Do
            ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', StrToDate( ( fComponente1 as TCustomEdit ).Text ) - 1 );
      End;
   14:Begin // Este Mês
         ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', DiaIni );
         ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', DiaFim );
      End;
   15:Begin // Próximo Mês
         ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', DiaFim + 1 );
         ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', DiaFim + 28 );
         nVar := StrToInt( Copy( ( fComponente2 as TCustomEdit ).Text, 4, 2 ) );
         While Copy( ( fComponente2 as TCustomEdit ).Text, 1, 2 ) <> Trim( IntToStr( xMeses[ nVar ] ) ) Do
            ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', StrToDate( ( fComponente2 as TCustomEdit ).Text ) + 1 );
      End;
   16:Begin // Nos Últimos 30 dias
         ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', fData - 30 );
         ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', fData );
      End;
   17:Begin // Nos Próximos 30 dias
         ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', fData );
         ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', fData + 30 );
      End;
   18:Begin // Nos Últimos e Próximos 30 dias
         ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', fData - 30 );
         ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', fData + 30 );
      End;
   19:Begin // Nos Últimos 45 dias
         ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData - 45 );
         ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData );
      End;
   20:Begin // Nos Próximos 45 dias
         ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData );
         ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData + 45 );
      End;
   21:Begin // Nos Últimos e Próximos 45 dias
         ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', fData - 45 );
         ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', fData + 45 );
      End;
   22:Begin // Nos Últimos 60 dias
         ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData - 60 );
         ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData );
      End;
   23:Begin // Nos Próximos 60 dias
         ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData );
         ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData + 60 );
      End;
   24:Begin // Nos Últimos e Próximos 60 dias
         ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', fData - 60 );
         ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', fData + 60 );
      End;
   25:Begin // Trimestre Anterior
         nVar1 := StrToInt( FormatDateTime( 'mm', fData ) );
         nVar  := StrToInt( FormatDateTime( 'yyyy', fData ) ) - 1;
         Case nVar1 Of
         1..3:Begin
                 ( fComponente1 as TCustomEdit ).Text := '01/10/' + Trim( IntToStr( nVar ) );
                 ( fComponente2 as TCustomEdit ).Text := '31/12/' + Trim( IntToStr( nVar ) );
              End;
         4..6:Begin
                 ( fComponente1 as TCustomEdit ).Text := '01/01/' + FormatDateTime( 'yyyy', fData );
                 ( fComponente2 as TCustomEdit ).Text := '31/03/' + FormatDateTime( 'yyyy', fData );
              End;
         7..9:Begin
                 ( fComponente1 as TCustomEdit ).Text := '01/04/' + FormatDateTime( 'yyyy', fData );
                 ( fComponente2 as TCustomEdit ).Text := '30/06/' + FormatDateTime( 'yyyy', fData );
              End;
         10..12:Begin
                   ( fComponente1 as TCustomEdit ).Text := '01/07/' + FormatDateTime( 'yyyy', fData );
                   ( fComponente2 as TCustomEdit ).Text := '30/09/' + FormatDateTime( 'yyyy', fData );
                End;
         End;
      End;
   26:Begin // Neste Trimestre
         nVar1 := StrToInt( FormatDateTime( 'mm', fData ) );
         Case nVar1 Of
         1..3:Begin
                 ( fComponente1 as TCustomEdit ).Text := '01/01/' + FormatDateTime( 'yyyy', fData );
                 ( fComponente2 as TCustomEdit ).Text := '31/03/' + FormatDateTime( 'yyyy', fData );
              End;
         4..6:Begin
                 ( fComponente1 as TCustomEdit ).Text := '01/04/' + FormatDateTime( 'yyyy', fData );
                 ( fComponente2 as TCustomEdit ).Text := '30/06/' + FormatDateTime( 'yyyy', fData );
              End;
         7..9:Begin
                 ( fComponente1 as TCustomEdit ).Text := '01/07/' + FormatDateTime( 'yyyy', fData );
                 ( fComponente2 as TCustomEdit ).Text := '30/09/' + FormatDateTime( 'yyyy', fData );
              End;
         10..12:Begin
                   ( fComponente1 as TCustomEdit ).Text := '01/10/' + FormatDateTime( 'yyyy', fData );
                   ( fComponente2 as TCustomEdit ).Text := '31/12/' + FormatDateTime( 'yyyy', fData );
                End;
         End;
      End;
   27:Begin // Próximo Trimestre
         nVar1 := StrToInt( FormatDateTime( 'mm', fData ) );
         nVar  := StrToInt( FormatDateTime( 'yyyy', fData ) ) + 1;
         Case nVar1 Of
         1..3:Begin
                 ( fComponente1 as TCustomEdit ).Text := '01/04/' + FormatDateTime( 'yyyy', fData );
                 ( fComponente2 as TCustomEdit ).Text := '30/06/' + FormatDateTime( 'yyyy', fData );
              End;
         4..6:Begin
                 ( fComponente1 as TCustomEdit ).Text := '01/07/' + FormatDateTime( 'yyyy', fData );
                 ( fComponente2 as TCustomEdit ).Text := '30/09/' + FormatDateTime( 'yyyy', fData );
              End;
         7..9:Begin
                 ( fComponente1 as TCustomEdit ).Text := '01/10/' + FormatDateTime( 'yyyy', fData );
                 ( fComponente2 as TCustomEdit ).Text := '31/12/' + FormatDateTime( 'yyyy', fData );
              End;
         10..12:Begin
                 ( fComponente1 as TCustomEdit ).Text := '01/01/' + Trim( IntToStr( nVar ) );
                 ( fComponente2 as TCustomEdit ).Text := '31/03/' + Trim( IntToStr( nVar ) );
              End;
         End;
     End;
   28:Begin // Nos Últimos 90 dias
         ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData - 90 );
         ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData );
      End;
   29:Begin // Nos Próximos 90 dias
         ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData );
         ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData + 90 );
      End;
   30:Begin // Nos Últimos e Próximos 90 dias
         ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', fData - 90 );
         ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy', fData + 90 );
      End;
   31:Begin // Semestre Passado
         nVar1 := StrToInt( FormatDateTime( 'mm', fData ) );
         nVar  := StrToInt( FormatDateTime( 'yyyy', fData ) ) - 1;
         Case nVar1 Of
         1..6:Begin
                 ( fComponente1 as TCustomEdit ).Text := '01/07/' + Trim( IntToStr( nVar ) );
                 ( fComponente2 as TCustomEdit ).Text := '31/12/' + Trim( IntToStr( nVar ) );
              End;
         7..12:Begin
                 ( fComponente1 as TCustomEdit ).Text := '01/01/' + FormatDateTime( 'yyyy', fData );
                 ( fComponente2 as TCustomEdit ).Text := '30/06/' + FormatDateTime( 'yyyy', fData );
               End;
         End;
     End;
   32:Begin // Neste Semestre
         nVar1 := StrToInt( FormatDateTime( 'mm', fData ) );
         Case nVar1 Of
         1..6:Begin
                 ( fComponente1 as TCustomEdit ).Text := '01/01/' + FormatDateTime( 'yyyy', fData );
                 ( fComponente2 as TCustomEdit ).Text := '30/06/' + FormatDateTime( 'yyyy', fData );
              End;
         7..12:Begin
                  ( fComponente1 as TCustomEdit ).Text := '01/07/' + FormatDateTime( 'yyyy', fData );
                  ( fComponente2 as TCustomEdit ).Text := '31/12/' + FormatDateTime( 'yyyy', fData );
               End;
         End;
     End;
   33:Begin // Próximo Semestre
         nVar1 := StrToInt( FormatDateTime( 'mm', fData ) );
         nVar  := StrToInt( FormatDateTime( 'yyyy', fData ) ) + 1;
         Case nVar1 Of
         1..6:Begin
                 ( fComponente1 as TCustomEdit ).Text := '01/07/' + FormatDateTime( 'yyyy', fData );
                 ( fComponente2 as TCustomEdit ).Text := '31/12/' + FormatDateTime( 'yyyy', fData );
              End;
         7..12:Begin
                  ( fComponente1 as TCustomEdit ).Text := '01/01/' + Trim( IntToStr( nVar ) );
                  ( fComponente2 as TCustomEdit ).Text := '30/06/' + Trim( IntToStr( nVar ) );
               End;
         End;
     End;
   34:Begin // Nos Últimos 120 dias
         ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData - 120 );
         ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData );
      End;
   35:Begin // Nos Próximos 120 dias
         ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData );
         ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData + 120 );
      End;
   36:Begin // Nos Últimos e Próximos 120 dias
         ( fComponente1 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData - 120 );
         ( fComponente2 as TCustomEdit ).Text := FormatDateTime( 'dd/mm/yyyy',  fData + 120 );
      End;
   37:Begin // Ano Passado
         nVar := StrToInt( FormatDateTime( 'yyyy', fData ) ) - 1;
         ( fComponente1 as TCustomEdit ).Text := '01/01/' + Trim( IntToStr( nVar ) );
         ( fComponente2 as TCustomEdit ).Text := '31/12/' + Trim( IntToStr( nVar ) );
      End;
   38:Begin // Neste Ano
         ( fComponente1 as TCustomEdit ).Text := '01/01/' + FormatDateTime( 'yyyy', fData );
         ( fComponente2 as TCustomEdit ).Text := '31/12/' + FormatDateTime( 'yyyy', fData );
      End;
   39:Begin // Próximo Ano
         nVar := StrToInt( FormatDateTime( 'yyyy', fData ) ) + 1;
         ( fComponente1 as TCustomEdit ).Text := '01/01/' + Trim( IntToStr( nVar ) );
         ( fComponente2 as TCustomEdit ).Text := '31/12/' + Trim( IntToStr( nVar ) );
      End;
   End;
end;

Procedure ConfiguraRel( fNomeForm : String; fRelatorio : TObject; fCriarCabecalho : Boolean = True; fRDPrint : TRdPrint = Nil; fPagina : Integer = 1; fTipoCab: integer = 1 );
Var I: Word;
    lfrmForm : TForm;
    liCont   : Integer;
    liLinha  : Integer;
    lfFonte  : TFonte;

    lfrxBand : TfrxBand;
    lfrxPageHeader : TfrxPageHeader;
    liTop : Integer;
    lfrxPage : TfrxReportPage;
Begin
   lfrmForm := Nil;
   For liCont := 1 To Screen.FormCount Do
   Begin
      If AnsiUpperCase( Trim( Screen.Forms[ liCont - 1 ].Name ) ) = AnsiUpperCase( Trim( fNomeForm ) ) Then
         lfrmForm := Screen.Forms[ liCont - 1 ];
   End;

   If ( lfrmForm = Nil ) Or ( lfrmForm Is TForm = False ) Then
   Begin
      CaixaMensagem( 'Formulário não localizado para impressão de cabeçalho.', ctErro, [ cbOk ], 0 );
      Exit;
   End;

   If fRDPrint<>Nil Then
   Begin
      lfFonte := [Normal];
      Case fRDPrint.FonteTamanhoPadrao Of
         s05cpp : lfFonte := [Expandido];
         s10cpp : lfFonte := [Normal];
         s12cpp : lfFonte := [Comp12];
         s17cpp : lfFonte := [Comp17];
         s20cpp : lfFonte := [Comp20];
      end;

      {If fRDPrint.TamanhoQteColunas = 135 Then
         lfFonte := [ Comp17 ];}

      if fTipoCab = 1 then
      begin
         fRDPrint.ImpF( 01, 01, FormatDateTime( 'dd/mm/yyyy', Now )  + ' as ' + FormatDateTime('hh:mm:ss', Now ), lfFonte );
         fRDPrint.impC( 01, Round(fRDPrint.TamanhoQteColunas/2), 'GerHotel '+gsVerSis, lfFonte);
         fRDPrint.impD( 01, fRDPrint.TamanhoQteColunas, 'Pagina '+ IntToStr( fPagina ) , lfFonte);
         fRDPrint.ImpF( 02, 01, IncDigito( '=', '=', fRDPrint.TamanhoQteColunas, 0 ), lfFonte );
         fRDPrint.ImpC( 03, Round( fRDPrint.TamanhoQteColunas/2 ), gsNomeEmp , [ NEGRITO ] + lfFonte );
         //fRDPrint.ImpC( 04, Round( fRDPrint.TamanhoQteColunas/2 ), gsTituloRel , [ NEGRITO ] + lfFonte );
         fRDPrint.ImpC( 04, Round( fRDPrint.TamanhoQteColunas/2 ), gsTituloRel , lfFonte );
         fRDPrint.ImpC( 04, Round( fRDPrint.TamanhoQteColunas/2 ), gsTituloRel , lfFonte );
         fRDPrint.ImpC( 04, Round( fRDPrint.TamanhoQteColunas/2 ), gsTituloRel , lfFonte );
         If gsPeriodoRel = '' Then
         Begin
            fRDPrint.ImpF( 05, 01, IncDigito( '=', '=', fRDPrint.TamanhoQteColunas, 0 ), lfFonte );
         End
         Else
         Begin
            //fRDPrint.ImpC( 05, Round( fRDPrint.TamanhoQteColunas/2 ), gsPeriodoRel , [ NEGRITO ] + lfFonte );
            fRDPrint.ImpC( 05, Round( fRDPrint.TamanhoQteColunas/2 ), gsPeriodoRel , lfFonte );
            fRDPrint.ImpC( 05, Round( fRDPrint.TamanhoQteColunas/2 ), gsPeriodoRel , lfFonte );
            fRDPrint.ImpC( 05, Round( fRDPrint.TamanhoQteColunas/2 ), gsPeriodoRel , lfFonte );
            fRDPrint.ImpF( 06, 01, IncDigito( '=', '=', fRDPrint.TamanhoQteColunas, 0 ),  lfFonte );
         End
      End
      Else if fTipoCab = 2 then
      Begin
         liLinha := 1;
         fRDPrint.impF( liLinha, 001, FormatDateTime( 'dd/mm/yyyy', Now ) + ' as ' + FormatDateTime( 'hh:mm:ss', Now ) + ' Mov. ' + DateToStr( Now ), [ comp17 ] );
         fRDPrint.impC( liLinha, Round(fRDPrint.TamanhoQteColunas/2), 'GerHotel ' + gsVerSis , [ comp17 ] );
         fRDPrint.impD( liLinha, fRDPrint.TamanhoQteColunas, 'Pagina ' + IntToStr( fPagina ) , [ comp17 ] );
         liLinha := liLinha + 1;
         fRDPrint.Imp ( liLinha, 001, IncDigito( '=', '=', fRDPrint.TamanhoQteColunas, 0 ) );
         liLinha := liLinha + 1;
         fRDPrint.ImpC( liLinha, Round( fRDPrint.TamanhoQteColunas/2 ), gsNomeEmp , [ normal ] );
         liLinha := liLinha + 1;
         fRDPrint.ImpC( liLinha, Round( fRDPrint.TamanhoQteColunas/2 ), gsEnderecoEmp + ' ' + gsNumeroEmp + ' - ' + gsBairroEmp + ' - ' + gsCEPEmp, [ comp17 ]);
         liLinha := liLinha + 1;
         fRDPrint.ImpC( liLinha, Round( fRDPrint.TamanhoQteColunas/2 ), gsCidadeEmp + '/' + gsUFEmp + ' Telefone.: ' + gsTelefoneEmp + ' Fax.: ' + gsFaxEmp, [ comp17 ]);
         liLinha := liLinha + 1;
         fRDPrint.ImpC( liLinha, Round( fRDPrint.TamanhoQteColunas/2 ), 'C.N.P.J ' + gsCNPJCPFEmp + ' Ins.Estadual: ' + gsInscEmp, [ comp17 ]);
         liLinha := liLinha + 1;
         If Trim( gsTituloRel ) = '' Then
         begin
            fRDPrint.Imp ( liLinha, 001, IncDigito( '=', '=', fRDPrint.TamanhoQteColunas, 0 ) );
         end
         else
         begin
            fRDPrint.ImpC( liLinha, Round( fRDPrint.TamanhoQteColunas/2 ), gsTituloRel , [ comp17 ] );
            liLinha := liLinha + 1;
            If Trim( gsPeriodoRel ) <> '' Then
            Begin
               fRDPrint.ImpC( liLinha, Round( fRDPrint.TamanhoQteColunas/2 ), gsPeriodoRel , [ NEGRITO ] );
               liLinha := liLinha + 1;
               fRDPrint.Imp ( liLinha, 01, IncDigito( '=', '=', fRDPrint.TamanhoQteColunas, 0 ) );
            End
            Else
               fRDPrint.Imp ( liLinha, 01, IncDigito( '=', '=', fRDPrint.TamanhoQteColunas, 0 ) );
         end;
      End;
   End
   Else
   Begin
      If fRelatorio Is TfrxReport Then
      Begin
         lfrxPage := ( TfrxReport( fRelatorio ).Pages[ 1 ] As TfrxReportPage );
         For liCont := 1 To TfrxReport( fRelatorio ).PagesCount Do
         Begin
            If TfrxReport( fRelatorio ).Pages[ liCont ].Visible Then
            Begin
               lfrxPage := ( TfrxReport( fRelatorio ).Pages[ liCont ] As TfrxReportPage );
               Break;
            End;
         End;

         lfrxBand := lfrxPage.FindBand( TfrxPageHeader );
         If ( lfrxBand <> Nil ) And ( lfrxBand.Tag = 1 ) Then
            lfrxBand.Free;

         If lfrxPage.FindBand( TfrxPageHeader ) = Nil Then
         Begin
            lfrxBand := TfrxPageHeader.Create( lfrxPage );
            lfrxBand.CreateUniqueName;
            lfrxBand.Tag := 1;

            lfrxBand.Top    := 0;
            lfrxBand.Height := 50;

            liTop := 0;

             With TfrxMemoView.Create( lfrxBand ) Do
             Begin
                CreateUniqueName;
                Text      := '[Date] às [Time]'; // FormatDateTime( 'dd/mm/yyyy', Now ) + ' as ' + FormatDateTime( 'hh:mm:ss', Now );
                Width     := 100;
                Height    := 20;
                Top       := liTop;
                Left      := 0;
                Name      := 'bndDataHora';

                AutoWidth := True;
                Align := baNone;
             End;
             With TfrxMemoView.Create( lfrxBand ) Do
             Begin
                CreateUniqueName;
                Text      := 'Agência ' + gsVerSis;
                Width     := 150;
                Height    := 20;
                Top       := liTop;
                Left      := 150;
                Name      := 'bndSistema';

                AutoWidth := True;
                Align := baCenter;
             End;
             With TfrxMemoView.Create( lfrxBand ) Do
             Begin
                CreateUniqueName;
                Text      := 'Pagina [Page#]';
                Width     := 100;
                Height    := 20;
                Top       := liTop;
                Left      := 300;
                Name      := 'bndNumPagina';

                AutoWidth := True;
                Align := baRight;
             End;

             liTop := liTop + 21; // Pulando Linha

             With TfrxLineView.Create( lfrxBand ) Do
             Begin
                CreateUniqueName;
                Top    := liTop;
                Left   := 0;
                Width  := 100;
                Height := 10;
                Name      := 'bndSeparador1';

                Align := baWidth;
             End;

             liTop := liTop + 11; // Pulando Linha

             With TfrxMemoView.Create( lfrxBand ) Do
             Begin
                CreateUniqueName;
                Text      := gsNomeEmp;
                Width     := 100;
                Height    := 20;
                Top       := liTop;
                Left      := 0;
                Name      := 'bndNomeEmpresa';

                AutoWidth := True;
                Align := baCenter;
             End;

             liTop := liTop + 21; // Pulando Linha

             With TfrxMemoView.Create( lfrxBand ) Do
             Begin
                CreateUniqueName;
                Text      := gsTituloRel;
                Width     := 100;
                Height    := 20;
                Top       := liTop;
                Left      := 0;
                Name      := 'bndTitulo';

                AutoWidth := True;
                Align := baCenter;
             End;

             If gsPeriodoRel <> '' Then
             Begin
                liTop := liTop + 21; // Pulando Linha

                With TfrxMemoView.Create( lfrxBand ) Do
                Begin
                   CreateUniqueName;
                   Text      := gsPeriodoRel;
                   Width     := 100;
                   Height    := 20;
                   Top       := liTop;
                   Left      := 0;
                   Name      := 'bndPeriodo';

                   AutoWidth := True;
                   Align := baCenter;
                End;

               liTop := liTop + 21; // Pulando Linha

               With TfrxLineView.Create( lfrxBand ) Do
               Begin
                  CreateUniqueName;
                  Top    := liTop;
                  Left   := 0;
                  Width  := 100;
                  Height := 10;
                  Name   := 'bndSeparador2';

                  Align := baWidth;
               End;
            End;
            lfrxBand.Height := liTop + 10;
         End;
      End;
      gsTituloRel  := '';
      gsPeriodoRel := '';
   End;
End;

Function IncDigito(VlrString: String; Digito: String; Tamanho: Word; Lado: Word): String;
Var I : Word;
    lsVlrString: string;
Begin
   If Digito = '' Then
     Digito := ' ';
   lsVlrString := Trim(VlrString);
   If Length(VlrString) > Tamanho Then
     lsVlrString := Copy(lsVlrString, 1, Tamanho);
   I := 1;
   While Length(lsVlrString) < Tamanho Do
   Begin
     If Lado = 0 Then // Lado Direito
       lsVlrString:= DupeString(Digito, Tamanho - length(lsVlrString) ) + lsVlrString
       //lsVlrString:= Digito  + Trim(VlrString)
     else
     If Lado = 1 Then // Lado Esquerdo
        lsVlrString:= lsVlrString + DupeString(Digito, Tamanho - length(lsVlrString) )
      // lsVlrString:=lsVlrString + Digito
     else
     If Lado = 2 Then // Lado Centralizado
     Begin
       If ( I Mod 2 ) = 0 Then
         lsVlrString := Digito + lsVlrString
       Else
         lsVlrString := lsVlrString + Digito;
       I := I + 1;
     End;
   End;
   IncDigito :=lsVlrString;
End;
{
procedure CapturarDadosDaEmpresaEmUso( const prsCodigoEmpresa : String );
var loControllerEmpresa : TControllerEmpresa;
    loEmpresa : TEmpresa;
begin
   loControllerEmpresa := TControllerEmpresa.Create;
   try
     loEmpresa := loControllerEmpresa.BuscarPorCodigo( '001' );

     // -> Dados da Empresa Ativa
     gsNomeEmp      := loEmpresa.NomeFantasia;
     gsRazaoSocial  := loEmpresa.RazaoSocial;
     gsEnderecoEmp  := loEmpresa.Endereco;
     gsBairroEmp    := loEmpresa.Bairro;
     gsCidadeEmp    := loEmpresa.Cidade;
     gsUFEmp        := loEmpresa.Uf;
     gsCepEmp       := loEmpresa.CEP;
     gsCNPJCPFEmp   := loEmpresa.CnpjCpf;
     gsInscEmp      := loEmpresa.InscricaoEstadual;
     gsInscMunEmp   := loEmpresa.InscricaoMunicipal;
     gsTelefoneEmp  := loEmpresa.Telefone;
     gsFaxEmp       := loEmpresa.Fax;
     gsEmail        := loEmpresa.Email;
     // <- Dados da Empresa Ativa
   finally
      FreeAndNil( loControllerEmpresa );
      FreeAndNil( loEmpresa );
   end;
end;
 }

Function LerGenerator( fsNome : String; fiIncremento : Integer; fiTamanho : Integer; fbAtualizar : Boolean; prConexao: TSQLConnection = nil ) : String;
Var lqryLerGenerator : TSQLQuery;
    ldspLerGenerator : TDataSetProvider;
    lcdsLerGenerator : TClientDataSet;

    lsMensagemErro   : String;
    liIncremento     : Integer;
    liSequencia      : Integer;
    liTimeOut        : Integer;
    lConexao         : TSQLConnection;
Begin
   Result := 'ERRO';

   if prConexao = nil then
      lConexao := dtmPrincipal.dbxPrincipal
   else
      lConexao := prConexao;

   liIncremento := fiIncremento;
   If NOT fbAtualizar Then
      liIncremento := 0;

   lqryLerGenerator := TSQLQuery.Create( Application );
   ldspLerGenerator := TDataSetProvider.Create( Application );
   lcdsLerGenerator := TClientDataSet.Create( Application );
   Try
      liTimeOut := 5;
      While True Do
      Begin
         If liTimeOut = 0 Then
         Begin
            CaixaMensagem( 'Não foi possível incrementar o generator "' + fsNome + '"!' + lsMensagemErro, ctErro, [ cbOk ], 0 );
            Exit;
         End;
         Try
            lqryLerGenerator.Close;
            lqryLerGenerator.SQLConnection := lConexao;
            lqryLerGenerator.Params.Clear;
            lqryLerGenerator.SQL.Text := 'SELECT GEN_ID( ' + fsNome + ', ' + IntToStr( liIncremento ) + ' ) from RDB$Database';
            If NOT fbAtualizar Then
               lqryLerGenerator.SQL.Text := 'SELECT GEN_ID( ' + fsNome + ', 0 ) from RDB$Database';

            ldspLerGenerator.DataSet := lqryLerGenerator;
            ldspLerGenerator.Name    := 'ldspLerGenerator';

            lcdsLerGenerator.Close;
            lcdsLerGenerator.ProviderName := ldspLerGenerator.Name;
            lcdsLerGenerator.Open;
            liSequencia := lcdsLerGenerator.Fields[ 0 ].AsInteger;
            If NOT fbAtualizar Then
               liSequencia := lcdsLerGenerator.Fields[ 0 ].AsInteger + fiIncremento;
            lcdsLerGenerator.Close;
            Result := IncZero( IntToStr( liSequencia ), fiTamanho );
            Break;
         Except
            On E: Exception Do
            Begin
               lsMensagemErro := E.Message;
            End;
         End;
         liTimeOut := liTimeOut - 1;
         Sleep( 1000 );
      End;
   Finally
      lcdsLerGenerator.Close;
      FreeAndNil( lcdsLerGenerator );

      FreeAndNil( ldspLerGenerator );

      lqryLerGenerator.Close;
      FreeAndNil( lqryLerGenerator );
   End;
End;

end.
