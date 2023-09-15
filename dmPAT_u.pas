unit dmPAT_u;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TDataModule1 = class(TDataModule)
    conPATDB: TADOConnection;
    tblUsers: TADOTable;
    tblOrders: TADOTable;
    dsUsers: TDataSource;
    dsOrders: TDataSource;
    tblActivities: TADOTable;
    dsActivities: TDataSource;
    qrGen: TADOQuery;
    dsGen: TDataSource;
    dsSub: TDataSource;
    qrSub: TADOQuery;
    qrUser: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmPAT: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
