object DMBanco: TDMBanco
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 106
  Width = 382
  object FDConnection: TFDConnection
    Params.Strings = (
      'CharacterSet=ISO8859_1'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 40
    Top = 16
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 136
    Top = 16
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnection
    Left = 176
    Top = 40
  end
end
