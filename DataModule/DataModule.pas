unit DataModule;

interface

uses
  SysUtils, Classes, IBDatabase, DB, IBCustomDataSet;

type
  TData = class(TDataModule)
    Database: TIBDatabase;
    Transaction: TIBTransaction;
    DataSet: TIBDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CommitTr;
  end;

var
  Data: TData;

implementation

{$R *.dfm}

procedure TData.CommitTr;
begin
  Transaction.Commit;
  Transaction.StartTransaction;
end;

end.
