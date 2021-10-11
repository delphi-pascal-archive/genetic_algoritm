unit fmAddConnect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, StdCtrls, Buttons;

type
  TFormAddConnect = class(TForm)
    Image: TImage;
    Grid: TStringGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Kol : integer;
  end;

var
  FormAddConnect: TFormAddConnect;

implementation

{$R *.dfm}

uses FormAddElement;

procedure TFormAddConnect.BitBtn1Click(Sender: TObject);
var X : integer;
    Point : TPoint;
begin
  X := 1;
  while X < Grid.RowCount do
  begin
    Point.X := StrToInt(Grid.Cells[1,X]);
    Point.Y := StrToInt(Grid.Cells[2,X]);
    Element.AddPointConnect(Point);
    Inc(X);
  end;
end;

procedure TFormAddConnect.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TFormAddConnect.FormCreate(Sender: TObject);
begin
  Grid.Cells[1,0] := 'X';
  Grid.Cells[2,0] := 'Y';
  Kol := 1;
end;

procedure TFormAddConnect.ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin
  if Kol < Grid.RowCount then
  begin
    Grid.Cells[1,Kol] := IntTostr(X);
    Grid.Cells[2,Kol] := IntToStr(Y);
    Grid.Cells[0,Kol] := IntToStr(Kol);
    Inc(Kol);
  end;
end;

end.
