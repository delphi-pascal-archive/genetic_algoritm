object MainFm: TMainFm
  Left = 244
  Top = 84
  Width = 697
  Height = 700
  Caption = #1043#1077#1085#1077#1090#1080#1095#1077#1089#1082#1080#1081' '#1072#1083#1075#1086#1088#1080#1090#1084
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  ShowHint = True
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 27
    Width = 169
    Height = 619
    Align = alLeft
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 167
      Height = 307
      Align = alClient
      Caption = #1048#1085#1089#1087#1077#1082#1090#1086#1088' '#1101#1083#1077#1084#1077#1085#1090#1086#1074' '#1080' '#1091#1079#1083#1086#1074
      TabOrder = 0
      object Tree: TTreeView
        Left = 2
        Top = 15
        Width = 163
        Height = 290
        Align = alClient
        Indent = 19
        MultiSelect = True
        TabOrder = 0
        OnClick = TreeClick
      end
    end
    object TreeUzel: TTreeView
      Left = 1
      Top = 308
      Width = 167
      Height = 310
      Align = alBottom
      Indent = 19
      PopupMenu = PopupMenu2
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 169
    Top = 27
    Width = 520
    Height = 619
    Align = alClient
    TabOrder = 1
    object Status: TStatusBar
      Left = 1
      Top = 599
      Width = 518
      Height = 19
      Panels = <
        item
          Text = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1101#1083#1077#1084#1077#1085#1090#1086#1074
          Width = 120
        end
        item
          Width = 50
        end
        item
          Text = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1074#1072#1082#1072#1085#1090#1085#1099#1093' '#1084#1077#1089#1090
          Width = 150
        end
        item
          Width = 50
        end
        item
          Text = #1047#1085#1072#1095#1077#1085#1080#1077' '#1094#1077#1083#1077#1074#1086#1081' '#1092#1091#1085#1082#1094#1080#1080
          Width = 150
        end
        item
          Width = 50
        end>
    end
    object Panel4: TPanel
      Left = 1
      Top = 568
      Width = 518
      Height = 31
      Align = alBottom
      TabOrder = 1
      Visible = False
      object Panel5: TPanel
        Left = 421
        Top = 1
        Width = 96
        Height = 29
        Align = alRight
        TabOrder = 0
        object Button2: TButton
          Left = 6
          Top = 5
          Width = 75
          Height = 17
          Caption = #1057#1090#1086#1087
          TabOrder = 0
          OnClick = Button2Click
        end
      end
      object Prog: TProgressBar
        Left = 1
        Top = 1
        Width = 420
        Height = 29
        Align = alClient
        Step = 1
        TabOrder = 1
      end
    end
    object ScrollBox1: TScrollBox
      Left = 1
      Top = 1
      Width = 518
      Height = 567
      HorzScrollBar.ButtonSize = 10
      HorzScrollBar.Range = 3000
      HorzScrollBar.Size = 5
      HorzScrollBar.Tracking = True
      VertScrollBar.ButtonSize = 10
      VertScrollBar.Range = 3000
      Align = alClient
      AutoScroll = False
      TabOrder = 2
      object PaintBox: TImage
        Left = 0
        Top = 0
        Width = 3000
        Height = 3000
        Align = alCustom
        PopupMenu = PopupMenu1
        OnClick = PaintBoxClick
        OnMouseDown = PaintBoxMouseDown
        OnMouseMove = PaintBoxMouseMove
        OnMouseUp = PaintBoxMouseUp
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 689
    Height = 27
    Align = alTop
    TabOrder = 2
    object Button1: TButton
      Left = 3
      Top = 6
      Width = 89
      Height = 15
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1087#1083#1072#1090#1099
      TabOrder = 0
      OnClick = Button1Click
    end
    object btRazm: TButton
      Left = 194
      Top = 5
      Width = 75
      Height = 16
      Caption = #1056#1072#1079#1084#1077#1097#1077#1085#1080#1077
      TabOrder = 1
      OnClick = btRazmClick
    end
    object btRazmCont: TButton
      Left = 571
      Top = 5
      Width = 142
      Height = 16
      Caption = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1100' '#1088#1072#1079#1084#1077#1097#1077#1085#1080#1077
      Enabled = False
      TabOrder = 2
      Visible = False
      OnClick = btRazmContClick
    end
    object btKomp: TButton
      Left = 98
      Top = 5
      Width = 90
      Height = 16
      Caption = #1050#1086#1084#1087#1086#1085#1086#1074#1082#1072
      TabOrder = 3
      OnClick = btKompClick
    end
    object btKompCont: TButton
      Left = 423
      Top = 5
      Width = 142
      Height = 16
      Caption = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1100' '#1082#1086#1084#1087#1086#1085#1086#1074#1082#1091
      Enabled = False
      TabOrder = 4
      Visible = False
      OnClick = btKompContClick
    end
    object Button3: TButton
      Left = 275
      Top = 4
      Width = 75
      Height = 17
      Caption = #1058#1088#1072#1089#1089#1080#1088#1086#1074#1082#1072
      TabOrder = 5
      OnClick = Button3Click
    end
  end
  object ActionList1: TActionList
    Left = 8
    Top = 96
    object actExit: TAction
      Category = 'File'
      Caption = #1042#1099#1093#1086#1076
      Hint = 'Exit'
      OnExecute = actExitExecute
    end
    object actFormReadFile: TAction
      Category = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
      Caption = #1057#1095#1080#1090#1099#1074#1072#1085#1080#1077' '#1092#1072#1081#1083#1072
      Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072
      OnExecute = actFormReadFileExecute
    end
    object actAddElement: TAction
      Category = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1101#1083#1077#1084#1077#1085#1090' '#1074' '#1041#1044
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1101#1083#1077#1084#1077#1085#1090' '#1074' '#1041#1044
      OnExecute = actAddElementExecute
    end
    object actOptionsOpen: TAction
      Category = #1054#1087#1094#1080#1080
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1080#1085#1090#1077#1088#1092#1077#1081#1089#1072
      OnExecute = actOptionsOpenExecute
    end
    object actFormManagerBD: TAction
      Category = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
      Caption = #1052#1077#1085#1077#1076#1078#1077#1088' '#1101#1083#1077#1084#1077#1085#1090#1086#1074' ('#1041#1044')'
      OnExecute = actFormManagerBDExecute
    end
  end
  object MainMenu1: TMainMenu
    Left = 360
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N15: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        OnClick = N15Click
      end
      object N2: TMenuItem
        Action = actExit
      end
    end
    object N3: TMenuItem
      Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
      object N4: TMenuItem
        Action = actFormReadFile
      end
      object actAddElement1: TMenuItem
        Action = actAddElement
      end
      object N7: TMenuItem
        Action = actFormManagerBD
      end
    end
    object N5: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      object N6: TMenuItem
        Action = actOptionsOpen
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      end
      object N8: TMenuItem
        AutoCheck = True
        Caption = #1048#1085#1089#1087#1077#1082#1090#1086#1088
        Checked = True
        OnClick = N8Click
      end
      object N11: TMenuItem
        AutoCheck = True
        Caption = #1054#1090#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1089#1077#1090#1082#1080
        Checked = True
        OnClick = N11Click
      end
      object N12: TMenuItem
        AutoCheck = True
        Caption = #1055#1088#1080#1074#1103#1079#1082#1072
        Checked = True
        OnClick = N12Click
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 400
    Top = 160
    object N9: TMenuItem
      Caption = #1055#1086#1074#1077#1088#1085#1091#1090#1100
      OnClick = N9Click
    end
    object N13: TMenuItem
      Caption = #1047#1072#1076#1072#1090#1100' '#1086#1096#1080#1073#1082#1091
      Visible = False
      OnClick = N13Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 56
    Top = 312
    object N10: TMenuItem
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1101#1083#1077#1084#1077#1085#1090#1099
      OnClick = N10Click
    end
    object N14: TMenuItem
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1090#1088#1072#1089#1089#1091
      OnClick = N14Click
    end
  end
  object Time: TTimer
    Enabled = False
    Interval = 1
    OnTimer = TimeTimer
    Left = 40
    Top = 96
  end
  object Time2: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Time2Timer
    Left = 72
    Top = 96
  end
  object Save: TSaveDialog
    Left = 176
    Top = 32
  end
end
