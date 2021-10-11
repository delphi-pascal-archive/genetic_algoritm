object fmAddElement: TfmAddElement
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1074' '#1041#1044
  ClientHeight = 280
  ClientWidth = 533
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 533
    Height = 238
    Align = alClient
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 531
      Height = 236
      Align = alClient
      Caption = #1057#1074#1086#1081#1089#1090#1074#1072' '#1101#1083#1077#1084#1077#1085#1090#1072
      TabOrder = 0
      object Normal: TImage
        Left = 192
        Top = 21
        Width = 137
        Height = 117
        Transparent = True
      end
      object Rotate: TImage
        Left = 360
        Top = 21
        Width = 137
        Height = 117
        Transparent = True
      end
      object Label1: TLabel
        Left = 192
        Top = 144
        Width = 131
        Height = 13
        Caption = #1053#1086#1088#1084#1072#1083#1100#1085#1086#1077' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
      end
      object Label2: TLabel
        Left = 366
        Top = 144
        Width = 131
        Height = 13
        Caption = #1055#1086#1074#1077#1088#1085#1091#1090#1086#1077' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
      end
      object edName: TLabeledEdit
        Left = 24
        Top = 40
        Width = 121
        Height = 21
        EditLabel.Width = 98
        EditLabel.Height = 13
        EditLabel.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1101#1083#1077#1084#1077#1085#1090#1072
        TabOrder = 0
      end
      object edShortName: TLabeledEdit
        Left = 24
        Top = 88
        Width = 121
        Height = 21
        EditLabel.Width = 111
        EditLabel.Height = 13
        EditLabel.Caption = #1050#1088#1072#1090#1082#1086#1077' '#1086#1073#1086#1079#1085#1072#1095#1077#1085#1080#1077
        TabOrder = 1
      end
      object edKolConnect: TLabeledEdit
        Left = 24
        Top = 136
        Width = 121
        Height = 21
        EditLabel.Width = 92
        EditLabel.Height = 13
        EditLabel.Caption = #1050#1086#1083'-'#1074#1086' '#1082#1086#1085#1090#1072#1082#1090#1086#1074
        TabOrder = 2
      end
      object btAddNormalPicture: TButton
        Left = 192
        Top = 163
        Width = 137
        Height = 25
        Caption = #1042#1099#1073#1088#1072#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
        TabOrder = 3
        OnClick = btAddNormalPictureClick
      end
      object btAddConnectN: TButton
        Left = 192
        Top = 194
        Width = 137
        Height = 25
        Caption = #1053#1072#1079#1085#1072#1095#1080#1090#1100' '#1082#1086#1085#1090#1072#1082#1090#1099
        TabOrder = 4
        OnClick = btAddConnectNClick
      end
      object btAddRotatePicture: TButton
        Left = 360
        Top = 163
        Width = 137
        Height = 25
        Caption = #1042#1099#1073#1088#1072#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
        TabOrder = 5
        OnClick = btAddRotatePictureClick
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 238
    Width = 533
    Height = 42
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 25
      Top = 5
      Width = 121
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 0
      OnClick = BitBtn1Click
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 161
      Top = 5
      Width = 121
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      OnClick = BitBtn2Click
      Kind = bkCancel
    end
  end
  object Open: TOpenPictureDialog
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    InitialDir = 
      'C:\Documents and Settings\'#1042#1072#1076#1080#1084'\'#1052#1086#1080' '#1076#1086#1082#1091#1084#1077#1085#1090#1099'\Borland Studio Pro' +
      'jects\ProgGenAlg'
    Left = 328
    Top = 16
  end
end
