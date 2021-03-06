unit ClassTrass;

interface

uses
  Grids,DBGrids,dialogs,ClassOptions,Forms,ExtCtrls,
  SysUtils,DateUtils,StdCtrls,types,Graphics,DataModule,comctrls,ClassManager,ClassMatrR;

type
  AInt = array of integer;
  TTrassEL = class (Tobject)
  public
    Index : integer;
    Con : integer;
    Value : integer;
  end;
  TAllPoint = class(TObject)
  public
    Point : TPoint;
    Value : integer;
  end;
  APoint = array of TAllPoint;
  ArrayOfPoint = array of TPoint;
  ATrassEl = array of TTrassEl;
  TTrass = class(TObject)
  private
    RaspEl : ATrassEl;  //???????? ??? ???????????
    AllPoint : Apoint;  //????? ?? ??????? ??????????
    SetPoint : ArrayOfPoint;
    KolRAspEl : integer;
    KolPoint : integer;
    KolSetPoint : integer;
    PrevValue : integer;
  public
    constructor Create;
    procedure ShowTrass (Index : integer);  //???????? ?????? ?? ??????? ????
    procedure AddRaspEl(IE,Ip : integer);//???????? ??????? ??? ??????
    procedure DeleteRaspEl(Index: Integer);//??????? ??????? ??? ??????
    procedure AddPoint(Point : Tpoint;Val : integer);//???????? ????? ??? ??????
    procedure DeletePoint(Index: Integer);//??????? ????? ??? ??????
    procedure AddSetPoint(Point : Tpoint);//???????? ????? ??? ??????
    procedure DeleteSetPoint(Index: Integer);
    procedure DeleteAll;
    procedure DeleteAllPoint;
    procedure DeleteAllSetPoint;
    procedure Prepare;//?????????? ? ???????????
    procedure Sort; //?????????? ????????? ??? ??????
    function GetMin(Point : TPoint) : integer; //????? ??? ????? ??? ??????
    procedure DrawCon;//?????????? ??????
    property CountRaspEl : integer read KolRaspEl;
    property CountPoint : integer read KolPoint;
  end;

implementation

uses fmMain;

constructor TTrass.Create;  //??????????
begin
  PrevValue := 0;
  KolRaspEl := 0;
  KolPoint := 0;
end;

procedure TTrass.DeleteAll; //??????? ??? ??????? ???????? ?? ???????
begin
  while KolRaspEl > 0 do
  begin
    DeleteRaspEl(0);
  end;
end;

procedure TTrass.DeleteAllPoint;  //?????? ??? ????? ?? ???????
begin
  while KolPoint > 0 do
  begin
    DeletePoint(0);
  end;
end;

procedure TTrass.DeleteAllSetPoint;  //?????? ??? ????? ?? ???????
begin
  while KolSetPoint > 0 do
  begin
    DeleteSetPoint(0);
  end;
end;

function TTrass.GetMin(Point : TPoint) : integer;  //????? ??? ?????
var X,Rast,TempRast,TempIndex : integer;
begin
  X := 0;
  TempIndex := -1;
  TempRast := 999999999;
  while X < KolPoint do
  begin
    Rast := 0;
    if Point.X <= AllPoint[X].Point.X then
    begin
      Rast := Rast + (AllPoint[X].Point.X - Point.X);
    end
    else
    begin
      Rast := Rast + (Point.X - AllPoint[X].Point.X);
    end;
    if Point.Y <= AllPoint[X].Point.Y then
    begin
      Rast := Rast + (AllPoint[X].Point.Y - Point.Y);
    end
    else
    begin
      Rast := Rast + (Point.Y - AllPoint[X].Point.Y);
    end;
    if Rast < TempRast then
    begin
      TempRast := Rast;
      TempIndex := X;
    end;
    Inc(X);
  end;
  Result := TempIndex;
end;

procedure TTrass.DrawCon;   //??????????
var X ,Y: integer;
    P1,P2,MIn : TPoint;
begin
  P1.X := Manager.Elements[RaspEl[0].Index].VerhPoint.X + Manager.Elements[RaspEl[0].Index].PointConnect[RaspEl[0].Con - 1].X;
  P1.Y := Manager.Elements[RaspEl[0].Index].VerhPoint.Y + Manager.Elements[RaspEl[0].Index].PointConnect[RaspEl[0].Con - 1].Y;

  X := 1;
  Draw.Image.Canvas.PenPos := P1;
  AddPoint(P1,RaspEl[0].Value);
  while X < KolRaspEl do
  begin
    P2.X := Manager.Elements[RaspEl[X].Index].VerhPoint.X + Manager.Elements[RaspEl[X].Index].PointConnect[RaspEl[X].Con - 1].X;
    P2.Y := Manager.Elements[RaspEl[X].Index].VerhPoint.Y + Manager.Elements[RaspEl[X].Index].PointConnect[RaspEl[X].Con - 1].Y;
    while True do
      begin
      Min := AllPoint[GetMin(P2)].Point;
      Draw.Image.Canvas.PenPos := Min;
      if (Min.X = P2.X)and(Min.Y = P2.Y) then break;

      if AllPoint[GetMin(P2)].Value = 0 then
      begin
        if Min.Y = P2.Y then
        begin
          AllPoint[GetMin(P2)].Value := 1;
        end
        else
        begin
          if Min.Y < P2.Y then
          begin
            Min.Y := Min.y + 1;
            AddPoint(min,0);
          end;
          if Min.Y > P2.Y then
          begin
            Min.Y := Min.Y - 1;
            AddPoint(Min,0);
          end;
        end;
      end
      else
      begin
        if Min.X = P2.X then
        begin
          AllPoint[GetMin(P2)].Value := 0;
        end
        else
        begin
          if Min.X < P2.X then
          begin
            Min.X := Min.X + 1;
            AddPoint(min,1);
          end;
          if Min.X > P2.X then
          begin
            Min.X := Min.X - 1;
            AddPoint(Min,1);
          end;
        end;
      end;
      Draw.Image.Canvas.LineTo(Min.X,Min.Y);
    end;
    Draw.Image.Canvas.PenPos:= P1;
    Inc(X);
  end;
  {X := 1;
  Draw.Image.Canvas.PenPos := AllPoint[0].Point;
  while X < kolPoint do
  begin
    Draw.Image.Canvas.LineTo(AllPoint[X].Point.X,AllPoint[X].Point.Y);
    Inc(X);
  end; }
end;

procedure TTrass.Sort;  //?????????? ?????????
var X,TEMP,Y,I1,P1,I2,P2 : integer;
    Change : boolean;
    Point1,Point2 : Tpoint;
    TempEl :TTrassEL;
begin
  TempEl := TTrassEl.Create;
  X := 0;
  while X < KolRaspEl do
  begin
    I1 := RaspEl[X].Index;
    P1 := RaspEl[X].Con;
    Point1.X := Manager.Elements[I1].VerhPoint.X+ Manager.Elements[I1].PointConnect[P1].X;
    Point1.Y := Manager.Elements[I1].VerhPoint.Y+ Manager.Elements[I1].PointConnect[P1].Y;
    Y := X + 1;
    while Y < KolRaspEl do
    begin
      I2 := RaspEl[Y].Index;
      P2 := RaspEl[Y].Con;
      Point2.X := Manager.Elements[I2].VerhPoint.X+ Manager.Elements[I2].PointConnect[P2].X;
      Point2.Y := Manager.Elements[I2].VerhPoint.Y+ Manager.Elements[I2].PointConnect[P2].Y;
      if Point1.X > Point2.X then
      begin
        TempEl.Index := RaspEl[X].Index;
        TempEl.Con := RaspEl[X].Con;
        RaspEl[X].Index := RaspEl[Y].Index;
        RaspEl[X].Con := RaspEl[Y].Con;
        RaspEl[Y].Index := TempEl.Index;
        RaspEl[Y].Con := TempEl.Con;
        I1 := RaspEl[X].Index;
        P1 := RaspEl[X].Con;
        Point1.X := Manager.Elements[I1].VerhPoint.X+ Manager.Elements[I1].PointConnect[P1].X;
        Point1.Y := Manager.Elements[I1].VerhPoint.Y+ Manager.Elements[I1].PointConnect[P1].Y;
        Y := X + 1;
      end;
      Inc(Y);
    end;
    Inc(X);
  end;
  I1 := RaspEl[0].Index;
  P1 := RaspEl[0].Con;
  Point1.X := Manager.Elements[I1].VerhPoint.X+ Manager.Elements[I1].PointConnect[P1].X;
  Point1.Y := Manager.Elements[I1].VerhPoint.Y+ Manager.Elements[I1].PointConnect[P1].Y;
  X := 1;
  while X < KolRaspEl do
  begin
    I2 := RaspEl[X].Index;
    P2 := RaspEl[X].Con;
    Point2.X := Manager.Elements[I2].VerhPoint.X+ Manager.Elements[I2].PointConnect[P2].X;
    Point2.Y := Manager.Elements[I2].VerhPoint.Y+ Manager.Elements[I2].PointConnect[P2].Y;
    if Point1.X = Point2.X then
    begin
      RaspEl[X].Value := PrevValue;
    end
    else
    begin
      if PrevValue = 1 then
      begin
        RaspEl[X].Value := 0;
        PrevValue := 0;
      end
      else
      begin
        RaspEl[X].Value := 1;
        PrevValue := 1;
      end;
    end;
    I1 := RaspEl[X].Index;
    P1 := RaspEl[X].Con;
    Point1.X := Manager.Elements[I1].VerhPoint.X+ Manager.Elements[I1].PointConnect[P1].X;
    Point1.Y := Manager.Elements[I1].VerhPoint.Y+ Manager.Elements[I1].PointConnect[P1].Y;
    Inc(X);
  end;
end;

procedure TTrass.AddRaspEl(IE,Ip : integer); //???????? ??????? ??????????????
begin
  SetLength(RaspEl, Length(RaspEl) + 1);
  RaspEl[KolRaspEl] := TTrassEl.Create;
  //TMyKletki[FCountKletki].NameEl := NameEl;
  //ShowMessage(FElements[CountElements].Name);
  RaspEl[KolRAspEl].Index := IE;
  RaspEl[KolRaspEl].Con := IP;
  Inc(KolRAspEl);
end;

procedure TTrass.AddPoint(Point : Tpoint;Val : integer); //???????? ?????
begin
  SetLength(AllPoint, Length(AllPoint) + 1);
  AllPoint[KolPoint] := TAllPoint.Create;
  //TMyKletki[FCountKletki].NameEl := NameEl;
  //ShowMessage(FElements[CountElements].Name);
  AllPoint[KolPoint].Point := Point;
  AllPoint[KolPoint].Value := val;
  Inc(KolPoint);
end;

procedure TTrass.AddSetPoint(Point : Tpoint); //???????? ?????
begin
  SetLength(AllPoint, Length(SetPoint) + 1);
  //SetPoint[KolSetPoint] := TAllPoint.Create;
  //TMyKletki[FCountKletki].NameEl := NameEl;
  //ShowMessage(FElements[CountElements].Name);
  SetPoint[KolSetPoint] := Point;
 // AllPoint[KolPoint].Value := val;
  Inc(KolSetPoint);
end;

procedure TTrass.ShowTrass(Index: Integer); //???????? ?????? ?? ????
var Y : integer;
begin
   Draw.DrawAllnoLine;
   Draw.Image.Canvas.Pen.Color := clBlack;
   Draw.Image.Canvas.Pen.Style := psSolid;
   Draw.Image.Canvas.Pen.Width := 2;
     Y := 0;
     DeleteAll;
     DeleteAllPoint;
     while Y < Manager.Uzels[Index].CountElements do
     begin
      AddRaspEl(Manager.FindElement(Manager.Uzels[Index].Elements[Y].NAme),Manager.Uzels[Index].Elements[Y].NumberConnect);
      Inc(Y);
     end;
     Sort;
     DrawCon;
end;


procedure TTrass.Prepare;//??????????
var X,Y : integer;
begin
   X := 0;
   Draw.DrawAllnoLine;
   Draw.Image.Canvas.Pen.Color := clBlack;
   Draw.Image.Canvas.Pen.Style := psSolid;
   Draw.Image.Canvas.Pen.Width := 2;
   DeleteAllSetPoint;
   while X < Manager.UzelsCount do
   begin
     Y := 0;
     DeleteAll;
     DeleteAllPoint;
     Draw.Image.Canvas.Pen.Color := Draw.Image.Canvas.Pen.Color + 999999;
     while Y < Manager.Uzels[X].CountElements do
     begin
      AddRaspEl(Manager.FindElement(Manager.Uzels[X].Elements[Y].NAme),Manager.Uzels[X].Elements[Y].NumberConnect);
      Inc(Y);
     end;
     Sort;
     DrawCon;
     Inc(X);
   end;
end;

procedure TTrass.DeleteRaspEl(Index: Integer);//??????? ??????? ???????
begin
  if Index > High(RaspEl) then Exit;
  if Index < Low(RaspEl) then Exit;
  if Index = High(RaspEl) then
  begin
    SetLength(RaspEl, Length(RaspEl) - 1);
    KolRAspEl := KolRAspEl- 1;
    Exit;
  end;
  Finalize(RaspEl[Index]);
  System.Move(RaspEl[Index +1], RaspEl[Index],
              (Length(RaspEl) - Index -1) * SizeOf(ATrassEl) + 1);
  SetLength(RaspEl, Length(RaspEl) - 1);
  KolRAspEl := KolRAspEl - 1
end;

procedure TTrass.DeleteSetPoint(Index: Integer); //??????? ?????
begin
  if Index > High(SetPoint) then Exit;
  if Index < Low(SetPoint) then Exit;
  if Index = High(SetPoint) then
  begin
    SetLength(SetPoint, Length(SetPoint) - 1);
    KolSetPoint := KolSetPoint- 1;
    Exit;
  end;
  Finalize(SetPoint[Index]);
  System.Move(SetPoint[Index +1], SetPoint[Index],
              (Length(SetPoint) - Index -1) * SizeOf(TPoint) + 1);
  SetLength(SetPoint, Length(SetPoint) - 1);
  KolSetPoint := KolSetPoint - 1
end;

procedure TTrass.DeletePoint(Index: Integer); //??????? ?????
begin
  if Index > High(AllPoint) then Exit;
  if Index < Low(AllPoint) then Exit;
  if Index = High(AllPoint) then
  begin
    SetLength(AllPoint, Length(AllPoint) - 1);
    KolPoint := KolPoint- 1;
    Exit;
  end;
  Finalize(AllPoint[Index]);
  System.Move(AllPoint[Index +1], AllPoint[Index],
              (Length(AllPoint) - Index -1) * SizeOf(TAllPoint) + 1);
  SetLength(AllPoint, Length(AllPoint) - 1);
  KolPoint := KolPoint - 1
end;


end.
