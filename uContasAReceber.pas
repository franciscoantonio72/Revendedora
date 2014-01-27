unit uContasAReceber;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  bsSkinCtrls, Vcl.ToolWin, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.Buttons, Data.DB,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Data.FMTBcd, Datasnap.Provider,
  Data.SqlExpr, uClassFuncoes, uDataModulo;

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
    procedure FormShow(Sender: TObject);
    procedure cmbPeriodoClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure cmbCodigoClienteClick(Sender: TObject);
    procedure cmbNomeClienteClick(Sender: TObject);
    procedure btnSelecionarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmContasAReceber: TfrmContasAReceber;

implementation

{$R *.dfm}

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
   qryVariavel.ParamByName('parDataInicial').AsDate := StrToDate( edtDataInicial.Text );
   qryVariavel.ParamByName('parDataFinal').AsDate := StrToDate( edtDataFinal.Text );

   cdsContasAReceber.Close;
   cdsContasAReceber.ProviderName := dtsContasAReceber.Name;
   cdsContasAReceber.Open;
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
