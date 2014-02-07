unit uContasAReceber;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  bsSkinCtrls, Vcl.ToolWin, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.Buttons, Data.DB,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Data.FMTBcd, Datasnap.Provider,
  Data.SqlExpr, uClassFuncoes, uDataModulo, Vcl.Menus, bsSkinMenus, uBaixas;

type
  TfrmContasAReceber = class(TForm)
    bsSkinCoolBar1: TbsSkinCoolBar;
    bsSkinToolBar1: TbsSkinToolBar;
    btnFechar: TbsSkinSpeedButton;
    btnOk: TbsSkinSpeedButton;
    bsSkinBevel1: TbsSkinBevel;
    Panel1: TPanel;
    edtDataInicial: TMaskEdit;
    edtDataFinal: TMaskEdit;
    Label1: TLabel;
    cmbPeriodo: TComboBox;
    btnSelecionar: TSpeedButton;
    Label5: TLabel;
    cmbCodigoCliente: TDBLookupComboBox;
    cmbNomeCliente: TDBLookupComboBox;
    Panel2: TPanel;
    Panel3: TPanel;
    Label29: TLabel;
    Shape8: TShape;
    Label27: TLabel;
    Label28: TLabel;
    Label30: TLabel;
    Shape5: TShape;
    Shape6: TShape;
    Shape9: TShape;
    DBGrid1: TDBGrid;
    dtsContasAReceber: TDataSource;
    cdsContasAReceber: TClientDataSet;
    qryVariavel: TSQLQuery;
    dtpVariavel: TDataSetProvider;
    cdsClientes: TClientDataSet;
    dtsClientes: TDataSource;
    bsSkinBevel2: TbsSkinBevel;
    bsSkinMenuSpeedButton1: TbsSkinMenuSpeedButton;
    bsSkinBevel3: TbsSkinBevel;
    bsSkinPopupMenu1: TbsSkinPopupMenu;
    ContasaReceber1: TMenuItem;
    bsSkinSpeedButton1: TbsSkinSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure cmbPeriodoClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure cmbCodigoClienteClick(Sender: TObject);
    procedure cmbNomeClienteClick(Sender: TObject);
    procedure btnSelecionarClick(Sender: TObject);
    procedure cdsContasAReceberAfterOpen(DataSet: TDataSet);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure bsSkinSpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmContasAReceber: TfrmContasAReceber;

implementation

{$R *.dfm}

procedure TfrmContasAReceber.bsSkinSpeedButton1Click(Sender: TObject);
begin
   frmBaixas := TfrmBaixas.Create( Application );
   try
      frmBaixas.ShowModal;
   finally
      FreeAndNil( frmBaixas );
   end;
end;

procedure TfrmContasAReceber.btnFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmContasAReceber.btnSelecionarClick(Sender: TObject);
begin
   qryVariavel.Close;
   qryVariavel.SQLConnection := dtmPrincipal.dbxPrincipal;
   qryVariavel.SQL.Text := 'SELECT * FROM ContasReceber '+
                           'WHERE DataVencimento>=:parDataInicial AND DataVencimento<=:parDataFinal';
   if cmbCodigoCliente.KeyValue <> null then
   begin
      qryVariavel.SQL.Text := qryVariavel.SQL.Text + ' AND CodigoCliente=:parCodigoCliente';
      qryVariavel.ParamByName('parCodigoCliente').AsString := cmbCodigoCliente.KeyValue;
   end;

   qryVariavel.ParamByName('parDataInicial').AsDate := StrToDate( edtDataInicial.Text );
   qryVariavel.ParamByName('parDataFinal').AsDate := StrToDate( edtDataFinal.Text );


   cdsContasAReceber.Close;
   cdsContasAReceber.ProviderName := dtpVariavel.Name;
   cdsContasAReceber.Open;
end;

procedure TfrmContasAReceber.cdsContasAReceberAfterOpen(DataSet: TDataSet);
Var liCont : Integer;
begin
   For liCont := 1 To DataSet.FieldCount Do
   Begin
      If ( DataSet.Fields[ liCont - 1 ].DataType = ftFloat ) Or
         ( DataSet.Fields[ liCont - 1 ].DataType = ftFMTBcd ) Then
      Begin
         TFloatField( DataSet.Fields[ liCont - 1 ] ).DisplayFormat := '0.00';
      End;
   End;
end;

procedure TfrmContasAReceber.cmbCodigoClienteClick(Sender: TObject);
begin
   cmbNomeCliente.KeyValue := cmbCodigoCliente.KeyValue;
end;

procedure TfrmContasAReceber.cmbNomeClienteClick(Sender: TObject);
begin
   cmbCodigoCliente.KeyValue := cmbNomeCliente.KeyValue;
end;

procedure TfrmContasAReceber.cmbPeriodoClick(Sender: TObject);
begin
   ListaPeriodo( TEdit( edtDataInicial ), TEdit( edtDataFinal ), cmbPeriodo.ItemIndex, SoData( Now ) );
end;

procedure TfrmContasAReceber.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  With TDBGrid( Sender ) Do
  Begin
     If gdSelected In State Then
        Exit;

     If SoData( Column.Grid.DataSource.DataSet.FieldByName( 'DataVencimento' ).AsDateTime ) < ( Now ) Then
     Begin
        Canvas.Font.Color  := clRed;
     End
     Else If SoData( Column.Grid.DataSource.DataSet.FieldByName( 'DataVencimento' ).AsDateTime ) = ( Now ) Then
     Begin
        Canvas.Font.Color  := clBlue;
     End
     Else If SoData( Column.Grid.DataSource.DataSet.FieldByName( 'DataVencimento' ).AsDateTime ) > ( Now ) Then
     Begin
        Canvas.Font.Color  := clGreen;
     End;

     DefaultDrawColumnCell( Rect, DataCol, Column, State );
  End;
end;

procedure TfrmContasAReceber.FormShow(Sender: TObject);
begin
   qryVariavel.Close;
   qryVariavel.SQLConnection := dtmPrincipal.dbxPrincipal;
   qryVariavel.SQL.Text := 'SELECT * FROM CLIENTES';

   cdsClientes.Close;
   cdsClientes.ProviderName := dtpVariavel.Name;
   cdsClientes.Open;

   cmbPeriodo.ItemIndex := 4; // Semana Anterior
   cmbPeriodoClick( cmbPeriodo );
end;

end.
