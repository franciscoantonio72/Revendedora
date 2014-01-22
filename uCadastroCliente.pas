unit uCadastroCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, RibbonLunaStyleActnCtrls, Ribbon, ActnMan,
  ActnCtrls, StdCtrls, Mask, DB, DBClient, Grids, DBGrids, uClassCliente,
  uClassFuncoes;

type
   TTipoOperacao = ( tsIncluir, tsAlterar, tsExcluir );

type
  TfrmCadastroCliente = class(TForm)
    clbr1: TCoolBar;
    tlb1: TToolBar;
    btnBotaoIncluir: TToolButton;
    btnBotaoAlterar: TToolButton;
    btnBotaoExcluir: TToolButton;
    btnBotaoPesquisar: TToolButton;
    btn1: TToolButton;
    btnBotaoImprimir: TToolButton;
    btnBotaoOk: TToolButton;
    btn2: TToolButton;
    btnBotaoCancela: TToolButton;
    btnBotaoFechar: TToolButton;
    btn3: TToolButton;
    Paginas: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    lbl1: TLabel;
    edtNome: TEdit;
    lbl3: TLabel;
    dbgrd1: TDBGrid;
    cdsClientes: TClientDataSet;
    dstClientes: TDataSource;
    lblCodigo: TLabel;
    lbl7: TLabel;
    lbl9: TLabel;
    lbl11: TLabel;
    lbl14: TLabel;
    lbl16: TLabel;
    edtEndereco: TEdit;
    edtBairro: TEdit;
    edtCidade: TEdit;
    edtTelefone1: TMaskEdit;
    edtCelular: TMaskEdit;
    edtComissao: TEdit;
    lbl27: TLabel;
    procedure btnBotaoFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnBotaoIncluirClick(Sender: TObject);
    procedure btnBotaoAlterarClick(Sender: TObject);
    procedure btnBotaoExcluirClick(Sender: TObject);
    procedure btnBotaoOkClick(Sender: TObject);
    procedure btnBotaoCancelaClick(Sender: TObject);
  private
    pvTipoOperacao : TTipoOperacao;
    procedure LimparCampos;
    procedure PreencherCampos(proCliente: TCliente);
    function PreencherObjeto : TCliente;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

uses uMenu, uControllerCliente;

{$R *.dfm}

procedure TfrmCadastroCliente.btnBotaoAlterarClick(Sender: TObject);
var loControllerCliente : TControllerCliente;
    loCliente : TCliente;
begin
   Paginas.ActivePageIndex := 1;

   pvTipoOperacao := tsAlterar;

   loControllerCliente := loControllerCliente.Create;
   try
      loCliente := loControllerCliente.BuscarPorCodigo( cdsClientes.FieldByName('Codigo').AsString );
      PreencherCampos( loCliente );
   finally
      FreeAndNil( loCliente );
   end;
end;

procedure TfrmCadastroCliente.btnBotaoCancelaClick(Sender: TObject);
begin
   LimparCampos;
   Paginas.ActivePageIndex := 0;
end;

procedure TfrmCadastroCliente.btnBotaoExcluirClick(Sender: TObject);
var loControllerCliente : TControllerCliente;
begin
   loControllerCliente := TControllerCliente.Create;
   try
      loControllerCliente.Excluir( cdsClientes.FieldByName('Codigo').AsInteger );
   finally
      FreeAndNil( loControllerCliente );
   end;
   LimparCampos;
end;

procedure TfrmCadastroCliente.btnBotaoFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmCadastroCliente.btnBotaoIncluirClick(Sender: TObject);
begin
   Paginas.ActivePageIndex := 1;
   pvTipoOperacao := tsIncluir;

   try
      edtNome.SetFocus;
   except
      //
   end;
end;

procedure TfrmCadastroCliente.btnBotaoOkClick(Sender: TObject);
var loCliente : TCliente;
    loController : TControllerCliente;
begin
   try
      loCliente := PreencherObjeto;

      if pvTipoOperacao = tsIncluir then
         loController.Incluir( loCliente )
      else if pvTipoOperacao = tsAlterar then
         loController.Alterar( loCliente );
   finally
      FreeAndNil( loCliente );
   end;

   LimparCampos;

   Paginas.ActivePageIndex := 0;
end;


procedure TfrmCadastroCliente.FormShow(Sender: TObject);
var loControllerCliente : TControllerCliente;
begin
   Paginas.ActivePageIndex := 0;
   loControllerCliente := TControllerCliente.Create;
   cdsClientes.Data := loControllerCliente.BuscarTodos.Data;
   cdsClientes.Open;
end;

procedure TfrmCadastroCliente.LimparCampos;
var i: Integer;
    loControllerCliente : TControllerCliente;
begin
   edtNome.Text := '';
   edtEndereco.Text := '';
   edtBairro.Text := '';
   edtCidade.Text := '';
   edtTelefone1.Text := '';
   edtCelular.Text := '';
   edtComissao.Text := '0';
   edtEndereco.text := '';

   loControllerCliente := TControllerCliente.Create;
   cdsClientes.Data := loControllerCliente.BuscarTodos.Data;
   cdsClientes.Open;
end;

procedure TfrmCadastroCliente.PreencherCampos(proCliente: TCliente);
begin
   with proCliente do
   begin
      lblCodigo.Caption := IncZero( IntToStr( CODIGO ), 6 );
      edtNome.Text := NOME;
      edtEndereco.Text := ENDERECO;
      edtBairro.Text := BAIRRO;
      edtCidade.Text := CIDADE;
      edtTelefone1.Text := TELEFONE1;
      edtCelular.Text := CELULAR;
      edtComissao.Text := FormatFloat( '0.00', COMISSAO );
   end;
end;

function TfrmCadastroCliente.PreencherObjeto: TCliente;
var loCliente : TCliente;
begin
   loCliente := TCliente.Create;
   With loCliente do
   begin
      CODIGO := StrToInt( lblCodigo.Caption );
      BAIRRO := Trim( edtBairro.Text );
      CELULAR    := Trim( edtCelular.Text );
      CIDADE    := Trim( edtCidade.Text );
      COMISSAO    := StrToFloat( edtComissao.Text );
      DATACADASTRO    := Now;
      ENDERECO    := Trim( edtEndereco.Text );
      NOME    := Trim( edtNome.Text );
      OPERADOR    := '** OPERADOR **';
      TELEFONE1    := Trim( edtTelefone1.Text );
   end;
   Result := loCliente;
end;

end.
