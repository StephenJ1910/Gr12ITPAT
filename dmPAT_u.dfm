object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 227
  Width = 425
  object conPATDB: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Users\Nandia1\Do' +
      'cuments\SSIR Delphi IT 2023\PAT\PAT code\PAT.mdb;Persist Securit' +
      'y Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 24
    Top = 24
  end
  object tblUsers: TADOTable
    Active = True
    Connection = conPATDB
    CursorType = ctStatic
    TableName = 'Table_User'
    Left = 112
    Top = 24
  end
  object tblOrders: TADOTable
    Active = True
    Connection = conPATDB
    CursorType = ctStatic
    TableName = 'Table_Orders'
    Left = 112
    Top = 88
  end
  object dsUsers: TDataSource
    DataSet = tblUsers
    Left = 160
    Top = 24
  end
  object dsOrders: TDataSource
    DataSet = tblOrders
    Left = 208
    Top = 88
  end
  object tblActivities: TADOTable
    Active = True
    Connection = conPATDB
    CursorType = ctStatic
    TableName = 'Table_ActivitiesBooked'
    Left = 112
    Top = 152
  end
  object dsActivities: TDataSource
    DataSet = tblActivities
    Left = 208
    Top = 152
  end
  object qrGen: TADOQuery
    Connection = conPATDB
    Parameters = <>
    Left = 312
    Top = 24
  end
  object dsGen: TDataSource
    DataSet = qrGen
    Left = 312
    Top = 152
  end
  object dsSub: TDataSource
    DataSet = qrSub
    Left = 360
    Top = 152
  end
  object qrSub: TADOQuery
    Connection = conPATDB
    Parameters = <>
    Left = 360
    Top = 24
  end
  object qrUser: TADOQuery
    Connection = conPATDB
    Parameters = <>
    Left = 208
    Top = 24
  end
end
