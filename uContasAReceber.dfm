object frmContasAReceber: TfrmContasAReceber
  Left = 0
  Top = 0
  Caption = 'Contas a Receber'
  ClientHeight = 400
  ClientWidth = 582
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
    Width = 582
    Height = 59
    AutoSize = True
    Bands = <
      item
        Control = bsSkinToolBar1
        ImageIndex = -1
        MinHeight = 55
        Width = 576
      end>
    Images = frmPrincipal.ImageMenu32x32
    SkinDataName = 'controlbar'
    SkinBevel = True
    TabOrder = 0
    ExplicitLeft = -172
    ExplicitWidth = 619
    object bsSkinToolBar1: TbsSkinToolBar
      Left = 11
      Top = 0
      Width = 567
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
        Left = 499
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
        Left = 443
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
        ExplicitLeft = 419
        ExplicitTop = 15
      end
      object bsSkinBevel1: TbsSkinBevel
        Left = 0
        Top = 0
        Width = 443
        Height = 55
        Align = alLeft
        SkinDataName = 'bevel'
        DividerMode = True
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 59
    Width = 582
    Height = 78
    Align = alTop
    TabOrder = 1
    DesignSize = (
      582
      78)
    object Label1: TLabel
      Left = 24
      Top = 43
      Width = 36
      Height = 13
      Caption = 'Per'#237'odo'
    end
    object btnSelecionar: TSpeedButton
      Left = 415
      Top = 35
      Width = 113
      Height = 26
      Anchors = [akTop, akRight]
      Caption = 'Selecionar'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        EE000000424DEE000000000000007600000028000000100000000F0000000100
        0400000000007800000000000000000000001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        8888888888888888888888888800008888888888880660888888888888088088
        8888888888088088888888888808808888888888806886088888888806688860
        8888888066888866088888066FF8888660888066FFFF88866608800000000000
        000888888888888888888888888888888888}
      ParentFont = False
      OnClick = btnSelecionarClick
    end
    object Label5: TLabel
      Left = 33
      Top = 17
      Width = 33
      Height = 13
      Caption = 'Cliente'
    end
    object edtDataInicial: TMaskEdit
      Left = 72
      Top = 40
      Width = 69
      Height = 21
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
    end
    object edtDataFinal: TMaskEdit
      Left = 159
      Top = 40
      Width = 70
      Height = 21
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
    end
    object cmbPeriodo: TComboBox
      Left = 239
      Top = 40
      Width = 170
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      DropDownCount = 30
      TabOrder = 2
      TabStop = False
      OnClick = cmbPeriodoClick
      Items.Strings = (
        'Nenhum'
        'Ontem'
        'Hoje'
        'Amanh'#227
        'Semana Anterior'
        'Esta Semana'
        'Pr'#243'xima Semana'
        'Quinzena Anterior'
        'Esta Quinzena'
        'Pr'#243'xima Quinzena '
        'Nos '#218'ltimos 15 dias'
        'Nos Pr'#243'ximos 15 dias'
        'Nos '#218'ltimos e Pr'#243'ximos 15 dias'
        'M'#234's Anterior'
        'Este M'#234's'
        'Pr'#243'ximo M'#234's'
        'Nos '#218'ltimos 30 dias'
        'Nos Pr'#243'ximos 30 dias'
        'Nos '#218'ltimos e Pr'#243'ximos 30 dias'
        'Nos '#218'ltimos 45 dias'
        'Nos Pr'#243'ximos 45 dias'
        'Nos '#218'ltimos e Pr'#243'ximos 45 dias'
        'Nos '#218'ltimos 60 dias'
        'Nos Pr'#243'ximos 60 dias'
        'Nos '#218'ltimos e Pr'#243'ximos 60 dias'
        'Trimestre Anterior'
        'Neste Trimestre'
        'Pr'#243'ximo Trimestre'
        'Nos '#218'ltimos 90 dias'
        'Nos Pr'#243'ximos 90 dias'
        'Nos '#218'ltimos e Pr'#243'ximos 90 dias'
        'Semestre Passado'
        'Neste Semestre'
        'Pr'#243'ximo Semestre'
        'Nos '#218'ltimos 120 dias'
        'Nos Pr'#243'ximos 120 dias'
        'Nos '#218'ltimos e Pr'#243'ximos 120 dias'
        'Ano Passado'
        'Neste Ano'
        'Pr'#243'ximo Ano')
    end
    object cmbCodigoCliente: TDBLookupComboBox
      Left = 72
      Top = 13
      Width = 73
      Height = 21
      KeyField = 'ID'
      ListField = 'ID;NOME'
      ListSource = dtsClientes
      TabOrder = 3
      OnClick = cmbCodigoClienteClick
    end
    object cmbNomeCliente: TDBLookupComboBox
      Left = 151
      Top = 13
      Width = 354
      Height = 21
      KeyField = 'ID'
      ListField = 'NOME;ID'
      ListSource = dtsClientes
      TabOrder = 4
      OnClick = cmbNomeClienteClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 137
    Width = 582
    Height = 231
    Align = alClient
    TabOrder = 2
    ExplicitTop = 140
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 580
      Height = 229
      Align = alClient
      DataSource = dtsContasAReceber
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 368
    Width = 582
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    ExplicitTop = 328
    object Label29: TLabel
      Left = 27
      Top = 9
      Width = 49
      Height = 14
      Caption = 'A vencer'
    end
    object Shape8: TShape
      Left = 11
      Top = 11
      Width = 10
      Height = 9
      Brush.Color = 44544
    end
    object Label27: TLabel
      Left = 135
      Top = 9
      Width = 51
      Height = 14
      Caption = 'Vencidos'
    end
    object Label28: TLabel
      Left = 241
      Top = 9
      Width = 55
      Height = 14
      Caption = 'Vencendo'
    end
    object Label30: TLabel
      Left = 369
      Top = 9
      Width = 64
      Height = 14
      Caption = 'Cancelados'
    end
    object Shape5: TShape
      Left = 120
      Top = 12
      Width = 10
      Height = 9
      Brush.Color = 5197823
    end
    object Shape6: TShape
      Left = 226
      Top = 12
      Width = 10
      Height = 9
      Brush.Color = 16740207
    end
    object Shape9: TShape
      Left = 354
      Top = 12
      Width = 10
      Height = 9
      Brush.Color = 11711154
    end
  end
  object dtsContasAReceber: TDataSource
    DataSet = cdsContasAReceber
    Left = 440
    Top = 216
  end
  object cdsContasAReceber: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dtpVariavel'
    Left = 440
    Top = 264
  end
  object qryVariavel: TSQLQuery
    Params = <>
    Left = 256
    Top = 160
  end
  object dtpVariavel: TDataSetProvider
    DataSet = qryVariavel
    Left = 256
    Top = 216
  end
  object cdsClientes: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 360
    Top = 80
  end
  object dtsClientes: TDataSource
    DataSet = cdsClientes
    Left = 360
    Top = 120
  end
end
