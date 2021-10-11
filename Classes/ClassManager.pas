unit ClassManager;

interface

uses
  Grids,DBGrids,Classes,
  SysUtils,DateUtils,StdCtrls,types,Graphics,DataModule,classElement,dialogs,Classuzel
  ,CLassPlata;


type
  AElements = array of TElement;
  AUzels = array of TUzel;
  APlats = array of TPlata;
  TManager = class(TObject)  //Класс менеджер
  private
    FElements : AElements;
    FUzels : AUZels;
    FPlats : APlats;
    CountPlats : integer;
    CountElements : integer;
    CountUzels : integer;
    CountMest : integer;
  public
    constructor Create;
    function FindUzel (NAme : string) : integer;   //Найти узел по имени
    function FindElement (Name : string) : integer;//Эл-т по имени
    function FindByPoint (X,Y : integer) : integer;//Эл-т по точкам
    function FindPlatByIndex(I : integer) : integer; //Плату по индексу эл-а
    function FindPlatByKl(I: Integer) : integer;   //плата по клетки сетки
    procedure DeleteAll;
    procedure AddElement(Element : Telement);
    procedure AddPlata(P1,P2 : TPoint);
    procedure DeletePlata(Index : integer);
    procedure DeleteAllPlata;
    procedure DeleteElement(Index : integer);
    procedure AddUzel(NameUzel: string;NumberCon : integer);
    procedure DeleteUzel(Index : integer);
    property ElementsCount : integer read CountElements;
    property PlatsCount : integer read CountPlats;
    property Elements : AElements read FElements;
    property UzelsCount : integer read CountUzels;
    property Uzels : AUzels read FUzels;
    property Plats : APlats read FPlats;
    property CountVakMest : integer read CountMest;
  end;

var Manager : TManager;

implementation

constructor TManager.Create;
begin
  CountElements := 0;
  CountUzels := 0;
  CountPlats := 0;
  CountMest := 0;
end;

procedure TManager.DeleteAllPlata;
begin
  while CountPlats > 0 do
  begin
    DeletePlata(0);
  end;
  CountMest := 0;
end;

procedure TManager.AddPlata(P1: TPoint; P2: TPoint);
begin
  SetLength(FPlats, Length(FPlats) + 1);
  FPlats[CountPlats] := TPlata.Create;
  FPlats[CountPlats].VerhPoint := P1;
  FPlats[CountPlats].NizPoint := P2;
  //TMyKletki[FCountKletki].NameEl := NameEl;
  //ShowMessage(FElements[CountElements].Name);
  FPLats[CountPlats].FindKletka;
  CountMest := CountMest + FPlats[CountPlats].CountKletok;
  Inc(CountPlats);
end;

procedure TManager.DeletePlata(Index: Integer);
begin
  if Index > High(FPlats) then Exit;
  if Index < Low(FPlats) then Exit;
  if Index = High(FPlats) then
  begin
    SetLength(FPlats, Length(FPlats) - 1);
    CountPlats := CountPlats - 1;
    Exit;
  end;
  Finalize(FPlats[Index]);
  System.Move(FPlats[Index +1], FPlats[Index],
              (Length(FPlats) - Index -1) * SizeOf(TPlata) + 1);
  SetLength(FPlats, Length(FPlats) - 1);
  CountPlats := CountPlats - 1;
end;

function TManager.FindByPoint(X: Integer; Y: Integer) : integer;
var Z : integer;
begin
  Z := 0;
  Result := -1;
  while Z < CountElements do
  begin
    if ((X > Elements[Z].VerhPoint.X)and(X < elements[Z].NizPoint.X)
        and(Y > Elements[Z].VerhPoint.Y)and(Y < Elements[Z].NizPoint.Y)) then
    begin
      Result := Z;
    end;
    Inc(Z);
  end;
end;

function Tmanager.FindPlatByIndex(I: Integer) : integer;
var X : integer;
begin
  Result := -1;
  X := 0;
  while X < manager.CountPlats do
  begin
    if Manager.Plats[x].FindKletkaBeEl(I) > -1 then
    begin
      Result := X;
      break;
    end;
    Inc(X);
  end;
end;

function Tmanager.FindPlatByKl(I: Integer) : integer;
var X,Y : integer;
begin
  Result := -1;
  X := 0;
  while X < manager.CountPlats do
  begin
    Y := 0;
    while Y < Manager.Plats[X].CountKletok do
    begin
      if Manager.Plats[x].Kletki[Y]  = I then
      begin
        Result := X;
        Exit;
      end;
    inc(Y);
    end;
    Inc(X);
  end;
end;

procedure TManager.DeleteAll;
begin
  while CountElements >= 1  do
  begin
    DeleteElement(0);
  end;
  while CountUzels >= 1 do
  begin
    DeleteUzel(0);
  end;
end;

function TManager.FindElement(Name: string) : integer;
var X : integer;
    Str : string;
begin
  X := 0;
  Result := -1;
  while X < CountElements do
  begin
    Str := FElements[X].Name;
    if Str = Name then
    begin
      Result := X;
      break;
    end;
    Inc(X);
  end;

end;

function TManager.FindUzel(NAme: string) : integer;
var X : integer;
    Str : string;
begin
  X := 0;
  Result := -1;
  while X < CountUzels do
  begin
    Str := FUzels[X].Name;
    if Str = Name then
    begin
      Result := X;
      break;
    end;
    Inc(X);
  end;
end;

procedure Tmanager.AddElement(Element: TElement);
begin
  SetLength(FElements, Length(FElements) + 1);
  FElements[CountElements] := Telement.Create;
  FElements[CountElements].Copy(Element);
  //ShowMessage(FElements[CountElements].Name);
  Inc(CountElements);
end;

procedure TManager.AddUzel(NameUzel: string; NumberCon: Integer);
var Index : integer;
begin
  Index := FindUzel(NameUzel);
  if Index > -1 then
  begin
    Uzels[Index].AddElement(FElements[CountElements - 1].Name,NumberCon);
  end
  else
  begin
    SetLength(FUzels, Length(FUzels) + 1);
    FUzels[CountUzels] := TUzel.Create;
    FUzels[CountUzels].Name := NameUzel;
    FUzels[CountUzels].AddElement(FElements[CountElements - 1].Name,NumberCon);
    Inc(CountUzels);
  end;

end;

procedure TManager.DeleteUzel(Index: Integer);
begin
  if Index > High(FUzels) then Exit;
  if Index < Low(FUzels) then Exit;
  if Index = High(FUzels) then
  begin
    SetLength(FUzels, Length(FUzels) - 1);
    CountUzels := CountUzels - 1;
    Exit;
  end;
  Finalize(FUzels[Index]);
  System.Move(FUzels[Index +1], FUzels[Index],
              (Length(FUzels) - Index -1) * SizeOf(TUzel) + 1);
  SetLength(FUzels, Length(FUzels) - 1);
  CountUzels := CountUzels - 1;
end;

procedure Tmanager.DeleteElement(Index: Integer);
begin
  //FreeAndNil(Felements[Index]);
  if Index > High(FElements) then Exit;
  if Index < Low(FElements) then Exit;
  if Index = High(FElements) then
  begin
    SetLength(FElements, Length(FElements) - 1);
    CountElements := CountElements - 1;
    Exit;
  end;
  Finalize(FElements[Index]);
  System.Move(FElements[Index +1], FElements[Index],
              (Length(FElements) - Index -1) * SizeOf(TElement) + 1);
  SetLength(FElements, Length(FElements) - 1);
  CountElements := CountElements - 1;
end;

end.
