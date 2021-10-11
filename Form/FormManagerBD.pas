unit FormManagerBD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, DBGrids, ExtCtrls, DB, IBCustomDataSet,DataModule,
  StdCtrls, Buttons;

type
  TfmManagerBd = class(TForm)
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    Grid: TDBGrid;
    E1: TMenuItem;
    DataS: TIBDataSet;
    DataSource1: TDataSource;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure E1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure Prepare;
  public
    { Public declarations }
  end;

var
  fmManagerBd: TfmManagerBd;

implementation

{$R *.dfm}

procedure TfmManagerBd.BitBtn1Click(Sender: TObject);
begin
 Close;
end;

procedure TfmManagerBd.E1Click(Sender: TObject);
var ID : integer;
begin
  ID := Grid.Fields[0].AsInteger;
  Data.DataSet.Active := false;
  with Data do
  begin
    Dataset.SelectSQL.Clear;
    DataSet.SelectSQL.Add('delete from LINK_ELEMENT_CONNECT where FK_TABLE_ELEMENT = :F');
    DataSet.ParamByName('F').AsInteger := ID;
    DataSet.ExecSQL;
    CommitTr;
    DataSet.Active := false;
    Dataset.SelectSQL.Clear;
    DataSet.SelectSQL.Add('delete from TABLE_ELEMENT where ID = :ID');
    DataSet.ParamByName('ID').AsInteger := ID;
    DataSet.ExecSQL;
    CommitTr;
    DataSet.Active := false;
  end;
  Prepare;
end;

procedure TfmManagerBd.FormCreate(Sender: TObject);
begin
  Prepare;
end;

procedure TfmManagerBd.FormDestroy(Sender: TObject);
begin
  DataS.Active := false;
end;

procedure TfmManagerBd.Prepare;
begin
  DataS.Active := false;
  DataS.SelectSQL.Clear;
  DataS.SelectSQL.Add('select * from TABLE_ELEMENT_S_ALL');
  DataS.Active := true;
end;

end.
