object fmManagerBd: TfmManagerBd
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = #1052#1077#1085#1077#1076#1078#1077#1088' '#1041#1044
  ClientHeight = 570
  ClientWidth = 461
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 461
    Height = 529
    Align = alClient
    TabOrder = 0
    object Grid: TDBGrid
      Left = 1
      Top = 1
      Width = 459
      Height = 527
      Align = alClient
      DataSource = DataSource1
      PopupMenu = PopupMenu1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'NAME'
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          Width = 125
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SMALL_NAME'
          Title.Caption = #1057#1086#1082#1088#1072#1097#1077#1085#1085#1086#1077' '#1085#1072#1079#1074#1072#1085#1080#1077
          Width = 114
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'KOL_CONNECT'
          Title.Caption = #1050#1054#1083#1080#1095#1077#1089#1090#1074#1086' '#1082#1086#1085#1090#1072#1082#1090#1086#1074
          Width = 154
          Visible = True
        end>
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 529
    Width = 461
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 24
      Top = 6
      Width = 129
      Height = 25
      Caption = #1047#1040#1050#1056#1067#1058#1068
      TabOrder = 0
      OnClick = BitBtn1Click
      Kind = bkCancel
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 512
    Top = 256
    object E1: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = E1Click
    end
  end
  object DataS: TIBDataSet
    Database = Data.Database
    Transaction = Data.Transaction
    Left = 200
    Top = 136
  end
  object DataSource1: TDataSource
    DataSet = DataS
    Left = 360
    Top = 152
  end
end
