object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 415
  ClientWidth = 667
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object CEP: TLabel
    Left = 24
    Top = 72
    Width = 19
    Height = 13
    Caption = 'CEP'
  end
  object Label1: TLabel
    Left = 200
    Top = 69
    Width = 13
    Height = 13
    Caption = 'UF'
  end
  object Label2: TLabel
    Left = 288
    Top = 72
    Width = 38
    Height = 13
    Caption = 'CIDADE'
  end
  object Label3: TLabel
    Left = 448
    Top = 72
    Width = 55
    Height = 13
    Caption = 'Logradouro'
  end
  object RadioGroup1: TRadioGroup
    Left = 24
    Top = 8
    Width = 617
    Height = 41
    Caption = 'Tipo do Retorno de Consulta '
    Columns = 2
    ItemIndex = 1
    Items.Strings = (
      'XML'
      'Json')
    TabOrder = 0
  end
  object BtConsultar: TButton
    Left = 288
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Consultar'
    TabOrder = 1
    OnClick = BtConsultarClick
  end
  object Edit1: TEdit
    Left = 24
    Top = 88
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object DBGrid1: TDBGrid
    Left = 24
    Top = 184
    Width = 617
    Height = 217
    DataSource = dsCep
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CEP'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Logradouro'
        Title.Caption = 'LOGRADOURO'
        Width = 140
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Complemento'
        Title.Caption = 'COMPLEMENTO'
        Width = 92
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Bairro'
        Title.Caption = 'BAIRRO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'localidade'
        Title.Caption = 'LOCALIDADE'
        Width = 114
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UF'
        Title.Caption = 'ESTADO'
        Visible = True
      end>
  end
  object edUF: TEdit
    Left = 200
    Top = 88
    Width = 49
    Height = 21
    TabOrder = 4
  end
  object edCidade: TEdit
    Left = 288
    Top = 88
    Width = 145
    Height = 21
    TabOrder = 5
  end
  object edLogradouro: TEdit
    Left = 448
    Top = 88
    Width = 193
    Height = 21
    TabOrder = 6
  end
  object dsCep: TDataSource
    Left = 607
    Top = 216
  end
end
