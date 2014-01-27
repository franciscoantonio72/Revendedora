object frmLancamento: TfrmLancamento
  Left = 0
  Top = 0
  Caption = 'Lan'#231'amento de Produtos'
  ClientHeight = 449
  ClientWidth = 619
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object bsSkinCoolBar1: TbsSkinCoolBar
    Left = 0
    Top = 0
    Width = 619
    Height = 59
    AutoSize = True
    Bands = <
      item
        Control = bsSkinToolBar1
        ImageIndex = -1
        MinHeight = 55
        Width = 613
      end>
    Images = frmPrincipal.ImageMenu32x32
    SkinDataName = 'controlbar'
    SkinBevel = True
    TabOrder = 0
    object bsSkinToolBar1: TbsSkinToolBar
      Left = 11
      Top = 0
      Width = 604
      Height = 55
      HintImageIndex = 0
      TabOrder = 0
      SkinDataName = 'bigtoolpanel'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 13
      DefaultFont.Name = 'Tahoma'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = True
      EmptyDrawing = False
      RibbonStyle = False
      ImagePosition = bsipDefault
      TransparentMode = False
      CaptionImageIndex = -1
      RealHeight = -1
      AutoEnabledControls = True
      CheckedMode = False
      Checked = False
      DefaultAlignment = taLeftJustify
      DefaultCaptionHeight = 22
      BorderStyle = bvNone
      CaptionMode = False
      RollUpMode = False
      RollUpState = False
      NumGlyphs = 1
      Spacing = 2
      Caption = 'bsSkinToolBar1'
      CanScroll = False
      HotScroll = False
      ScrollOffset = 0
      ScrollTimerInterval = 50
      AdjustControls = True
      WidthWithCaptions = 0
      WidthWithoutCaptions = 0
      AutoShowHideCaptions = False
      ShowCaptions = True
      Flat = True
      Images = frmPrincipal.Imagebutoes
      object btnFechar: TbsSkinSpeedButton
        Left = 537
        Top = 0
        Width = 56
        Height = 55
        HintImageIndex = 0
        SkinDataName = 'bigtoolbutton'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = 13
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = True
        CheckedMode = False
        UseSkinSize = True
        UseSkinFontColor = True
        WidthWithCaption = 0
        WidthWithoutCaption = 0
        ImageIndex = 7
        RepeatMode = False
        RepeatInterval = 100
        Transparent = True
        Flat = True
        AllowAllUp = False
        Down = False
        GroupIndex = 0
        Caption = 'Fechar'
        ShowCaption = True
        NumGlyphs = 1
        Align = alLeft
        Spacing = 1
        Layout = blGlyphTop
        OnClick = btnFecharClick
        ExplicitLeft = 649
        ExplicitTop = 15
      end
      object btnOk: TbsSkinSpeedButton
        Left = 481
        Top = 0
        Width = 56
        Height = 55
        HintImageIndex = 0
        SkinDataName = 'bigtoolbutton'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = 13
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = True
        CheckedMode = False
        UseSkinSize = True
        UseSkinFontColor = True
        WidthWithCaption = 0
        WidthWithoutCaption = 0
        ImageIndex = 3
        RepeatMode = False
        RepeatInterval = 100
        Transparent = True
        Flat = True
        AllowAllUp = False
        Down = False
        GroupIndex = 0
        Caption = 'OK'
        ShowCaption = True
        NumGlyphs = 1
        Align = alLeft
        Spacing = 1
        Layout = blGlyphTop
        OnClick = btnOkClick
        ExplicitLeft = 419
        ExplicitTop = 15
      end
      object bsSkinBevel1: TbsSkinBevel
        Left = 0
        Top = 0
        Width = 481
        Height = 55
        Align = alLeft
        SkinDataName = 'bevel'
        DividerMode = True
        ExplicitTop = 2
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 59
    Width = 619
    Height = 390
    Align = alClient
    TabOrder = 1
    object Label2: TLabel
      Left = 35
      Top = 353
      Width = 40
      Height = 13
      Alignment = taRightJustify
      Caption = 'Parcelas'
    end
    object Label4: TLabel
      Left = 541
      Top = 352
      Width = 42
      Height = 23
      Alignment = taRightJustify
      Caption = '0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Panel3: TPanel
      Left = 1
      Top = 171
      Width = 617
      Height = 160
      Align = alTop
      TabOrder = 0
      object DBGrid1: TDBGrid
        Left = 1
        Top = 1
        Width = 615
        Height = 158
        Align = alClient
        DataSource = dtsItensVendas
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'CODIGO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'QUANTIDADE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRECO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALORTOTAL'
            Visible = True
          end>
      end
    end
    object SpinEdit1: TSpinEdit
      Left = 81
      Top = 350
      Width = 40
      Height = 22
      MaxValue = 12
      MinValue = 1
      TabOrder = 1
      Value = 1
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 617
      Height = 170
      Align = alTop
      TabOrder = 2
      object Código: TLabel
        Left = 57
        Top = 54
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'C'#243'digo'
      end
      object Label1: TLabel
        Left = 34
        Top = 105
        Width = 56
        Height = 13
        Alignment = taRightJustify
        Caption = 'Quantidade'
      end
      object Label5: TLabel
        Left = 57
        Top = 25
        Width = 33
        Height = 13
        Caption = 'Cliente'
      end
      object Label3: TLabel
        Left = 26
        Top = 132
        Width = 64
        Height = 13
        Alignment = taRightJustify
        Caption = 'Valor Unit'#225'rio'
      end
      object Label6: TLabel
        Left = 13
        Top = 81
        Width = 77
        Height = 13
        Alignment = taRightJustify
        Caption = 'Tipo Pagamento'
      end
      object Label7: TLabel
        Left = 208
        Top = 105
        Width = 55
        Height = 13
        Caption = 'Vencimento'
      end
      object cmbCodigoProduto: TDBLookupComboBox
        Left = 96
        Top = 48
        Width = 73
        Height = 21
        KeyField = 'ID'
        ListField = 'ID;DESCRICAO'
        ListSource = dtsProdutos
        TabOrder = 0
        OnClick = cmbCodigoProdutoClick
      end
      object cmbDescricaoProduto: TDBLookupComboBox
        Left = 175
        Top = 48
        Width = 418
        Height = 21
        KeyField = 'ID'
        ListField = 'DESCRICAO;ID'
        ListSource = dtsProdutos
        TabOrder = 1
        OnClick = cmbDescricaoProdutoClick
      end
      object edtQuantidade: TMaskEdit
        Left = 96
        Top = 102
        Width = 72
        Height = 21
        Alignment = taRightJustify
        TabOrder = 2
        Text = '1'
      end
      object edtValorUnitario: TMaskEdit
        Left = 96
        Top = 129
        Width = 121
        Height = 21
        Alignment = taRightJustify
        TabOrder = 3
        Text = '0,00'
      end
      object cmbCodigoCliente: TDBLookupComboBox
        Left = 96
        Top = 21
        Width = 73
        Height = 21
        KeyField = 'ID'
        ListField = 'ID;NOME'
        ListSource = dtsClientes
        TabOrder = 4
        OnClick = cmbCodigoClienteClick
      end
      object cmbNomeCliente: TDBLookupComboBox
        Left = 175
        Top = 21
        Width = 418
        Height = 21
        KeyField = 'ID'
        ListField = 'NOME;ID'
        ListSource = dtsClientes
        TabOrder = 5
        OnClick = cmbNomeClienteClick
      end
      object cmbCodigoTipoPagto: TDBLookupComboBox
        Left = 96
        Top = 75
        Width = 73
        Height = 21
        KeyField = 'ID'
        ListField = 'ID;DESCRICAO'
        ListSource = dtsTipoPagto
        TabOrder = 6
        OnClick = cmbCodigoTipoPagtoClick
      end
      object cmbDescricaoTipoPagto: TDBLookupComboBox
        Left = 175
        Top = 75
        Width = 418
        Height = 21
        KeyField = 'ID'
        ListField = 'DESCRICAO;ID'
        ListSource = dtsTipoPagto
        TabOrder = 7
        OnClick = cmbDescricaoTipoPagtoClick
      end
      object edtDataVencimento: TMaskEdit
        Left = 269
        Top = 102
        Width = 71
        Height = 21
        EditMask = '!99/99/0000;1;_'
        MaxLength = 10
        TabOrder = 8
        Text = '  /  /    '
      end
      object Button1: TButton
        Left = 223
        Top = 129
        Width = 75
        Height = 25
        Caption = 'Adicionar'
        TabOrder = 9
        OnClick = Button1Click
      end
    end
  end
  object cdsItensVendas: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODIGO'
        DataType = ftInteger
      end
      item
        Name = 'DESCRICAO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'QUANTIDADE'
        DataType = ftInteger
      end
      item
        Name = 'PRECO'
        DataType = ftFloat
      end
      item
        Name = 'VALORTOTAL'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 264
    Top = 216
    Data = {
      7B0000009619E0BD0100000018000000050000000000030000007B0006434F44
      49474F04000100000000000944455343524943414F0100490000000100055749
      4454480200020032000A5155414E544944414445040001000000000005505245
      434F08000400000000000A56414C4F52544F54414C08000400000000000000}
    object cdsItensVendasCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsItensVendasDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 50
    end
    object cdsItensVendasQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
      DisplayFormat = '0'
    end
    object cdsItensVendasPRECO: TFloatField
      FieldName = 'PRECO'
      DisplayFormat = '0.00'
    end
    object cdsItensVendasVALORTOTAL: TFloatField
      FieldName = 'VALORTOTAL'
      DisplayFormat = '0.00'
    end
  end
  object dtsItensVendas: TDataSource
    DataSet = cdsItensVendas
    Left = 264
    Top = 272
  end
  object cdsProdutos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 360
    Top = 80
  end
  object dtsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 360
    Top = 120
  end
  object sqlPrincipal: TSQLQuery
    Params = <>
    Left = 536
    Top = 88
  end
  object dspPrincipal: TDataSetProvider
    DataSet = sqlPrincipal
    Left = 536
    Top = 136
  end
  object dtsClientes: TDataSource
    DataSet = cdsClientes
    Left = 328
    Top = 120
  end
  object cdsClientes: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 328
    Top = 80
  end
  object dtsTipoPagto: TDataSource
    DataSet = cdsTipoPagto
    Left = 392
    Top = 120
  end
  object cdsTipoPagto: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 392
    Top = 80
  end
end
