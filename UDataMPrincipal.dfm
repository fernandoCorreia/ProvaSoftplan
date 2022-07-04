object uDMPrincipal: TuDMPrincipal
  OldCreateOrder = False
  Height = 150
  Width = 215
  object FDConexao: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=D:\TesteEmpresa\TESTESOFTLPAN.FDB'
      'CharacterSet=WIN1252')
    Connected = True
    Left = 64
    Top = 24
  end
  object qryCep: TFDQuery
    Connection = FDConexao
    SQL.Strings = (
      'select * from VIACEP')
    Left = 24
    Top = 80
    object qryCepCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryCepCEP: TIntegerField
      FieldName = 'CEP'
      Origin = 'CEP'
    end
    object qryCepLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Origin = 'LOGRADOURO'
      Size = 100
    end
    object qryCepCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Origin = 'COMPLEMENTO'
      Size = 100
    end
    object qryCepBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      Size = 50
    end
    object qryCepLOCALIDADE: TStringField
      FieldName = 'LOCALIDADE'
      Origin = 'LOCALIDADE'
      Size = 100
    end
    object qryCepUF: TStringField
      FieldName = 'UF'
      Origin = 'UF'
      FixedChar = True
      Size = 2
    end
  end
  object InsCep: TFDCommand
    Connection = FDConexao
    Transaction = FDTransaction1
    CommandText.Strings = (
      ''
      
        'INSERT INTO VIACEP (CODIGO, CEP, LOGRADOURO, COMPLEMENTO, BAIRRO' +
        ', LOCALIDADE, UF) '
      'VALUES '
      '(:CODIGO, '
      ' :CEP, '
      ' :LOGRADOURO,'
      ' :COMPLEMENTO,'
      ' :BAIRRO , '
      ' :LOCALIDADE, '
      ' :UF);')
    ParamData = <
      item
        Name = 'CODIGO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'CEP'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'LOGRADOURO'
        DataType = ftString
        ParamType = ptInput
        Size = 100
      end
      item
        Name = 'COMPLEMENTO'
        DataType = ftString
        ParamType = ptInput
        Size = 100
      end
      item
        Name = 'BAIRRO'
        DataType = ftString
        ParamType = ptInput
        Size = 50
      end
      item
        Name = 'LOCALIDADE'
        DataType = ftString
        ParamType = ptInput
        Size = 100
      end
      item
        Name = 'UF'
        DataType = ftFixedChar
        ParamType = ptInput
        Size = 2
      end>
    Left = 144
    Top = 40
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConexao
    Left = 136
    Top = 88
  end
end
