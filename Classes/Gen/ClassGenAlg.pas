unit ClassGenAlg;

interface

uses
  Grids,DBGrids,dialogs,ClassOptions,
  SysUtils,DateUtils,StdCtrls,types,Graphics,DataModule,comctrls,ClassManager,ClassMatrR;

type

  TGen = class(TObject)
  private

  public
    IndexEl : integer;
    IndexKl : integer;
    Oshibka : integer;
    Bit : string;
  end;

  AGen = array of TGen;

  THromosoma = class(TObject)   //Класс хромосом
  private
    FGens : AGen;
    FKolGens : integer;
    Fbit : string;
  public
    constructor Create;
    procedure AddGen;
    procedure SetBit;
    function GetGen : integer;
    function FindByName (Index : integer) : integer;
    function FindByBit (B : string):integer;
    function FindByIndexKl (Ind : integer) : integer;
    procedure DeleteGen(Index : integer);
    procedure ChangeEl(First,Second : integer;Razm : boolean);
    property Gens : AGen read FGens write FGens;
    property KolGens : integer read FKolGens;
    property Bit : string read FBit;
  end;

  AHromosoms = array of THromosoma;

  TGenAlg = class(TObject)   //Класс ген. Алгоритма
  private
    KolBit : integer;
    Hrom : AHromosoms;
    FKolHrom : integer;
    FInvertion : double;
    FMutation : double;
    FKrossover : double;
    FMinPop : integer;
    FMaxPop : integer;
    Matr : TmatricaR;
    FCelFunc : integer;
    FPrevCelFunc : integer;
  public
    Iteration : integer;
    constructor Create;
    function Prepare : boolean;
    function PrepareSecond : boolean;
    procedure AddHrom;
    procedure SetMatr;
    function SetCelFunc : boolean;  //Установить целевую функцию
    procedure DeleteHrom(Index : integer);
    procedure DeleteAllHrom;
    function FuncMutation(MBit : string) : string;//Мутация
    function DecToBin (Dec: LongWord) : string;//Перевод дес в двоичн
    procedure SetKolBit(Value : integer);
    procedure SetAllBit;
    procedure FirstRazm;  //Первое размещение
    function SetCelFuncKomp : boolean; //Целевая функция компоновки
    procedure ZakrEl(Index : integer);
    function CrossingKomp(X , Y : integer) : boolean; //Компоновка
    procedure SetOshibka(Ind,Osh : integer);
    function NewRast : integer;
    function Crossing(X , Y : integer) : boolean;  //Размещение
    function Rast(NAme1,Name2 : string) : integer;  //Растояние м\у эл-ми
    procedure SnapEl(IndexKl,IndexEl : integer);
    procedure SetAllHrom;
    property MinPop : integer read FMinPop write FMinPop;
    property MaxPop : integer read FMaxPop write FmaxPop;
    property Invertion : double read FInvertion write FInvertion;
    property Mutation : double read FMutation write FMutation;
    property Krosover : double read FKrossover write FKrossover;
    property CelFunc : integer read FPrevCelFunc;
    property KolHrom : integer read FKolHrom;
    Property FHrom : AHromosoms read Hrom;
  end;

implementation

uses ClassDraw,fmMain;

constructor THromosoma.Create;
begin
  FKolGens := 0;
end;

procedure TGenAlg.ZakrEl(Index : integer);
begin
  Hrom[0].FGens[Index].Oshibka := 2;
end;

function THromosoma.GetGen : integer;
begin
  Randomize;
  Result := Random(KolGens);
end;

function TGenAlg.NewRast : integer;
var X , Y,Sum,TempSum,I1,I2,P1,P2 : integer;
    Name1,Name2 : string;
    Point1,Point2 : TPoint;
begin
  X := 0;
  Sum := 0;
  while X < manager.UzelsCount do
  begin
    Y := 1;
    NAME1 := Manager.Uzels[X].Elements[0].Name;
    I1 := Manager.FindElement(Name1);
    P1 := manager.Uzels[X].Elements[0].numberConnect;
    Point1.X := Manager.Elements[I1].VerhPoint.X +  Manager.Elements[I1].PointConnect[P1].X;
    Point1.Y := Manager.Elements[I1].VerhPoint.Y +  Manager.Elements[I1].PointConnect[P1].Y;
    while Y < manager.Uzels[X].CountElements do
    begin
      NAME2 := Manager.Uzels[X].Elements[Y].Name;
      I2 := Manager.FindElement(Name2);
      P2 := manager.Uzels[X].Elements[Y].numberConnect;
      Point2.X := Manager.Elements[I2].VerhPoint.X +  Manager.Elements[I2].PointConnect[P2].X;
      Point2.Y := Manager.Elements[I2].VerhPoint.Y +  Manager.Elements[I2].PointConnect[P2].Y;
      if Point1.X < Point2.X then
      begin
        Sum := Sum + (Point2.X - Point1.X);
      end
      else
      begin
        Sum := Sum + (Point1.X - Point2.X);
      end;
      if Point1.Y < Point2.Y then
      begin
        Sum := Sum + (Point2.Y - Point1.Y);
      end
      else
      begin
        Sum := Sum + (Point1.Y - Point2.Y);
      end;
      Inc(Y);
    end;
    Inc(X);
  end;
  Result := Sum;
end;

function TGenAlg.SetCelFuncKomp : boolean;
var X,Y : integer;
    TempRes,TempIPlat,TempIPlat2 : integer;
begin
  Result := false;
  X := 0;
  TempRes := 0;
  while X < Manager.ElementsCount do
  begin
    Y := X ;
    while Y < Manager.ElementsCount do
    begin
      TempIPlat := Manager.FindPlatByIndex(X);
      if TempIPlat > -1 then
      begin
        TempIPlat2 := Manager.FindPlatByIndex(Y);
        if TempIPlat2 > -1 then
        begin
          if TempIPlat <> TempIPlat2 then
          begin
            if Matr.GetZnachR(Manager.Elements[X].Name,Manager.Elements[Y].Name) > -1 then
            TempRes := TempRes + Matr.GetZnachR(Manager.Elements[X].Name,Manager.Elements[Y].Name);
          end;
        end;
      end;
      Inc(Y);
    end;
  Inc(X);
 end;
 FCelFunc := TempRes;
 if TempRes < FPrevCelFunc then
 begin
  FCelFunc := TempRes;
  FPrevCelFunc := FCelFunc;
  Result := true;
 end;
end;

function TGenAlg.FuncMutation(MBit: string) : string;
var X : integer;
    S,Str : string;
begin
  X := 0;
  Result := '';
  Str := MBit;
  while X < Length(MBit) do
  begin
    if Random(100) < (FMutation * 100) then
    begin
      S := Str[X];
      if S = '0' then
      begin
        S := '1';
      end
      else
      begin
        S := '0';
      end;
      Str[X] := S[1];
    end;
    Inc(X);
  end;
  Result := Str;
end;

procedure TGenAlg.SetOshibka(Ind, Osh: Integer);
begin
  Hrom[0].FGens[Hrom[0].FindByName(Ind)].Oshibka := Osh;
end;

function TGenAlg.PrepareSecond : boolean;
var X,Y,Temp : integer;
begin
  Result := false;
  Iteration := 0;
  FprevCelFunc := 9999999999;
  X := 0;
  while X < Mygrid.CountKletki do
  begin
    MyGrid.Kletki[X].IsElement := false;
    Inc(X);
  end;
  X := 0;
  FprevCelFunc := 9999999999;
  DeleteAllHrom;
  Randomize;
  if Manager.PlatsCount > 0 then
  begin
    Result := true;
    SetKolBit(Manager.CountVakMest);
    AddHrom;
    SetAllBit;
    while X < Manager.ElementsCount do
    begin
      Temp := Hrom[0].FindByIndexKl(MyGrid.FindKletkaByName(Manager.Elements[X].Name));
      if Temp > -1 then
      begin
        Hrom[0].FGens[Temp].IndexEl := X;
        MyGrid.Kletki[MyGrid.FindKletkaByName(Manager.Elements[X].Name)].IsElement := true;
      end
      else
      begin
        Prepare;
        exit;
      end;
      Inc(X);
    end;
    Matr.DeleteAll;
    SetMatr;
    SetCelFunc;
  end;

  //FprevCelFunc := FCelFunc;
end;

procedure TGenAlg.DeleteAllHrom;
begin
  while KolHrom > 0 do
  begin
    DeleteHrom(0);
  end;
end;

procedure THromosoma.ChangeEl(First: Integer; Second: Integer;Razm : boolean);
var IE1,IE2,IK1,IK2,IP1,IP2 : integer;
    Name1,Name2 : string;
begin
  IE1 := Gens[First].IndexEl;
  IE2 := Gens[Second].IndexEl;
  IK1 := Gens[First].IndexKl;
  IK2 := Gens[Second].IndexKl;
    if MyGrid.Kletki[IK2].IsElement then
    begin
      IP1 := Manager.FindPlatByIndex(IE1);
      IP2 := Manager.FindPlatByIndex(IE2);
      if (IP1 = IP2)and Razm then
      begin
      Gens[First].IndexEl := IE2;
      Gens[Second].IndexEl := IE1;
      MyGrid.Kletki[IK2].IsElement := false;
      MyGrid.Kletki[IK1].IsElement := false;
      Draw.SnapEl(IK2,IE1);
      Draw.SnapEl(Ik1,Ie2);
      end;
      if (IP1 <> IP2)and (not Razm)and (IP2 > -1)and(IP1 > -1) then
      begin
      Gens[First].IndexEl := IE2;
      Gens[Second].IndexEl := IE1;
      MyGrid.Kletki[IK2].IsElement := false;
      MyGrid.Kletki[IK1].IsElement := false;
      Draw.SnapEl(IK2,IE1);
      Draw.SnapEl(Ik1,Ie2);
      end;
    end
    else
    begin
      IP1 := Manager.FindPlatByIndex(IE1);
      if IK2 > -1 then IP2 := Manager.FindPlatByKl(IK2);
      if (IP1 = IP2) and Razm then
      begin
      Gens[First].IndexEl := IE2;
      Gens[Second].IndexEl := IE1;
      MyGrid.Kletki[IK2].IsElement := false;
      MyGrid.Kletki[IK1].IsElement := false;
      Draw.SnapEl(IK2,IE1);
      end;
      if (IP1 <> IP2) and (not Razm)and (IP2 > -1)and(IP1 > -1) then
      begin
      Gens[First].IndexEl := IE2;
      Gens[Second].IndexEl := IE1;
      MyGrid.Kletki[IK2].IsElement := false;
      MyGrid.Kletki[IK1].IsElement := false;
      Draw.SnapEl(IK2,IE1);
      end;
    end;
end;

function THromosoma.FindByBit(B: string) : integer;
var X : integer;
begin
  X := 0;
  Result := -1;
  while X < KolGens do
  begin
    if Gens[X].Bit = B then
    begin
      Result := X;
      break;
    end;
    Inc(X);
  end;
end;

function THromosoma.FindByName(Index: integer) : integer;
var X : integer;
begin
  X := 0;
  Result := -1;
  while X < KolGens do
  begin
    if Gens[X].IndexEl = Index then
    begin
      Result := X;
      break;
    end;
    Inc(X);
  end;
end;

function THromosoma.FindByIndexKl(Ind: integer) : integer;
var X : integer;
begin
  X := 0;
  Result := -1;
  while X < KolGens do
  begin
    if Gens[X].IndexKl = ind then
    begin
      Result := X;
      break;
    end;
    Inc(X);
  end;
end;

procedure THromosoma.SetBit;
var X : integer;
begin
  FBit := '';
  X := 0;
  while X < KolGens do
  begin
    FBit := FBit + Gens[X].Bit;
    Inc(X);
  end;
  //ShowMessage(FBIT);
end;

function TGenAlg.Crossing(X: Integer; Y: Integer) : boolean;
var BitF,BitS,Temp : string;
    NumberBit,Z,TempIndex,TempIndexEl : integer;
    B : boolean;
begin
  Randomize;
  b := false;
  Result := false;
  if (Hrom[0].FGens[X].IndexEl < 0)and(Hrom[0].FGens[Y].IndexEl < 0) then Exit;
  if Hrom[0].FGens[X].IndexEl > -1 then
    B := Manager.Elements[Hrom[0].FGens[X].IndexEl].Zakr;
  if B then Exit;
  if Hrom[0].FGens[Y].IndexEl > -1 then
    B := Manager.Elements[Hrom[0].FGens[Y].IndexEl].Zakr;
  if B then Exit;
  BitF := Hrom[0].FGens[X].Bit;
  BitS := Hrom[0].FGens[Y].Bit;
  Temp := BitF;
  NumberBit := Random(KolBit);
  Z := 0;
  while Z < NumberBit do
  begin
    BitF[Z] := BitS[Z];
    Inc(Z);
  end;
  Z := NumberBit;
  while Z < KolBit do
  begin
    BitS[Z] := BitF[Z];
    Inc(Z);
  end;
  if Random <= 0.5 then
  begin
    BitF := FuncMutation(BitF);
    if Hrom[0].FindByBit(BitF) > -1 then
    begin
      if (Hrom[0].FGens[X].IndexEl > -1)and(Hrom[0].FindByBit(BitF)<>X) then
      begin
        Hrom[0].ChangeEl(X,Hrom[0].FindByBit(BitF),True);
        if not SetCelFunc then
        begin
          Hrom[0].ChangeEl(Hrom[0].FindByBit(BitF),X,True);
        end
        else
        begin
          Result := true;
        end;
      end;
    end;
  end
  else
  begin
    BitS := FuncMutation(BitS);
    if (Hrom[0].FindByBit(BitS) > -1)and(Hrom[0].FindByBit(BitS)<>Y) then
    begin
      if Hrom[0].FGens[Y].IndexEl > -1 then
      begin
        Hrom[0].ChangeEl(Y,Hrom[0].FindByBit(BitS),True);
        if not SetCelFunc then
        begin
          Hrom[0].ChangeEl(Hrom[0].FindByBit(BitS),Y,True);
        end
        else
        begin
          Result := true;
        end;
      end;
    end;
  end;
end;

function TGenAlg.CrossingKomp(X: Integer; Y: Integer) : boolean;
var BitF,BitS,Temp : string;
    NumberBit,Z,TempIndex,TempIndexEl,F : integer;
    B : boolean;
begin
  Randomize;
  b := false;
  Result := false;
  if (Hrom[0].FGens[X].IndexEl < 0)and(Hrom[0].FGens[Y].IndexEl < 0) then Exit;
  if Hrom[0].FGens[X].IndexEl > -1 then
    B := Manager.Elements[Hrom[0].FGens[X].IndexEl].Zakr;
  if B then Exit;
  if Hrom[0].FGens[Y].IndexEl > -1 then
    B := Manager.Elements[Hrom[0].FGens[Y].IndexEl].Zakr;
  if B then Exit;
  BitF := Hrom[0].FGens[X].Bit;
  BitS := Hrom[0].FGens[Y].Bit;
  Temp := BitF;
  NumberBit := Random(KolBit);
  Z := 0;
  while Z < NumberBit do
  begin
    BitF[Z] := BitS[Z];
    Inc(Z);
  end;
  Z := NumberBit;
  while Z < KolBit do
  begin
    BitS[Z] := BitF[Z];
    Inc(Z);
  end;
  F := 0;
  while F < KolHrom do
  begin
  if Random <= 0.5 then
  begin
    BitF := FuncMutation(BitF);
    if Hrom[F].FindByBit(BitF) > -1 then
    begin
      if (Hrom[F].FGens[X].IndexEl > -1)and(Hrom[F].FindByBit(BitF)<>X) then
      begin
        Hrom[F].ChangeEl(X,Hrom[F].FindByBit(BitF),False);
        if not SetCelFuncKomp then
        begin
          Hrom[F].ChangeEl(Hrom[F].FindByBit(BitF),X,False);
        end
        else
        begin
          Result := true;
        end;
      end;
    end;
  end
  else
  begin
    BitS := FuncMutation(BitS);
    if (Hrom[F].FindByBit(BitS) > -1)and(Hrom[F].FindByBit(BitS)<>Y) then
    begin
      if Hrom[F].FGens[Y].IndexEl > -1 then
      begin
        Hrom[F].ChangeEl(Y,Hrom[F].FindByBit(BitS),False);
        if not SetCelFuncKomp then
        begin
          Hrom[F].ChangeEl(Hrom[F].FindByBit(BitS),Y,False);
        end
        else
        begin
          Result := true;
        end;
      end;
    end;
  end;
  Inc(F);
  end;
end;

procedure TGenAlg.SetAllHrom;
begin
  Randomize;
end;

constructor TGenAlg.Create;
begin
  KolBit := 0;
  FKolHrom := 0;
  FInvertion := 0.01;
  FMutation := 0.3;
  FKrossover := 1;
  FMinPop := 100;
  FMaxPop := 1000;
  Matr := TMatricaR.Create;
  FprevCelFunc := 99999999999999;
end;

procedure TGenAlg.AddHrom;
begin
  SetLength(Hrom, Length(Hrom) + 1);
  Hrom[KolHrom] := THromosoma.Create;
  //Hrom[KolHrom].IndexEl := -1;
  //Hrom[KolHrom].IndexKl := -1;
  //Hrom[KolHrom].Bit := '-1';
  //ShowMessage(FElements[CountElements].Name);
  Inc(FKolHrom);
end;

procedure TGenAlg.DeleteHrom(Index: Integer);
begin
  if Index > High(Hrom) then Exit;
  if Index < Low(Hrom) then Exit;
  if Index = High(Hrom) then
  begin
    SetLength(Hrom, Length(Hrom) - 1);
    FKolHrom := FKolHrom - 1;
    Exit;
  end;
  Finalize(Hrom[Index]);
  System.Move(Hrom[Index +1], Hrom[Index],
              (Length(Hrom) - Index -1) * SizeOf(THromosoma) + 1);
  SetLength(Hrom, Length(Hrom) - 1);
  FKolHrom := FKolHrom - 1;
end;

function TGenAlg.Rast(NAme1: string; Name2: string) : integer;
var X1,X2,RastX,RastY : integer;
begin
  Rast := -1;
  X1 := Manager.FindElement(Name1);
  X2 := Manager.FindElement(Name2);
  if Manager.Elements[X1].VerhPoint.X >= Manager.Elements[X2].VerhPoint.X then
  begin
    RAstX := Manager.Elements[X1].VerhPoint.X - Manager.Elements[X2].VerhPoint.X;
  end
  else
  begin
    RAstX := Manager.Elements[X2].VerhPoint.X - Manager.Elements[X1].VerhPoint.X;
  end;
  if Manager.Elements[X1].VerhPoint.y >= Manager.Elements[X2].VerhPoint.y then
  begin
    RAsty := Manager.Elements[X1].VerhPoint.y - Manager.Elements[X2].VerhPoint.y;
  end
  else
  begin
    RAsty := Manager.Elements[X2].VerhPoint.y - Manager.Elements[X1].VerhPoint.y;
  end;
  Result := RastX + RastY;
end;

function TGenAlg.SetCelFunc : boolean;
var X,Y,TempRAst,TempR,TempRes,OshibkaT,TempI : integer;
begin
 X := 0;
 Result := false;
 TempRes := 0;
 while X < Manager.ElementsCount do
 begin
  Y := X;
  while Y < Manager.ElementsCount do
  begin
    //TempRast := Rast(Manager.Elements[X].Name,Manager.Elements[Y].Name);
    //TempR := Matr.GetZnachR(Manager.Elements[X].Name,Manager.Elements[Y].Name);
    //TempI := Hrom[0].FindByName(Y);
    //OshibkaT := Hrom[0].Gens[TempI].Oshibka;
    //OshibkaT := 1;
    //if TempR > -1 then TempRes := TempRes + (TempRast * TempR);
    Inc(Y);
  end;
  Inc(X);
 end;
 TempRes := NewRast;
 FCelFunc := TempRes;
 if TempRes < FPrevCelFunc then
 begin
  FCelFunc := TempRes;
  FPrevCelFunc := FCelFunc;
  Result := true;
 end;
end;

procedure TGenAlg.SetMatr;
begin
  MAtr.SetMatrica;
end;

procedure TGenAlg.SnapEl(IndexKl: Integer; IndexEl: Integer);
var P : TPoint;
begin
  P.X := MyGrid.Kletki[IndexKl].VerhPoint.X + 1;
  P.Y := MyGrid.Kletki[IndexKl].VerhPoint.Y + 1;
  Manager.Elements[IndexEl].VerhPoint := P;
  MyGrid.SnapToGrid(Manager.Elements[IndexEl]);
end;

procedure TGenAlg.FirstRazm;
var X,Y,Z,IndP : integer;
    P : TPoint;
begin
  Y := 0;
  X := 0;
  Z := 0;
  while X < Mygrid.CountKletki do
  begin
    MyGrid.Kletki[X].IsElement := false;
    Inc(X);
  end;
  X := 0;
  IndP := 0;
  while X < Manager.ElementsCount do
  begin
      SnapEl(Manager.Plats[Y].Kletki[Z],X);
      Hrom[0].Gens[X].IndexEl := X;
      Inc(X);
      Inc(Z);
      if Manager.Plats[Y].CountKletok < Z + 1 then
      begin
        Z := 0;
        Inc(Y);
      end;
  end;
end;

procedure TGenAlg.SetAllBit;
var X,Y,Z,TempKolBit,Raznica,F : integer;
    TempBit : string;
begin
  X := 0;
  Y := 0;
  F := 0;
    while Y < Manager.PlatsCount do
    begin
      if X + 1 > Manager.Plats[Y].CountKletok then
      begin
        Inc(Y);
        X := 0;
      end
      else
      begin
      Hrom[0].AddGen;
      TempBit := DecToBin(F);
      TempKolBit := Length(TempBit);
      if TempKolBit < KolBit then
      begin
        Raznica := KolBit - TempKolBit;
        Z := 1;
        while Z < Raznica do
        begin
          TempBit := '0' + TempBit;
          Inc(Z);
        end;
      end;
      Hrom[0].Gens[F].Bit := TempBit;
      Hrom[0].Gens[F].IndexKl := Manager.Plats[Y].Kletki[X];
      Inc(X);
      //ShowMessage(Gens[F].Bit);
      Inc(F);
      end;
    end;
    Hrom[0].SetBit;
end;

procedure THromosoma.AddGen;
begin
  SetLength(FGens, Length(FGens) + 1);
  FGens[KolGens] := TGen.Create;
  FGens[KolGens].IndexEl := -1;
  FGens[KolGens].IndexKl := -1;
  FGens[KolGens].Bit := '-1';
  FGens[KolGens].Oshibka := 1;
  //ShowMessage(FElements[CountElements].Name);
  Inc(FKolGens);
end;

procedure THromosoma.DeleteGen(Index: Integer);
begin
  if Index > High(Gens) then Exit;
  if Index < Low(Gens) then Exit;
  if Index = High(Gens) then
  begin
    SetLength(FGens, Length(FGens) - 1);
    FKolGens := FKolGens - 1;
    Exit;
  end;
  Finalize(FGens[Index]);
  System.Move(FGens[Index +1], FGens[Index],
              (Length(FGens) - Index -1) * SizeOf(TGen) + 1);
  SetLength(FGens, Length(FGens) - 1);
  FKolGens := FKolGens - 1;
end;

function TGenAlg.Prepare : boolean;
begin
  Result := false;
  Iteration := 0;
  FprevCelFunc := 9999999999;
  DeleteAllHrom;
  Randomize;
  if Manager.PlatsCount > 0 then
  begin
    Result := true;
    SetKolBit(Manager.CountVakMest);
    AddHrom;
    SetAllBit;
    FirstRazm;
    Matr.DeleteAll;
    SetMatr;
    //ShowMessage(IntToStr(MAtr.GetZnachR('R1','R2')));
    SetCelFunc;
   // ShowMessage(IntToStr(FCelFunc));    
  end;
end;

procedure TGenAlg.SetKolBit(Value: Integer);
var X : integer;
begin
  X := 1;
  KolBit := 1;
  while X < Value do
  begin
    X := X * 2;
    Inc(KolBit);
  end;
end;

function TGenAlg.DecToBin (Dec: LongWord) : string;
var Bin : string;
begin
  Bin := '';
  while Dec > 0 do
  begin
    Bin := Concat (IntToStr (Dec and 1), Bin);
    Dec := Dec shr 1;
  end; {while}
  if Bin = '' then Bin := '0';
  Result := Bin;
end; {func DecToBin}

end.
