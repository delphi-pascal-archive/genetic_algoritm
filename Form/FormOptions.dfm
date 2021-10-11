object fmOptions: TfmOptions
  Left = 0
  Top = 0
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 382
  ClientWidth = 609
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 609
    Height = 332
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1080#1079' '#1092#1072#1081#1083#1072
      object cbShowDialogNotElement: TCheckBox
        Left = 0
        Top = 11
        Width = 301
        Height = 17
        Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1076#1080#1072#1083#1086#1075' '#1086'  '#1085#1077#1086#1073#1085#1072#1088#1091#1078#1077#1085#1080#1080' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1074' '#1041#1044
        TabOrder = 0
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1075#1077#1085#1077#1090#1080#1095#1077#1089#1082#1086#1075#1086' '#1072#1083#1075#1086#1088#1080#1090#1084#1072
      ImageIndex = 2
      object Label1: TLabel
        Left = 16
        Top = 96
        Width = 370
        Height = 13
        Caption = 
          #1054#1089#1090#1072#1085#1072#1074#1083#1080#1074#1072#1090#1100' '#1086#1073#1091#1095#1077#1085#1080#1077' '#1077#1089#1083#1080' '#1094#1077#1083#1077#1074#1072#1103' '#1092#1091#1085#1082#1094#1080#1103' '#1085#1077' '#1084#1077#1085#1103#1083#1072#1089#1100' '#1074' '#1090#1077#1095#1077#1085#1080 +
          #1080' '
      end
      object Label2: TLabel
        Left = 431
        Top = 96
        Width = 25
        Height = 13
        Caption = #1069#1087#1086#1093
      end
      object edInversion: TLabeledEdit
        Left = 12
        Top = 24
        Width = 121
        Height = 21
        EditLabel.Width = 115
        EditLabel.Height = 13
        EditLabel.Caption = #1042#1077#1088#1086#1103#1090#1085#1086#1089#1090#1100' '#1080#1085#1074#1077#1088#1089#1080#1080
        TabOrder = 0
      end
      object edMutation: TLabeledEdit
        Left = 12
        Top = 64
        Width = 121
        Height = 21
        EditLabel.Width = 110
        EditLabel.Height = 13
        EditLabel.Caption = #1042#1077#1088#1086#1103#1090#1085#1086#1089#1090#1100' '#1084#1091#1090#1072#1094#1080#1080
        TabOrder = 1
      end
      object edEpoh: TEdit
        Left = 392
        Top = 88
        Width = 33
        Height = 21
        TabOrder = 2
      end
      object cbAlgDraw: TCheckBox
        Left = 156
        Top = 28
        Width = 273
        Height = 17
        Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1087#1088#1086#1088#1080#1089#1086#1074#1082#1091' '#1087#1077#1088#1077#1084#1077#1097#1077#1085#1080#1103' '#1101#1083#1077#1084#1077#1085#1090#1086#1074
        TabOrder = 3
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 332
    Width = 609
    Height = 50
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 24
      Top = 6
      Width = 113
      Height = 31
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 0
      OnClick = BitBtn1Click
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 160
      Top = 6
      Width = 113
      Height = 31
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      Kind = bkCancel
    end
  end
end
