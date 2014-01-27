unit uMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ImgList, cxGraphics,
  bsSkinData, BusinessSkinForm, uProdutos, uCadastroCliente, uContasAReceber;

type
  TfrmPrincipal = class(TForm)
    cxSmallImages: TcxImageList;
    cxLargeImages: TcxImageList;
    ImageMenu32x32: TcxImageList;
    Imagebutoes: TcxImageList;
    cxImageList2: TcxImageList;
    cxImageList1: TcxImageList;
    ilImage3: TImageList;
    ilImagem3: TImageList;
    ilImagem2: TImageList;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uVendas;

procedure TfrmPrincipal.Button5Click(Sender: TObject);
begin
   frmCadastroCliente := TfrmCadastroCliente.Create( Application );
   try
      frmCadastroCliente.ShowModal;
   finally
      FreeAndNil( frmCadastroCliente );
   end;
end;

procedure TfrmPrincipal.Button6Click(Sender: TObject);
begin
   frmVendas := TfrmVendas.Create( Application );
   try
      frmVendas.ShowModal;
   finally
      FreeAndNil( frmVendas );
   end;
end;

procedure TfrmPrincipal.Button7Click(Sender: TObject);
begin
   frmCadastroProdutos := TfrmCadastroProdutos.Create( Application );
   try
      frmCadastroProdutos.ShowModal;
   finally
      FreeAndNil( frmCadastroProdutos );
   end;
end;

procedure TfrmPrincipal.Button8Click(Sender: TObject);
begin
   frmContasAReceber := TfrmContasAReceber.Create( Application );
   try
      frmContasAReceber.ShowModal;
   finally
      FreeAndNil( frmContasAReceber );
   end;
end;

end.
