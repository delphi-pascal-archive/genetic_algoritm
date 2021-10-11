unit ClassUzel;

interface

uses
  Grids,DBGrids,
  SysUtils,DateUtils,StdCtrls,types,Graphics,DataModule,comctrls;


type
  TElementUzel = class(TObject)
  public
    Name : string;
    NumberConnect : integer;
  end;

  AElementsUzel = array of TELementUzel;

  TUzel = class(TObject)   //Класс узлов
  private
    FName : string;
    FElements : AElementsUzel;
    FCountElements : integer;
  public
    constructor Create;
    function KolElInUze(NameEl : string) : integer;
    function FindElement(NAmeEl : string) : integer; //Найти элемент
    procedure AddElement(NameEl : string;NumberCon : integer);
    procedure DeleteElement (Index : integer);
    property Name : string read FName write FName;
    property Elements : AElementsUzel read FElements;
    property CountElements : integer read FCountElements;
  end;

implementation

constructor TUzel.Create;
begin
  FCountElements := 0;
end;

function TUzel.KolElInUze(NameEl: string) : integer;
var X,Temp : integer;
begin
  Result := -1;
  X := 0;
  Temp := 0;
  while X < CountElements do
  begin
    if Elements[X].Name = NameEl then
    begin
      Inc(Temp);
    end;
    Inc(X);
  end;
  Result := Temp;
end;

procedure TUzel.AddElement(NameEl: string; NumberCon: Integer);
begin
  SetLength(FElements, Length(FElements) + 1);
  FElements[CountElements] := TelementUzel.Create;
  FElements[CountElements].Name := NameEl;
  FElements[CountElements].NumberConnect := NumberCon;
  //ShowMessage(FElements[CountElements].Name);
  Inc(FCountElements);
end;

procedure TUzel.DeleteElement(Index: Integer);
begin
  if Index > High(FElements) then Exit;
  if Index < Low(FElements) then Exit;
  if Index = High(FElements) then
  begin
    SetLength(FElements, Length(FElements) - 1);
    FCountElements := FCountElements - 1;
    Exit;
  end;
  Finalize(FElements[Index]);
  System.Move(FElements[Index +1], FElements[Index],
              (Length(FElements) - Index -1) * SizeOf(TElementUzel) + 1);
  SetLength(FElements, Length(FElements) - 1);
  FCountElements := FCountElements - 1;
end;

function TUzel.FindElement(NAmeEl: string) : integer;
var X : integer;
begin
  X := 0;
  Result := -1;
  while X < CountElements  do
  begin
    if FElements[X].Name = NameEl then
    begin
      Result := X;
      break;
    end;
  Inc(X);
  end;
end;

end.
