unit uLancamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, bsSkinCtrls, Vcl.ToolWin,
  Vcl.ComCtrls, bsSkinGrids, bsDBGrids, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask,
  Data.DB, Datasnap.DBClient, Data.FMTBcd, Datasnap.Provider, Data.SqlExpr, uDataModulo,
  Vcl.Grids, Vcl.DBGrids, Vcl.Samples.Spin, uClassVenda, uClassItemVenda, uControllerVendas, Generics.Collections,
  uControllerContasReceber, uClassContasReceber, uClassFuncoes;

type
  TfrmLancamento = class(TForm)
    bsSkinCoolBar1: TbsSkinCoolBar;
    bsSkinToolBar1: TbsSkinToolBar;
    btnFechar: TbsSkinSpeedButton;
    btnOk: TbsSkinSpeedButton;
    bsSkinBevel1: TbsSkinBevel;
    Panel1: TPanel;
    Panel3: TPanel;
    Label2: TLabel;
    cdsItensVendas: TClientDataSet;
    dtsItensVendas: TDataSource;
    cdsProdutos: TClientDataSet;
    dtsProdutos: TDataSource;
    sqlPrincipal: TSQLQuery;
    dspPrincipal: TDataSetProvider;
    DBGrid1: TDBGrid;
    Label4: TLabel;
    SpinEdit1: TSpinEdit;
    Panel2: TPanel;
    Código: TLabel;
    Label1: TLabel;
    cmbCodigoProduto: TDBLookupComboBox;
    cmbDescricaoProduto: TDBLookupComboBox;
    edtQuantidade: TMaskEdit;
    edtValorUnitario: TMaskEdit;
    Label5: TLabel;
    cmbCodigoCliente: TDBLookupComboBox;
    cmbNomeCliente: TDBLookupComboBox;
    dtsClientes: TDataSource;
    cdsClientes: TClientDataSet;
    cdsItensVendasCODIGO: TIntegerField;
    cdsItensVendasDESCRICAO: TStringField;
    cdsItensVendasQUANTIDADE: TIntegerField;
    cdsItensVendasPRECO: TFloatField;
    cdsItensVendasVALORTOTAL: TFloatField;
    Label3: TLabel;
    Label6: TLabel;
    cmbCodigoTipoPagto: TDBLookupComboBox;
    cmbDescricaoTipoPagto: TDBLookupComboBox;
    dtsTipoPagto: TDataSource;
    cdsTipoPagto: TClientDataSet;
    edtDataVencimento: TMaskEdit;
    Label7: TLabel;
    Button1: TButton;
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmbCodigoProdutoClick(Sender: TObject);
    procedure cmbDescricaoProdutoClick(Sender: TObject);
    procedure cmbCodigoClienteClick(Sender: TObject);
    procedure cmbNomeClienteClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure cmbCodigoTipoPagtoClick(Sender: TObject);
    procedure cmbDescricaoTipoPagtoClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure LimpaCampos;
    procedure AtualizarTotal;
    function PreencherObjetoVenda : TVenda;
    function PreencherObjetoContasReceber( priIdNota : Integer ): TList<TContasReceber>;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLancamento: TfrmLancamento;

implementation

{$R *.dfm}

uses uMenu;

procedure TfrmLancamento.AtualizarTotal;
begin
   Label4.Caption := FormatFloat( '0.00', ( StrToFloat( Label4.Caption ) + StrToFloat( edtValorUnitario.Text ) ) );
end;

procedure TfrmLancamento.btnFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmLancamento.btnOkClick(Sender: TObject);
var loVendas : TVenda;
    loControllerVenda : TControllerVendas;
    loListaContasReceber : TList<TContasReceber>;
    loControllerContasReceber : TControllerContasReceber;
    lsIdVenda : String;
begin
   loVendas := PreencherObjetoVenda;
   try
      loControllerVenda.Incluir( loVendas );

      lsIdVenda := LerGenerator( 'GEN_VENDAS_ID', 1, 8, False );
      loListaContasReceber := PreencherObjetoContasReceber( StrToInt( lsIdVenda ) - 1 );

      loControllerContasReceber := TControllerContasReceber.Create;
      loControllerContasReceber.Incluir( loListaContasReceber );

      LimpaCampos;
   finally
      FreeAndNil( loControllerVenda );
      FreeAndNil( loVendas );
      FreeAndNil( loControllerContasReceber );
      FreeAndNil( loListaContasReceber );
   end;
end;

procedure TfrmLancamento.Button1Click(Sender: TObject);
begin
   cdsItensVendas.Append;
   cdsItensVendas.FieldByName('Codigo').AsInteger := cmbCodigoProduto.KeyValue;
   cdsItensVendas.FieldByName('Descricao').AsString := cdsProdutos.FieldByName('Descricao').AsString;
   cdsItensVendas.FieldByName('Quantidade').AsInteger := StrToInt( edtQuantidade.Text );
   cdsItensVendas.FieldByName('Preco').AsFloat := StrToFloat( edtValorUnitario.Text );
   cdsItensVendas.FieldByName('ValorTotal').AsFloat := StrToInt( edtQuantidade.Text ) * StrToFloat( edtValorUnitario.Text );
   cdsItensVendas.Post;

   AtualizarTotal;
end;

procedure TfrmLancamento.cmbCodigoClienteClick(Sender: TObject);
begin
   cmbNomeCliente.KeyValue := cmbCodigoCliente.KeyValue;
end;

procedure TfrmLancamento.cmbCodigoProdutoClick(Sender: TObject);
begin
   cmbDescricaoProduto.KeyValue := cmbCodigoProduto.KeyValue;
   edtValorUnitario.Text := FormatFloat( '0.00', cdsProdutos.FieldByName( 'Preco' ).AsFloat );
end;

procedure TfrmLancamento.cmbCodigoTipoPagtoClick(Sender: TObject);
begin
   cmbDescricaoTipoPagto.KeyValue := cmbCodigoTipoPagto.KeyValue;
end;

procedure TfrmLancamento.cmbDescricaoProdutoClick(Sender: TObject);
begin
   cmbCodigoProduto.KeyValue := cmbDescricaoProduto.KeyValue;
   edtValorUnitario.Text := FormatFloat( '0.00', cdsProdutos.FieldByName( 'Preco' ).AsFloat );
end;

procedure TfrmLancamento.cmbDescricaoTipoPagtoClick(Sender: TObject);
begin
   cmbCodigoTipoPagto.KeyValue := cmbDescricaoTipoPagto.KeyValue;
end;

procedure TfrmLancamento.cmbNomeClienteClick(Sender: TObject);
begin
   cmbCodigoCliente.KeyValue := cmbNomeCliente.KeyValue;
end;

procedure TfrmLancamento.FormShow(Sender: TObject);
begin
   sqlPrincipal.SQLConnection := dtmPrincipal.dbxPrincipal;
   sqlPrincipal.SQL.Text := 'SELECT * FROM PRODUTOS';

   cdsProdutos.Close;
   cdsProdutos.ProviderName := dspPrincipal.Name;
   cdsProdutos.Open;

   sqlPrincipal.Close;
   sqlPrincipal.SQLConnection := dtmPrincipal.dbxPrincipal;
   sqlPrincipal.SQL.Text := 'SELECT * FROM CLIENTES';

   cdsClientes.Close;
   cdsClientes.ProviderName := dspPrincipal.Name;
   cdsClientes.Open;

   sqlPrincipal.Close;
   sqlPrincipal.SQLConnection := dtmPrincipal.dbxPrincipal;
   sqlPrincipal.SQL.Text := 'SELECT * FROM TIPOPAGAMENTO';

   cdsTipoPagto.Close;
   cdsTipoPagto.ProviderName := dspPrincipal.Name;
   cdsTipoPagto.Open;
end;

procedure TfrmLancamento.LimpaCampos;
begin
   cmbCodigoProduto.KeyValue := null;
   cmbDescricaoProduto.KeyValue := null;
   cmbCodigoCliente.KeyValue := null;
   cmbNomeCliente.KeyValue := null;
   cmbCodigoTipoPagto.KeyValue := null;
   cmbDescricaoTipoPagto.KeyValue := null;
   edtQuantidade.Text := '1';
   edtValorUnitario.Text := '0,00';
   SpinEdit1.Value := 1;
   cdsItensVendas.EmptyDataSet;
   Label4.Caption := '0,00';
end;

function TfrmLancamento.PreencherObjetoVenda : TVenda;
var loVenda : TVenda;
    loItemVenda : TItemVenda;
begin
   loVenda := TVenda.Create;
   loVenda.DATACADASTRO := StrToDate( edtDataVencimento.Text );
   loVenda.CODIGOVENDEDOR := 0;
   loVenda.CODIGOCLIENTE := cmbCodigoCliente.KeyValue;
   loVenda.NOMECLIENTE := cmbNomeCliente.Text;
   loVenda.VALORVENDA := StrToFloat(Label4.Caption);
   loVenda.TIPOPAGAMENTO := cmbCodigoTipoPagto.KeyValue;
   loVenda.PARCELAS := SpinEdit1.Value;

   loVenda.ITENSVENDAS := TList<TItemVenda>.Create;
   while Not cdsItensVendas.Eof do
   begin
     loItemVenda := TItemVenda.Create;
     loItemVenda.IDVENDA := 0;
     loItemVenda.DATACADASTRO := Now;
     loItemVenda.CODIGOPRODUTO := cdsItensVendas.FieldByName('Codigo').AsInteger;
     loItemVenda.DESCRICAOPRODUTO := cdsItensVendas.FieldByName('Descricao').AsString;
     loItemVenda.QUANTIDADE := cdsItensVendas.FieldByName('Quantidade').AsInteger;
     loItemVenda.VALORUNITARIO := cdsItensVendas.FieldByName('Preco').AsFloat;
     loItemVenda.VALORTOTAL := cdsItensVendas.FieldByName('ValorTotal').AsFloat;
     loVenda.ITENSVENDAS.Add( loItemVenda );

     cdsItensVendas.Next;
   end;

   Result := loVenda;
end;

function TfrmLancamento.PreencherObjetoContasReceber( priIdNota : Integer ) : TList<TContasReceber>;
var loContasReceber : TContasReceber;
    loListaContasReceber : TList<TContasReceber>;
    liContador: Integer;
    lrValorParcela : Real;
    ldDataParcela : TDate;
begin
   lrValorParcela := StrToFloat( Label4.Caption ) / SpinEdit1.Value;
   ldDataParcela := Now + 30;

   loListaContasReceber := TList<TContasReceber>.Create;

   for liContador := 0 to SpinEdit1.Value -1 do
   begin
      loContasReceber := TContasReceber.Create;
      loContasReceber.IDVENDA := priIdNota;
      loContasReceber.DATA := Now;
      loContasReceber.DATAVENCIMENTO := ldDataParcela;
      loContasReceber.CODIGOCLIENTE := StrToInt( cmbCodigoCliente.Text );
      loContasReceber.VALORCREDITO := 0;
      loContasReceber.VALORDEBITO := lrValorParcela;
      loContasReceber.PARCELA := liContador + 1;
      loContasReceber.TIPO := 'C';
      loContasReceber.CODIGOTIPOPAGAMENTO := 0;

      loListaContasReceber.Add(loContasReceber);

      ldDataParcela := ldDataParcela + 30;
   end;

   Result := loListaContasReceber;
end;

end.
