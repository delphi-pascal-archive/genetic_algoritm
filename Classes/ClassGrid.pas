unit ClassGrid;

interface

uses
  Grids,DBGrids,
  SysUtils,DateUtils,StdCtrls,types,Graphics,DataModule,comctrls,ClassOptions
  ,ClassElement,dialogs;


type
  TMyKletka = class(TObject)
  private

  public
    VerhPoint : Tpoint;
    IsElement : boolean;
    NameEl : string;
  end;

  AMyKletki = array of TMyKletka;

  TMyGrid = class(TObject)    //Класс сетки
  private
    TMyKletki : AMyKletki;
    FCountKletki : integer;
    Grid : TBitmap;
  public
    constructor Create(H,W : integer);
    destructor Destroy;
    procedure DrawGrid;
    procedure DeleteAll;
    procedure ClearKletka(Name : string);
    procedure CheckKletka(Name : string);
    function CheckZone(Name : string) : boolean;
    function FindKletkaByName(Name : string) : integer; //Найти клетку в которой элемент
    procedure AddKletki (Point : TPoint);   //Добавить клетку
    procedure DeleteKletka (Index : integer); //Удалить клетку
    procedure SnapToGrid (El : Telement); //Привязать элемент к сетке
    Function SnapToGridPoint(Point : Tpoint) : Tpoint;   //Привязать по координатам
    function FindEmptyKletka(Point : Tpoint) : integer; //Найти пустую клетку
    function FindKletka(Point : Tpoint) : integer;   //Найти клетку по координатам
    property Kletki : AMyKletki read TMyKletki write TMyKletki;
    property CountKletki : integer read FCountKletki;
    property MyGrid : TBitmap read Grid;
  end;

implementation

uses ClassManager;

procedure TMyGrid.CheckKletka(Name: string);
var X : integer;
    P1,P2 : Tpoint;
begin
 X := 0;
 P1 := Manager.Elements[Manager.FindElement(Name)].VerhPoint;
 P2 := Manager.Elements[Manager.FindElement(Name)].NizPoint;
 while X < CountKletki do
  begin
    if (Kletki[X].VerhPoint.X >= P1.X)and
        (Kletki[X].VerhPoint.Y >= P1.Y) and
        (Kletki[X].VerhPoint.X + ShagSetk <= P2.X)and
        (Kletki[X].VerhPoint.Y + ShagSetk <= P2.Y) then
        Kletki[X].IsElement := true;
     inc(X);
  end;
end;

function TMyGrid.CheckZone(Name: string) : boolean;
var  X : integer;
    P1,P2 : Tpoint;
begin
  X := 0;
  Result := false;
  P1 := Manager.Elements[Manager.FindElement(Name)].VerhPoint;
  P2 := Manager.Elements[Manager.FindElement(Name)].NizPoint;
  while X < CountKletki do
  begin
    if (Kletki[X].VerhPoint.X >= P1.X)and
        (Kletki[X].VerhPoint.Y >= P1.Y) and
        (Kletki[X].VerhPoint.X + ShagSetk <= P2.X)and
        (Kletki[X].VerhPoint.Y + ShagSetk <= P2.Y) then
    begin
      if Kletki[X].IsElement then
      begin
        Result := true;
        break;
      end;
    end;
    Inc(X);
  end;
end;

procedure TmyGrid.ClearKletka(Name : string);
var X : integer;
begin
  X := 0;
  while X < CountKletki do
  begin
    if Kletki[X].NameEl = name then
     Kletki[X].IsElement := false;
     inc(X);
  end;
end;

constructor TMyGrid.Create(H,W : integer);
begin
  Grid := TBitMap.Create;
  Grid.Height := H;
  Grid.Width := W;
  Grid.Transparent := false;
  FCountKletki := 0;
end;

procedure TmyGrid.DeleteAll;
begin
  while CountKletki > 0 do
  begin
    DeleteKletka(0);
  end;
end;

destructor TMyGrid.Destroy;
begin
  FreeAndNil(Grid);
end;

function TMyGrid.SnapToGridPoint(Point: TPoint) : TPoint;
var Temp  : Integer;
begin
  Result.X := -1;
  Result.Y := -1;
  Temp := FindKletka(Point);
  Result.X := Kletki[Temp].VerhPoint.X;
  Result.Y := Kletki[Temp].VerhPoint.Y;
end;

function TMyGrid.FindEmptyKletka(Point : Tpoint) : integer;
var X : integer;
    TempIndex : integer;
begin
  X := 0;
  Result := -1;
  while X < 100 do
  begin
    Point.X := Point.X - ShagSetk;
    TempIndex := FindKletka(Point);
    if TempIndex > -1 then
    begin
      if not Kletki[TEmpIndex].IsElement then
      begin
        Result := TempIndex;
        break;
      end;
    end;
    Point.Y := Point.Y - ShagSetk;
    TempIndex := FindKletka(Point);
    if TempIndex > -1 then
    begin
      if not Kletki[TEmpIndex].IsElement then
      begin
        Result := TempIndex;
        break;
      end;
    end
    else
    begin
      Result := 1;
    end;
    Inc(X);
  end;
end;

function TMyGrid.FindKletkaByName(Name : string) : integer;
var X : integer;
begin
  X := 0;
  Result := -1;
  while X < FCountKletki do
  begin
    if Kletki[X].NameEl = Name then
    begin
      Result := X;
      break;
    end;
    Inc(X);
  end;
end;

procedure TMyGrid.SnapToGrid(El: TElement);
var Kletka : integer;
    TempKletka : integer;
    P : TPoint;
begin
  Kletka := FindKletka(El.VerhPoint);
  if Kletka > -1 then
  begin
    if not Kletki[Kletka].IsElement then
    //if not CheckZone(El.Name) then
    begin
      TempKletka := FindKletkaByName(El.Name);
      if TempKletka > -1 then
      begin
        Kletki[TempKletka].NameEl := '';
        Kletki[TempKletka].IsElement := false;
//        ShowMessage(Kletki[TempKletka].NameEl);
      end;
      El.VerhPoint := Kletki[Kletka].VerhPoint;
      Kletki[Kletka].IsElement := true;
      Kletki[Kletka].NameEl := El.Name;
//      ShowMessage(Kletki[Kletka].NameEl);
    end
    else
    begin
      TempKletka := FindKletkaByName(El.Name);
      if TempKletka > -1 then
      begin
        Kletki[TempKletka].NameEl := '';
        Kletki[TempKletka].IsElement := false;
//        ShowMessage(Kletki[TempKletka].NameEl);
      end;
      if Kletki[Kletka].NameEl = el.Name then
      begin
        P.X :=  Kletki[Kletka].VerhPoint.X + 1;
        P.Y :=  Kletki[Kletka].VerhPoint.Y + 1;
        El.VerhPoint := P;
        Kletki[Kletka].IsElement := true;
        Kletki[Kletka].NameEl := El.Name;
//        ShowMessage(Kletki[Kletka].NameEl);
      end
      else
      begin
        TempKletka := FindEmptyKletka(El.VerhPoint);
        El.VerhPoint := Kletki[TempKletka].VerhPoint;
        Kletki[TempKletka].IsElement := true;
        Kletki[TempKletka].NameEl := El.Name;
//        ShowMessage(Kletki[TempKletka].NameEl);
      end;
    end;
  end;
end;

function TmyGrid.FindKletka(Point: TPoint) : integer;
var X : integer;
begin
  X := 0;
  result := -1;
  while X < CountKletki do
  begin
    if (Point.X >= Kletki[X].VerhPoint.X)and(Point.Y >= Kletki[X].VerhPoint.Y)
        and(Point.X <= Kletki[X].VerhPoint.X + ShagSetk)and(Point.Y <= Kletki[X].VerhPoint.Y + ShagSetk) then
    begin
      Result := X;
      break;
    end;
    Inc(X);
  end;               
end;


procedure TMyGrid.DrawGrid;
var I: integer;
    P : TPoint;
begin
    Grid.Canvas.Brush.Color := clWhite;
    Grid.Canvas.Rectangle(0,0,Grid.Width,Grid.Height);
    Grid.Canvas.Pen.Color := clGray;
    Grid.Canvas.Pen.Style := psDot;
    Grid.Canvas.Pen.Width := 1;
    I := 0;
    while I < Grid.Height  do
    begin
      Grid.Canvas.MoveTo(0,I);
      Grid.Canvas.LineTo(Grid.Width,I);
      I := I +ShagSetk;
    end;
    I := 0;
    while I < Grid.Width  do
    begin
      Grid.Canvas.MoveTo(I,0);
      Grid.Canvas.LineTo(I,Grid.Height);
      I := I + ShagSetk;
    end;
    I := 0;
    P.X := 0;
    P.Y := 0;
//    if Manager.PlatsCount  < 1 then
//    begin
      while P.Y < Grid.Height do
      begin
        AddKletki(P);
        P.X := P.X + ShagSetk;
        if P.X > Grid.Width then
        begin
          P.X := 0;
          P.Y := P.Y + ShagSetk;
        end;
      end;
    {end
    else
    begin
      if (Manager.Plats[0].NizPoint.X - Manager.Plats[0].VerhPoint.X)<=
      (Manager.Plats[0].NizPoint.Y - Manager.Plats[0].VerhPoint.Y) then
      begin
        while P.Y < Grid.Height do
        begin
          AddKletki(P);
          P.X := P.X + ShagSetk;
          if P.X > Grid.Width then
          begin
            P.X := 0;
            P.Y := P.Y + ShagSetk;
          end;
        end;
      end
      else
      begin
        while P.X < Grid.Width do
        begin
          AddKletki(P);
          P.Y := P.Y + ShagSetk;
          if P.Y > Grid.Height then
          begin
            P.Y := 0;
            P.X := P.X + ShagSetk;
          end;
        end;
      end;
    end;  }
end;

procedure TMyGrid.AddKletki(Point: TPoint);
begin
  SetLength(TMyKletki, Length(TMyKletki) + 1);
  TMyKletki[FCountKletki] := TMyKletka.Create;
  TMyKletki[FCountKletki].VerhPoint := Point;
  TMyKletki[FCountKletki].NameEl := '';
  //ShowMessage(FElements[CountElements].Name);
  Inc(FCountKletki);
end;

procedure TMyGrid.DeleteKletka(Index: Integer);
begin
  if Index > High(TMyKletki) then Exit;
  if Index < Low(TMyKletki) then Exit;
  if Index = High(TMyKletki) then
  begin
    SetLength(TMyKletki, Length(TMyKletki) - 1);
    FCountKletki := FCountKletki - 1;
    Exit;
  end;
  Finalize(TMyKletki[Index]);
  System.Move(TMyKletki[Index +1], TMyKletki[Index],
              (Length(TMyKletki) - Index -1) * SizeOf(TMyKletka) + 1);
  SetLength(TMyKletki, Length(TMyKletki) - 1);
  FCountKletki := FCountKletki - 1;
end;

end.
