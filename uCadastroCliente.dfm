object frmCadastroCliente: TfrmCadastroCliente
  Left = 0
  Top = 0
  Caption = 'Cadastro de Clientes'
  ClientHeight = 248
  ClientWidth = 690
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object clbr1: TCoolBar
    Left = 0
    Top = 0
    Width = 690
    Height = 48
    AutoSize = True
    BandMaximize = bmNone
    Bands = <
      item
        Control = tlb1
        ImageIndex = -1
        MinHeight = 44
        Width = 684
      end>
    object tlb1: TToolBar
      Left = 11
      Top = 0
      Width = 675
      Height = 44
      AutoSize = True
      ButtonHeight = 44
      ButtonWidth = 69
      Caption = 'ToolBar'
      Color = clBtnFace
      EdgeBorders = [ebTop, ebRight, ebBottom]
      EdgeInner = esNone
      EdgeOuter = esNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Images = frmPrincipal.ilImagem2
      ParentColor = False
      ParentFont = False
      ShowCaptions = True
      TabOrder = 0
      Transparent = True
      Wrapable = False
      object btnBotaoIncluir: TToolButton
        Left = 0
        Top = 0
        Hint = 'Bot'#227'o Incluir'
        Caption = '&Incluir'
        ImageIndex = 0
        ParentShowHint = False
        ShowHint = True
        OnClick = btnBotaoIncluirClick
      end
      object btnBotaoAlterar: TToolButton
        Left = 69
        Top = 0
        Caption = '&Alterar'
        ImageIndex = 1
        OnClick = btnBotaoAlterarClick
      end
      object btnBotaoExcluir: TToolButton
        Left = 138
        Top = 0
        Caption = '&Excluir'
        ImageIndex = 2
        OnClick = btnBotaoExcluirClick
      end
      object btnBotaoPesquisar: TToolButton
        Left = 207
        Top = 0
        Caption = '&Pesquisar'
        ImageIndex = 5
        Style = tbsDropDown
      end
      object btn1: TToolButton
        Left = 291
        Top = 0
        Width = 80
        Caption = 'btn1'
        ImageIndex = 8
        Style = tbsSeparator
      end
      object btnBotaoImprimir: TToolButton
        Left = 371
        Top = 0
        Caption = 'I&mprimir'
        ImageIndex = 6
        Style = tbsDropDown
      end
      object btnBotaoOk: TToolButton
        Left = 455
        Top = 0
        Caption = '&Ok'
        ImageIndex = 3
        OnClick = btnBotaoOkClick
      end
      object btn2: TToolButton
        Left = 524
        Top = 0
        Width = 3
        Caption = 'btn2'
        ImageIndex = 8
        Style = tbsSeparator
      end
      object btnBotaoCancela: TToolButton
        Left = 527
        Top = 0
        Caption = '&Cancela'
        ImageIndex = 4
        OnClick = btnBotaoCancelaClick
      end
      object btnBotaoFechar: TToolButton
        Left = 596
        Top = 0
        Caption = '&Fechar'
        ImageIndex = 7
        OnClick = btnBotaoFecharClick
      end
      object btn3: TToolButton
        Left = 665
        Top = 0
        Width = 3
        Caption = 'btn3'
        ImageIndex = 8
        Style = tbsSeparator
      end
    end
  end
  object Paginas: TPageControl
    Left = 0
    Top = 48
    Width = 690
    Height = 200
    ActivePage = ts2
    Align = alClient
    TabOrder = 1
    object ts1: TTabSheet
      Caption = 'Consulta'
      object dbgrd1: TDBGrid
        Left = 0
        Top = 0
        Width = 682
        Height = 172
        Align = alClient
        DataSource = dstClientes
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object ts2: TTabSheet
      Caption = 'Cadastro'
      ImageIndex = 1
      object lbl1: TLabel
        Left = 48
        Top = 16
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'C'#243'digo'
      end
      object lbl3: TLabel
        Left = 54
        Top = 46
        Width = 27
        Height = 13
        Alignment = taRightJustify
        Caption = 'Nome'
      end
      object lblCodigo: TLabel
        Left = 87
        Top = 16
        Width = 42
        Height = 13
        Caption = '000000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl7: TLabel
        Left = 36
        Top = 73
        Width = 45
        Height = 13
        Alignment = taRightJustify
        Caption = 'Endere'#231'o'
      end
      object lbl9: TLabel
        Left = 44
        Top = 98
        Width = 28
        Height = 13
        Alignment = taRightJustify
        Caption = 'Bairro'
      end
      object lbl11: TLabel
        Left = 337
        Top = 98
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'Cidade'
      end
      object lbl14: TLabel
        Left = 30
        Top = 129
        Width = 51
        Height = 13
        Alignment = taRightJustify
        Caption = 'Telefone 1'
      end
      object lbl16: TLabel
        Left = 208
        Top = 129
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'Celular'
      end
      object lbl27: TLabel
        Left = 354
        Top = 129
        Width = 59
        Height = 13
        Caption = 'Comiss'#227'o %'
      end
      object edtNome: TEdit
        Left = 87
        Top = 43
        Width = 570
        Height = 21
        TabOrder = 0
      end
      object edtEndereco: TEdit
        Left = 87
        Top = 70
        Width = 570
        Height = 21
        MaxLength = 40
        TabOrder = 1
      end
      object edtBairro: TEdit
        Left = 87
        Top = 98
        Width = 142
        Height = 21
        MaxLength = 20
        TabOrder = 2
      end
      object edtCidade: TEdit
        Left = 376
        Top = 98
        Width = 281
        Height = 21
        TabOrder = 3
      end
      object edtTelefone1: TMaskEdit
        Left = 87
        Top = 126
        Width = 83
        Height = 21
        EditMask = '(99)9999-9999;0;_'
        MaxLength = 13
        TabOrder = 4
      end
      object edtCelular: TMaskEdit
        Left = 247
        Top = 126
        Width = 85
        Height = 21
        EditMask = '(99)9999-9999;0;_'
        MaxLength = 13
        TabOrder = 5
      end
      object edtComissao: TEdit
        Left = 431
        Top = 126
        Width = 50
        Height = 21
        Alignment = taRightJustify
        TabOrder = 6
        Text = '0'
      end
    end
  end
  object cdsClientes: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODIGO'
        DataType = ftInteger
      end
      item
        Name = 'RAZAOSOCIAL'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'NOMEFANTASIA'
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 456
    Top = 96
    Data = {
      6A0000009619E0BD0100000018000000030000000000030000006A0006434F44
      49474F04000100000000000B52415A414F534F4349414C010049000000010005
      57494454480200020032000C4E4F4D4546414E54415349410100490000000100
      0557494454480200020032000000}
  end
  object dstClientes: TDataSource
    DataSet = cdsClientes
    Left = 456
    Top = 160
  end
end
