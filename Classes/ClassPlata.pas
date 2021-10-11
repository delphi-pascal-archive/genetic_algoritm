unit ClassPlata;

interface

uses
  Grids,DBGrids,
  SysUtils,DateUtils,StdCtrls,types,Graphics,DataModule,comctrls,ClassOptions,
  ClassGrid;


type
  AKletkaPlata = array of integer;
  TPlata = class(TObject)   //Класс плат
  private
    FVerhPoint : TPoint;
    FNizPoint : TPoint;
  public
    Kletki : AKletkaPlata;
    CountKletok : integer;
    constructor Create;
    procedure AddKletka(Index : integer); //Добавить клетку
    procedure FindKletka;//Найти все клетки в плате
    function FindKletkaBeEl (I : integer) : integer;//Найти клетку на плате по эл-ту
    procedure DeleteKletka (Index : integer);//Удалить клетку
    property VerhPoint : TPoint read FVerhPoint write FVerhPoint;
    property NizPoint : TPoint read FNizPoint write FNizPoint;
  end;

implementation

uses ClassDraw,ClassManager;

constructor TPlata.Create;
begin
  CountKletok := 0;
end;

function Tplata.FindKletkaBeEl(I: Integer) : integer;
var X : integer;
begin
  X := 0;
  Result := -1;
  try
  while X < CountKletok do
  begin
    if I > -1 then    
    if MyGrid.Kletki[Kletki[x]].NameEl = Manager.Elements[I].Name then
    begin
      Result := X;
      break;
    end;
    Inc(X);
  end;
  except

  end;
end;

procedure TPlata.AddKletka(Index : integer);
begin
  SetLength(Kletki, Length(Kletki) + 1);
  Kletki[CountKletok] := Index;
  //TMyKletki[FCountKletki].NameEl := NameEl;
  //ShowMessage(FElements[CountElements].Name);
  Inc(CountKletok);
end;

procedure TPlata.DeleteKletka(Index: Integer);
begin
  if Index > High(Kletki) then Exit;
  if Index < Low(Kletki) then Exit;
  if Index = High(Kletki) then
  begin
    SetLength(Kletki, Length(Kletki) - 1);
    CountKletok := CountKletok - 1;
    Exit;
  end;
  Finalize(Kletki[Index]);
  System.Move(Kletki[Index +1], Kletki[Index],
              (Length(Kletki) - Index -1) * SizeOf(TMyKletka) + 1);
  SetLength(Kletki, Length(Kletki) - 1);
  CountKletok := CountKletok - 1;
end;

procedure TPlata.FindKletka;
var X : integer;
    P : TPoint;
begin
  X := 0;
  VerhPoint := MyGrid.SnapToGridPoint(VerhPoint);
  P.X := MyGrid.SnapToGridPoint(NizPoint).X + ShagSetk;
  P.Y := MyGrid.SnapToGridPoint(NizPoint).Y + ShagSetk;
  NizPoint := P;
  while X < MyGrid.CountKletki do
  begin
    if (MyGrid.Kletki[X].VerhPoint.X >= VerhPoint.X)and
        (MyGrid.Kletki[X].VerhPoint.Y >= VerhPoint.Y) and
        (MyGrid.Kletki[X].VerhPoint.X + ShagSetk <= NizPoint.X)and
        (MyGrid.Kletki[X].VerhPoint.Y + ShagSetk <= NizPoint.Y) then
    begin
      AddKletka(X);
    end;
    Inc(X);
  end;
end;

end.
