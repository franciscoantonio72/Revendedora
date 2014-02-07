program Revendedora;

uses
  Vcl.Forms,
  uMenu in 'uMenu.pas' {frmPrincipal},
  uVendas in 'uVendas.pas' {frmVendas},
  uContasAReceber in 'uContasAReceber.pas' {frmContasAReceber},
  uCaixa in 'uCaixa.pas' {Form4},
  uLancamento in 'uLancamento.pas' {frmLancamento},
  uDataModulo in 'uDataModulo.pas' {dtmPrincipal: TDataModule},
  uProdutos in 'uProdutos.pas' {frmCadastroProdutos},
  uCadastroCliente in 'uCadastroCliente.pas' {frmCadastroCliente},
  uClassCliente in 'Modelos\uClassCliente.pas',
  uControllerCliente in 'Controller\uControllerCliente.pas',
  uDaoCliente in 'Dao\uDaoCliente.pas',
  uClassFuncoes in 'uClassFuncoes.pas',
  uVariaveisGlobais in '..\Agencia\uVariaveisGlobais.pas',
  uMensagens in '..\Agencia\uMensagens.pas' {FrmMensagens},
  uControllerVendas in 'Controller\uControllerVendas.pas',
  uDaoVendas in 'Dao\uDaoVendas.pas',
  uClassVenda in 'Modelos\uClassVenda.pas',
  uClassItemVenda in 'Modelos\uClassItemVenda.pas',
  uControllerContasReceber in 'Controller\uControllerContasReceber.pas',
  uclassContasReceber in 'Modelos\uclassContasReceber.pas',
  uDaoContasReceber in 'Dao\uDaoContasReceber.pas',
  uClassCaixa in 'Modelos\uClassCaixa.pas',
  uBaixas in 'uBaixas.pas' {frmBaixas},
  uQtdeCR in 'uQtdeCR.pas' {frmQtdeCR};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmLancamento, frmLancamento);
  Application.CreateForm(TdtmPrincipal, dtmPrincipal);
  Application.CreateForm(TfrmCadastroProdutos, frmCadastroProdutos);
  Application.CreateForm(TfrmCadastroCliente, frmCadastroCliente);
  Application.CreateForm(TFrmMensagens, FrmMensagens);
  Application.CreateForm(TfrmBaixas, frmBaixas);
  Application.CreateForm(TfrmQtdeCR, frmQtdeCR);
  Application.Run;
end.
