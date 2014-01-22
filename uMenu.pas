unit uMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ImgList, cxGraphics,
  bsSkinData, BusinessSkinForm, uProdutos, uCadastroCliente;

type
  TfrmPrincipal = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    cxSmallImages: TcxImageList;
    cxLargeImages: TcxImageList;
    ImageMenu32x32: TcxImageList;
    Imagebutoes: TcxImageList;
    cxImageList2: TcxImageList;
    cxImageList1: TcxImageList;
    ilImage3: TImageList;
    ilImagem3: TImageList;
    ilImagem2: TImageList;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
   frmCadastroCliente := TfrmCadastroCliente.Create( Application );
   try
      frmCadastroCliente.ShowModal;
   finally
      FreeAndNil( frmCadastroCliente );
   end;
end;

procedure TfrmPrincipal.Button2Click(Sender: TObject);
begin
   frmVendas := TfrmVendas.Create( Application );
   try
      frmVendas.ShowModal;
   finally
      FreeAndNil( frmVendas );
   end;
end;

procedure TfrmPrincipal.Button3Click(Sender: TObject);
begin
   frmCadastroProdutos := TfrmCadastroProdutos.Create( Application );
   try
      frmCadastroProdutos.ShowModal;
   finally
      FreeAndNil( frmCadastroProdutos );
   end;
end;

end.
