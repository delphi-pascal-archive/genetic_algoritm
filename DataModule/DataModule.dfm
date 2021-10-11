object Data: TData
  OldCreateOrder = False
  Height = 216
  Width = 367
  object Database: TIBDatabase
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    DefaultTransaction = Transaction
    Left = 112
    Top = 24
  end
  object Transaction: TIBTransaction
    DefaultDatabase = Database
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 56
    Top = 80
  end
  object DataSet: TIBDataSet
    Database = Database
    Transaction = Transaction
    Left = 200
    Top = 72
  end
end
