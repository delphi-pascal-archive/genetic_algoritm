unit ClassDraw;

interface

uses
  Grids,DBGrids,
  SysUtils,DateUtils,StdCtrls,types,Graphics,DataModule,Classes,
  ExtCtrls,Controls,ClassOptions,ClassGrid,ClassElement;


type
  TDraw = class(TPersistent)   //Класс прорисовки
  private
    FImage : TImage;
    FGrid : TImage;

  public
    constructor Create(Im : TImage);
    destructor Destroy;
    procedure Clear;
    procedure DrawPlat(X1,Y1,X2,Y2 : integer); //Прорисовка плат
    procedure ClearZone(X1,Y1,X2,Y2 : integer); //Очистить зону
    procedure DrawMoreZone(Uzel : string); //Прорисовка нескольких зон вокруг элемента
    procedure DrawZone(Index : integer); //Прорисовка зоны
    procedure DrawLineUzel(Index : integer); //Прорисовк соединений
    procedure Draw(Name : string;X,Y : Integer); //Прорисовка элемента
    procedure DrawAllPlat;  //Прорисовка всех плат
    procedure DrawAll; //Прорисовка всего
    procedure DrawAllnoLine;
    procedure DrawFirst;    //Первая прорисовка
    procedure DrawGrid;    //Прорисовка сетки
    procedure SnapEl(IndexKl: Integer; IndexEl: Integer);//Прицепить эл-т к клетке
    procedure SnapToGrid(El : TElement); //Привязка элемента
    procedure ChangePoz (Index : Integer;X,Y : integer); //Изменить позицию элемента
    property Image : TImage read FImage write FImage;
    property Grid : TImage read FGrid write FGrid;
  end;

var MyGrid : TMyGrid;

implementation

uses ClassManager;

constructor TDraw.Create(Im: TImage);
begin
  Image := Im;
  Image.SetBounds(0,0,3000,3000);
  Image.ControlStyle := Image.ControlStyle + [ csOpaque ] ;

  Clear;
end;

procedure TDraw.SnapEl(IndexKl: Integer; IndexEl: Integer);
var P : TPoint;
begin
  P.X := MyGrid.Kletki[IndexKl].VerhPoint.X + 1;
  P.Y := MyGrid.Kletki[IndexKl].VerhPoint.Y + 1;
  Manager.Elements[IndexEl].VerhPoint := P;
  MyGrid.SnapToGrid(Manager.Elements[IndexEl]);
end;

destructor TDraw.Destroy;
begin
  FreeAndNil(MyGrid);
end;

procedure TDraw.DrawAllPlat;
var X : integer;
begin
  X := 0;
  Image.Canvas.Brush.Color := clWhite;
  Image.Canvas.Brush.Style := bsClear;
  Image.Canvas.Pen.Color := clBlack;
  Image.Canvas.Pen.Width := 3;
  while X < Manager.PlatsCount do
  begin
    Image.Canvas.Rectangle(Manager.Plats[X].VerhPoint.X,Manager.Plats[X].VerhPoint.Y,
                          Manager.Plats[X].NizPoint.X,Manager.Plats[X].NizPoint.Y);
    Image.Canvas.Font.Height := 40;
    Image.Canvas.TextOut(Manager.Plats[X].VerhPoint.X ,Manager.Plats[X].VerhPoint.Y - 40,'A-'+IntToStr(X+1));
    Inc(X);
  end;
end;

procedure TDraw.DrawPlat(X1,Y1: Integer; X2,Y2: Integer);
begin
  DrawAll;
  Image.Canvas.Brush.Color := clWhite;
  Image.Canvas.Brush.Style := bsClear;
  Image.Canvas.Pen.Color := clBlack;
  Image.Canvas.Rectangle(X1,Y1,X2,Y2);
end;

procedure TDraw.SnapToGrid(El : TElement);
var TX,TY : integer;
begin
  MyGrid.SnapToGrid(El);
end;

procedure TDraw.DrawGrid;
var I: integer;
begin
  MyGrid := TmyGrid.Create(Image.Height,Image.Width);
  MyGrid.DrawGrid;
end;


procedure TDraw.DrawLineUzel(Index: Integer);
var X,Ind,Con : integer;
    Point : TPoint;
begin
  X := 0;
  Image.Canvas.Pen.Color := clBlue;
  Image.Canvas.Pen.Style := psSolid;
  Image.Canvas.Pen.Width := 1;
  Ind := Manager.FindElement(Manager.Uzels[Index].Elements[X].Name);
  if Ind > -1 then
  begin
    Con := Manager.Uzels[Index].Elements[X].NumberConnect;
    Point := Manager.Elements[Ind].PointConnect[Con-1];
    Point.X := Point.X + Manager.Elements[Ind].VerhPoint.X;
    Point.Y := Point.Y + Manager.Elements[Ind].VerhPoint.Y;
    Image.Canvas.PenPos := Point;
  end;
  X := 1;
  while X < Manager.Uzels[Index].CountElements do
  begin
    Ind := Manager.FindElement(Manager.Uzels[Index].Elements[X].Name);
    Con := Manager.Uzels[Index].Elements[X].NumberConnect;
    Point := Manager.Elements[Ind].PointConnect[Con-1];
    Point.X := Point.X + Manager.Elements[Ind].VerhPoint.X;
    Point.Y := Point.Y + Manager.Elements[Ind].VerhPoint.Y;
    Image.Canvas.LineTo(Point.X,Point.Y);
    Inc(X);
  end;
end;

procedure TDraw.DrawMoreZone(Uzel: string);
var Ind,X,Temp : integer;
begin
  X := Manager.FindUzel(Uzel);
  if X > -1 then
  begin
    Ind := 0;
    while Ind < Manager.Uzels[X].CountElements do
    begin
      Temp := Manager.FindElement(Manager.Uzels[X].Elements[Ind].Name);
      DrawZone(Temp);
      Inc(Ind);
    end;
  end;
end;

procedure TDraw.ClearZone(X1: Integer; Y1: Integer; X2: Integer; Y2: Integer);
begin
  Image.Canvas.Brush.Color := clWhite;
  Image.Canvas.Pen.Color := clWhite;
  Image.Canvas.Rectangle(X1,Y1,X2,Y2);
end;

procedure TDraw.DrawZone(Index: Integer);
begin
  Image.Canvas.Pen.Color := clRed;
  Image.Canvas.Pen.Style := psDot;
  Image.Canvas.Brush.Style := bsClear;
  Image.Canvas.Pen.Width := 2;
  Image.Canvas.Rectangle(Manager.Elements[Index].VerhPoint.X,Manager.Elements[Index].VerhPoint.Y,
            Manager.Elements[Index].NizPoint.X,Manager.Elements[Index].NizPoint.Y);
end;

procedure TDraw.ChangePoz(Index: Integer; X: Integer; Y: Integer);
var P : TPoint;
begin
  //ClearZone(X,Y,X + Manager.Elements[Index].Picture.Width, Y + Manager.Elements[Index].Picture.Height);
  DrawAll;
  Image.Canvas.Pen.Color := clRed;
  Image.Canvas.Pen.Style := psDot;
  Image.Canvas.Brush.Style := bsSolid;
  Image.Canvas.Pen.Width := 1;
  Image.Canvas.Rectangle(X,Y,X + Manager.Elements[Index].Picture.Width, Y + Manager.Elements[Index].Picture.Height);
end;

procedure TDraw.Draw(Name: string;X,Y : Integer);
var Index : integer;
    P : TPoint;
begin
  Index := manager.FindElement(Name);
  P.X := X;
  P.Y := Y;
  Manager.Elements[Index].VerhPoint := P;
 // MyGrid.SnapToGrid(Manager.Elements[Index]);
  Image.Canvas.Draw(X,Y,Manager.Elements[Index].Picture);
  Image.Canvas.Font.Height := 15;
  Image.Canvas.Brush.Color := clWhite;
  Image.Canvas.Brush.Style := bsClear;
  if ShowMiniElements then
  begin
    Image.Canvas.TextOut(Manager.Elements[Index].NizPoint.X + 3,
                      Manager.Elements[Index].VerhPoint.Y,
                      Manager.Elements[Index].ShortName + Manager.Elements[Index].GetNumber);
  end
  else
  begin
    Image.Canvas.TextOut(Manager.Elements[Index].NizPoint.X + 3,
                      Manager.Elements[Index].VerhPoint.Y,
                      Manager.Elements[Index].Name );
  end;
end;

procedure TDraw.DrawFirst;
var Z,X,Y : integer;
    P : TPoint;
begin
  Clear;
  Z := 0;
  X := 0;
  Y := 0;
  while Z < Manager.ElementsCount do
  begin
    if X > Image.Width then
    begin
      X := 0;
      Y := Y + Manager.Elements[Z - 1].Picture.Height;
    end;
    Draw(Manager.Elements[Z].Name,X,Y);
    X := X + Manager.Elements[Z].Picture.Width;
    if Manager.Elements[Z].Picture.Height > Manager.Elements[Z].Picture.Width then
    begin
      if ShagSetk < Manager.Elements[Z].Picture.Height then ShagSetk := Manager.Elements[Z].Picture.Height;
    end
    else
    begin
      if ShagSetk < Manager.Elements[Z].Picture.Width then SHagSetk :=Manager.Elements[Z].Picture.Width;
    end;
    Inc(Z);
  end;
  DrawGrid;
end;

procedure TDraw.DrawAllnoLine;
var Z,X,Y : integer;
  Rect1 : TRect;
  Rect2 : TRect;
begin
  //Clear;
  REct1.TopLeft.X := 0;
  Rect1.TopLeft.Y := 0;
  Rect1.BottomRight.X := Image.Width;
  Rect1.BottomRight.Y := Image.Height;
  if VisibleGrid then
  begin
    Image.Canvas.CopyRect(Rect1,MyGrid.MyGrid.Canvas,Rect1);
  end
  else
  begin
    Clear;
  end;
  Z := 0;

 { X := 0;
  Y := 0;  }
  while Z < Manager.ElementsCount do
  begin
  {  if X > Image.Width then
    begin
      X := 0;
      Y := Y + Manager.Elements[Z - 1].Picture.Height;
    end;  }
    Draw(Manager.Elements[Z].Name,Manager.Elements[Z].VerhPoint.X,Manager.Elements[Z].VerhPoint.Y);

  //  X := X + Manager.Elements[Z].Picture.Width;
    Inc(Z);
  end;
  DrawallPlat;
end;

procedure Tdraw.DrawAll;
var Z,X,Y : integer;
  Rect1 : TRect;
  Rect2 : TRect;
begin
  //Clear;
  REct1.TopLeft.X := 0;
  Rect1.TopLeft.Y := 0;
  Rect1.BottomRight.X := Image.Width;
  Rect1.BottomRight.Y := Image.Height;
  if VisibleGrid then
  begin
    Image.Canvas.CopyRect(Rect1,MyGrid.MyGrid.Canvas,Rect1);
  end
  else
  begin
    Clear;
  end;
  Z := 0;
  while Z < Manager.UzelsCount do
  begin
    DrawLineUzel(Z);
    Inc(Z);
  end;
  Z := 0;

 { X := 0;
  Y := 0;  }
  while Z < Manager.ElementsCount do
  begin
  {  if X > Image.Width then
    begin
      X := 0;
      Y := Y + Manager.Elements[Z - 1].Picture.Height;
    end;  }
    Draw(Manager.Elements[Z].Name,Manager.Elements[Z].VerhPoint.X,Manager.Elements[Z].VerhPoint.Y);

  //  X := X + Manager.Elements[Z].Picture.Width;
    Inc(Z);
  end;
  DrawallPlat;
end;

procedure TDraw.Clear;
begin
  Image.Canvas.Brush.Color := clWhite;
  Image.Canvas.Pen.Color := clWhite;
  Image.Canvas.Rectangle(0,0,Image.Width,Image.Height);
end;

end.
