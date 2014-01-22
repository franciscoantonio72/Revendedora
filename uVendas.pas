unit uVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, bsSkinCtrls, Vcl.ToolWin,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Data.DB, Datasnap.DBClient, uControllerVendas;

type
  TfrmVendas = class(TForm)
    bsSkinCoolBar1: TbsSkinCoolBar;
    bsSkinToolBar1: TbsSkinToolBar;
    btnIncluir: TbsSkinSpeedButton;
    btnAlterar: TbsSkinSpeedButton;
    btnCancelar: TbsSkinSpeedButton;
    bsSkinBevel1: TbsSkinBevel;
    btnFechar: TbsSkinSpeedButton;
    btnOk: TbsSkinSpeedButton;
    bntImprimir: TbsSkinSpeedButton;
    bsSkinBevel2: TbsSkinBevel;
    btnExcluir: TbsSkinSpeedButton;
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    cdsVendas: TClientDataSet;
    dtsVendas: TDataSource;
    dtsItensVendas: TDataSource;
    cdsItensVendas: TClientDataSet;
    procedure btnFecharClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cdsVendasAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVendas: TfrmVendas;

implementation

{$R *.dfm}

uses uMenu, uLancamento;

procedure TfrmVendas.btnFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmVendas.btnIncluirClick(Sender: TObject);
begin
   frmLancamento := TfrmLancamento.Create(Application);
   try
      frmLancamento.ShowModal;
   finally
      FreeAndNil(  frmLancamento );
   end;
end;

procedure TfrmVendas.cdsVendasAfterScroll(DataSet: TDataSet);
var loItensVendas : TControllerVendas;
begin
   loItensVendas := TControllerVendas.Create;

   cdsItensVendas.Data := loItensVendas.BuscarItensVendasPorId( cdsVendas.FieldByName('Id').AsInteger ).Data;
end;

procedure TfrmVendas.FormShow(Sender: TObject);
var loVendas : TControllerVendas;
begin
   loVendas := TControllerVendas.Create;
   try
      cdsVendas.Data := loVendas.BuscarTodos.Data;
      cdsItensVendas.Data := loVendas.BuscarItensVendasPorId( cdsVendas.FieldByName( 'Id').AsInteger ).Data;
   finally
      FreeAndNil( loVendas );
   end;
end;

end.
