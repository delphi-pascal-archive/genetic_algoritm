unit ClassMatrR;

interface

uses
  Grids,DBGrids,dialogs,
  SysUtils,DateUtils,StdCtrls,types,Graphics,DataModule,comctrls,ClassManager;

type

  TZapMAssiva = class(TObject)
  private
    FName : string;
  public
    ZnachR : integer;
    property Name : string read FName write FName;
  end;

  AZapisi = array of TZapMAssiva;

  TMatrR = Class(TObject)
  private
    FName : string;
    KolZapis : integer;
  public
    Zapisi : AZapisi;
    constructor Create(NameEl : string);
    procedure SetMatrR;
    procedure AddZapis(Name : string;Znach : integer);
    procedure DeleteZapis(Index : integer);
    procedure DeleteAll;
    function FindEl(NameEl : string) : integer;
    property Name : string read FName write FName;
  end;

  ARowMatr = array of TMatrR;

  TMatricaR = class(TObject)   //Матрица R
  private
    KolRows : integer;
  public
    Rows : ARowMatr;
    constructor Create;
    function GetZnachR (NAme1,Name2 : string) : integer;//Взять значение матрицы
    procedure SetMatrica; //Построить матрицу
    function FindEl(NameEl : string) : integer;
    procedure AddRow(NameEl : string);
    procedure Delete(Index : integer);
    procedure DeleteAll;
  end;

implementation

constructor TMatrR.Create(NameEl : string);
begin
  FName := NameEl;
  KolZapis := 0;
end;

function TMatrR.FindEl(NameEl: string) : integer;
var X : integer;
begin
  X := 0;
  Result := -1;
  while X < KolZapis do
  begin
    if Zapisi[X].Name = NameEl then
    begin
      Result := X;
      break;
    end;
    Inc(X);
  end;
end;

procedure TMatrR.DeleteAll;
begin
  while KolZapis > 0 do
  begin
    DeleteZapis(0);
  end;
end;

procedure TMatrR.SetMatrR;
var X,Y,Z,Index,SUM : integer;
begin
  X := 0;
  Index := Manager.FindElement(FName);
  while X < Manager.ElementsCount do
  begin
    if X = index then
    begin
      AddZapis(Fname,0);
    end
    else
    begin
      Y := 0;
      Sum := 0;
      while Y < MAnager.UzelsCount do
      begin
        if Manager.Uzels[Y].FindElement(Manager.Elements[Index].Name) > -1 then
        begin
          if Manager.Uzels[Y].FindElement(Manager.Elements[X].Name) > -1 then
          begin
            Sum := Sum + Manager.UZels[Y].KolElInUze(Manager.Elements[Index].Name) * Manager.UZels[Y].KolElInUze(Manager.Elements[X].Name);
          end;
        end;
        Inc(Y);
      end;
      AddZapis(Manager.Elements[X].Name,Sum);
    end;
    Inc(X);
  end;
end;

procedure TMatrR.AddZapis(Name: string; Znach: Integer);
begin
  SetLength(Zapisi, Length(Zapisi) + 1);
  Zapisi[KolZapis] := TZapMassiva.Create;
  //TMyKletki[FCountKletki].NameEl := NameEl;
  //ShowMessage(FElements[CountElements].Name);
  Zapisi[KolZapis].Name := Name;
  Zapisi[KolZapis].ZnachR := Znach;
  Inc(KolZapis);
end;

procedure TmatrR.DeleteZapis(Index: Integer);
begin
  if Index > High(Zapisi) then Exit;
  if Index < Low(Zapisi) then Exit;
  if Index = High(Zapisi) then
  begin
    SetLength(Zapisi, Length(Zapisi) - 1);
    KolZapis := KolZapis - 1;
    Exit;
  end;
  Finalize(Zapisi[Index]);
  System.Move(Zapisi[Index +1], Zapisi[Index],
              (Length(Zapisi) - Index -1) * SizeOf(TZapMassiva) + 1);
  SetLength(Zapisi, Length(Zapisi) - 1);
  KolZapis := KolZapis - 1;
end;

procedure TmatricaR.AddRow(NameEl: string);
begin
  SetLength(Rows, Length(Rows) + 1);
  Rows[KolRows] := TmatrR.Create(NameEl);
  //TMyKletki[FCountKletki].NameEl := NameEl;
  //ShowMessage(FElements[CountElements].Name);
  //Rows[KolZapis].Name := Name;
 // Zapisi[KolZapis].ZnachR := Znach;
  Inc(KolRows);
end;

constructor TMatricaR.Create;
begin
  KolRows := 0;
end;

procedure TMatricaR.SetMatrica;
var X : integer;
begin
  X := 0;
  while x < Manager.ElementsCount do
  begin
    AddRow(Manager.Elements[X].Name);
    Rows[X].SetMatrR;
    Inc(X);
  end;
end;

function TMatricaR.FindEl(NameEl: string) : integer;
var X : integer;
begin
  X := 0;
  Result := -1;
  while X < KolRows do
  begin
    if Rows[X].Name = NameEl then
    begin
      Result := X;
      Break;
    end;
    Inc(X);
  end;
end;

function TMatricaR.GetZnachR(NAme1: string; Name2: string) : integer;
var X,Y : integer;
begin
  Result := -1;
  X := FindEl(Name1);
  if X > -1 then
  begin
    Y := Rows[X].FindEl(NAme2);
    if Y > -1 then
    begin
      Result := Rows[X].Zapisi[Y].ZnachR;
    end;
  end;
end;

procedure TMatricaR.Delete(Index: Integer);
begin
  if Index > High(Rows) then Exit;
  if Index < Low(Rows) then Exit;
  if Index = High(Rows) then
  begin
    SetLength(Rows, Length(Rows) - 1);
    KolRows:= KolRows - 1;
    Exit;
  end;
  Finalize(Rows[Index]);
  System.Move(Rows[Index +1], Rows[Index],
              (Length(Rows) - Index -1) * SizeOf(TMAtrR) + 1);
  SetLength(Rows, Length(Rows) - 1);
  KolRows:= KolRows - 1;
end;

procedure TmatricaR.DeleteAll;
begin
  while KolRows > 0 do
  begin
    Rows[0].DeleteAll;
    Delete(0);
  end;
end;

end.
