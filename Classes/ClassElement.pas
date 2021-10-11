unit ClassElement;

interface

uses
  Grids,DBGrids,
  SysUtils,DateUtils,StdCtrls,types,Graphics,DataModule,Classes,CLassOptions;


type
  APointConnect = array of TPoint;
  TElement = class(TPersistent)  //Класс элементов
  private
    CountPointConnect: Integer;
    FName: string;
    FPictureN: TBitmap;
    FPictureR: TBitmap;
    Fpicture : TBitMap;
    FPointConnect: APointConnect;
    FRotate: Boolean;
    FShortName: string;
    FTypeElement: string;
    FZakr : boolean;
    FVerhPoint,FNizPoint : Tpoint;
    procedure SetName(Value: string);
    procedure SetPictureN(Value: TBitmap);
    procedure SetPictureR(Value: TBitmap);
    procedure SetRotate(Value: Boolean);
    procedure SetShortName(Value: string);
    procedure SetTypeElement(Value: string);
    procedure SetVerxPoint(Point : TPoint);
  public
    procedure ChangeZakr;
    constructor Create();
    destructor Destroy;
    procedure AddPointConnect(Point : TPoint);   //Добавить пин
    procedure ChangeRotate; //Повернуть
    function GetNumber : string;
    procedure DeletePointConnect(Index: Integer); //Удалить пин
    procedure SaveElement(PictureN,PictureR : String); //Сохр эл-т в БД
    procedure Copy (El : TElement); //Скопировать один в другой
    function LoadElement(NameEl,TypeElement: string) : boolean; //Загрузить эл-т из БД
    property Name: string read FName write SetName;
    property PictureN: TBitmap write SetPictureN;
    property PictureR: TBitmap write SetPictureR;
    property Picture : TBitmap read FPicture;
    property PointConnect: APointConnect read FPointConnect;
    property Rotate: Boolean read FRotate write SetRotate;
    property ShortName: string read FShortName write SetShortName;
    property TypeElement: string read FTypeElement write SetTypeElement;
    property VerhPoint : Tpoint read FVerhPoint write SetVerxPoint;
    property NizPoint : Tpoint read FNizPoint;
    property Zakr : boolean read FZakr;
  end;
  
implementation

uses ClassManager;

{
*********************************** TElement ***********************************
}
constructor TElement.Create;
begin
  inherited;
  CountPointConnect := 0;
  FZakr := false;
  FPictureN := TBitmap.Create;
  FPictureN.Transparent := true;
  FPictureR := TBitmap.Create;
  FPictureR.Transparent := true;
  FPicture := TBitmap.Create;
 // FPicture.Transparent := true;
  FRotate := false;
end;

destructor TElement.Destroy;
begin
  inherited;
  FreeAndNil(FPointConnect);
  FreeAndNil(FPictureN);
  FreeAndNil(FPictureR);
  FreeAndNil(FPicture);
end;

function TElement.GetNumber : string;
var X : integer;
    Str : string;
begin
  Result := '';
  Str := '';
  X := 3;
  while X <= Length(FName) do
  begin
    Str := Str + Name[X];
    Inc(X);
  end;
  Result := Str;
end;

procedure TElement.Copy(El: TElement);
var X : integer;
begin
  FName := El.FName;
  FPictureN.Assign(El.FPictureN);
  FPictureR.Assign(El.FPictureR);
  Rotate := El.FRotate;
  FShortName := El.FShortName;
  FTypeElement := El.FTypeElement;
  x := 0;
  while X < El.CountPointConnect do
  begin
    AddPointConnect(El.FPointConnect[X]);
    Inc(X);
  end;
end;

procedure TElement.SetVerxPoint(Point : Tpoint);
begin
  FVerhPoint := Point;
  FNizPoint.X := Point.X + FPicture.Width;
  FNizPoint.Y := Point.Y + FPicture.Height;
end;

function TElement.LoadElement(NameEl,TypeElement: string) : boolean;
var ID : integer;
    Point : TPoint;
begin
  Result := true;
  with Data do
  begin
    Dataset.Active := false;
    DataSet.SelectSQL.Clear;
    DataSet.SelectSQL.Add('select * from TABLE_ELEMENT_S(:NAME,:TYPE_EL)');
    FShortName := NameEl;
    //FName := TypeElement;
    if ShowMiniElements then
    begin
      NameEl := 'zx';
      TypeElement := 'Схематичный элемент';
    end;
    Dataset.ParamByName('NAME').AsString := NameEl;
    DataSet.ParamByName('TYPE_EL').AsString := TypeElement;
    DataSet.Active := true;
    FTypeElement := DataSet.FieldByName('NAME').AsString;
    if not ShowMiniElements  then
    begin
      FShortName := TypeElement;
    end
    else
    begin
      TypeElement := FShortName;
    end;
    if FTypeElement <> '' then
    begin
      Fname := NameEl + IntToStr(Manager.ElementsCount + 1);
      FPictureN.Assign(DataSet.FieldByName('Picture_N'));
      FPictureR.Assign(Dataset.FieldByName('Picture_R'));
      if FPictureN.Height > FPictureN.Width then
      begin
        if ShagSetk < FPictureN.Height then ShagSetk := FPictureN.Height;
      end
      else
      begin
        if ShagSetk < FPictureN.Width then SHagSetk := FPictureN.Width;
      end;
      CountPointConnect := 0;
     // CountPointConnect := DataSet.FieldByName('KOL_CONNECT').AsInteger;

      ID := DataSet.FieldByName('ID').AsInteger;
      Dataset.Active := false;
      DataSet.SelectSQL.Clear;
      DataSet.SelectSQL.Add('select * from LINK_ELEMENT_CONNECT_S');
      DataSet.SelectSQL.Add('(:FK)') ;
      Dataset.ParamByName('FK').AsInteger := ID;
      DataSet.Active := true;
      DataSet.First;
      while not DataSet.Eof do
      begin
        Point.X := DataSet.FieldByName('X').AsInteger;
        Point.Y := DataSet.FieldByName('Y').AsInteger;
        AddPointConnect(Point);
        DataSet.Next;
      end;
      DataSet.Active := false;
    end
    else
    begin
      Result := false;
    end;
  end;
end;

procedure TElement.AddPointConnect(Point : TPoint);
begin
  SetLength(FPointConnect, Length(FPointConnect) + 1);
  FPointConnect[CountPointConnect] := Point;
  Inc(CountPointConnect);
end;

procedure TElement.ChangeRotate;
var X,T : integer;
begin
  if Rotate then
  begin
    Rotate := false;
  end
  else
  begin
    Rotate := true;
  end;
  X := 0;
  while X < CountPointConnect do
  begin
    T := FPointConnect[X].Y;
    FPointConnect[X].Y := FPointConnect[X].X;
    FPointConnect[X].X := T;
    Inc(X);
  end;
end;

procedure TElement.ChangeZakr;
begin
  if FZakr then
  begin
    FZakr := false;
  end
  else
  begin
    FZakr := true;
  end;
end;

procedure TElement.DeletePointConnect(Index: Integer);
begin
  if Index > High(FPointConnect) then Exit;
  if Index < Low(FPointConnect) then Exit;
  if Index = High(FPointConnect) then
  begin
    SetLength(FPointConnect, Length(FPointConnect) - 1);
    CountPointConnect := CountPointConnect - 1;
    Exit;
  end;
  Finalize(FPointConnect[Index]);
  System.Move(FPointConnect[Index +1], FPointConnect[Index],
              (Length(FPointConnect) - Index -1) * SizeOf(TPoint) + 1);
  SetLength(FPointConnect, Length(FPointConnect) - 1);
  CountPointConnect := CountPointConnect - 1;
end;

procedure TElement.SaveElement(PictureN,PictureR : String);
var IDElement,Z : integer;
begin
  with Data do
  begin
    Dataset.Active := false;
    DataSet.SelectSQL.Clear;
    DataSet.SelectSQL.Add('execute procedure TABLE_ELEMENT_I');
    DataSet.SelectSQL.Add('(:NAME,:SMALL_NAME,:KOL_CONNECT,:PICTURE_N,:PICTURE_R)');
    DataSet.ParamByName('PICTURE_N').LoadFromFile(PictureN);
    DataSet.ParamByName('PICTURE_R').LoadFromFile(PictureR);
    DataSet.ParamByName('NAME').AsString := FName;
    DataSet.ParamByName('SMALL_NAME').AsString := FShortName;
    DataSet.ParamByName('KOL_CONNECT').AsInteger := CountPointConnect;
    DataSet.ExecSQL;
    CommitTr;
    DataSet.Active := false;
    DataSet.SelectSQL.Clear;
    DataSet.SelectSQL.Add('select * from SELECT_ID_ELEMENT');
    DataSet.Active := true;
    IDElement := DataSet.Fields[0].AsInteger;
    DataSet.Active := false;
    DataSet.SelectSQL.Clear;
    DataSet.SelectSQL.Add('execute procedure LINK_ELEMENT_CONNECT_I');
    DataSet.SelectSQL.Add(':X,:Y,:NUMBER,:FK_TABLE_ELEMENT');
    Z := 0;
    while Z < CountPointConnect do
    begin
      DataSet.ParamByName('X').AsInteger := PointConnect[Z].X;
      DataSet.ParamByName('Y').AsInteger := PointConnect[Z].Y;
      Dataset.ParamByName('FK_TABLE_ELEMENT').AsInteger := IDElement;
      DataSet.ParamByName('NUMBER').AsInteger := Z + 1;
      DataSet.ExecSQL;
      CommitTr;
      DataSet.Active := false;
      Inc(Z);
    end;
  end;
end;

procedure TElement.SetName(Value: string);
begin
  FName := Value;
end;

procedure TElement.SetPictureN(Value: TBitmap);
begin
  FPictureN := Value;
end;

procedure TElement.SetPictureR(Value: TBitmap);
begin
  FPictureR := Value;
end;

procedure TElement.SetRotate(Value: Boolean);
begin
  FRotate := Value;
  if FRotate then
  begin
    FPicture := FPictureR;
  end
  else
  begin
    FPicture := FPictureN;
  end;
end;

procedure TElement.SetShortName(Value: string);
begin
  FShortName := Value;
end;

procedure TElement.SetTypeElement(Value: string);
begin
  FTypeElement := value;
end;


end.
