unit ClassInformation;

interface

uses
  Grids,DBGrids,
  SysUtils,DateUtils,StdCtrls,types,Graphics,DataModule,comctrls,classes,ClassOptions;


type
  TInformation = class(TObject)  //Информация
  private
    Buf: PChar;
    procedure WriteText (Stream : TFileStream; Text : string);
  public
    procedure ShowElements(Tree,TreeUzel : TTReeView); //Показать данные о элементах
    function Save(FileName : string) : boolean;
  end;

implementation

uses ClassManager,ClassDraw;

function TInformation.Save(FileName: string) : boolean;
var Stream: TFileStream;
    X,Y,Z,Index,Kol1,Kol2 : integer;
begin
  Result := true;
  Buf := StrAlloc(1024);
  Z := Length(FileName) - 3;
  if FileName[Z] <> '.' then
  begin
    Stream := TFileStream.Create(FileName+'.prk',fmCreate);
  end
  else
  begin
    Stream := TFileStream.Create(FileName,fmCreate);
  end;
  X := 0;
  try
  while X < Manager.PlatsCount do
  begin
    WriteText(Stream,'!PLATS!');
    WriteText(Stream,#13#10);
    WriteText(Stream,'Имя платы: A-' + IntToStr(X+1));
    WriteText(Stream,#13#10);
    WriteText(Stream,'Количество посадочных мест: ' + IntToStr(Manager.Plats[X].CountKletok));
    WriteText(Stream,#13#10);
    Kol1 := Round((Manager.Plats[X].NizPoint.Y-Manager.Plats[X].VerhPoint.Y)/ShagSetk);
    Kol2 := Round((Manager.Plats[X].NizPoint.X-Manager.Plats[X].VerhPoint.X)/ShagSetk);
    WriteText(Stream,'Количество посадочных мест по вертикале: '+IntToStr(Kol1));
    WriteText(Stream,#13#10);
    WriteText(Stream,'Количество посадочных мест по горизонтале: '+IntToStr(Kol2));
    WriteText(Stream,#13#10);
    WriteText(Stream,'Элементы на плате (номер посадочного места: имя[тип])');
    WriteText(Stream,#13#10);
    WriteText(Stream,'!ELEMENTSONPLATS!');
    WriteText(Stream,#13#10);
    Y := 0;
    while Y < Manager.Plats[X].CountKletok do
    begin
      WriteText(Stream,IntToStr(Y + 1) + ': ');
      Index := Manager.FindElement(MyGrid.Kletki[Manager.Plats[X].Kletki[Y]].NameEl);
      if Index > -1 then
      begin
        WriteText(Stream,MyGrid.Kletki[Manager.Plats[X].Kletki[Y]].NameEl + '[');
        WriteText(Stream,Manager.Elements[Index].ShortName + ']');
      end;
      WriteText(Stream,#13#10);
      Inc(Y);
    end;
    WriteText(Stream,'!END!');
    WriteText(Stream,#13#10);
    Inc(X);
  end;
  X := 0;
  WriteText(Stream,#13#10);
  WriteText(Stream,'Имя узла: элемент и его пин;');
  WriteText(Stream,#13#10);
  WriteText(Stream,'!UZELS!');
  WriteText(Stream,#13#10);
  while X < Manager.UzelsCount do
  begin
    Y := 0;
    WriteText(Stream,Manager.UZels[X].Name + ':');
    while Y < Manager.Uzels[X].CountElements do
    begin
      WriteText(Stream,' ' + Manager.Uzels[X].Elements[Y].Name+'.'+IntToStr(Manager.Uzels[X].Elements[Y].NumberConnect));
      Inc(Y);
    end;
    WriteText(Stream,';');
    WriteText(Stream,#13#10);
    Inc(X);
  end;
  WriteText(Stream,'!END!');
  Stream.Free;
  except
    Result := false;

  end;
end;

procedure TInformation.WriteText(Stream: TFileStream; Text: string);
begin
   StrPCopy(Buf,Text);
   Stream.Write(Buf[0],StrLen(Buf));
end;


procedure TInformation.ShowElements(Tree,TreeUzel: TTreeView);
var Ind,Count,IndF : integer;
    Str : string;
begin
  Ind := 0;
  Tree.Items.Clear;
  Tree.Items.Add(Tree.Items.GetFirstNode,'Элементы');
  //Tree.Items[0].Text := 'Элементы';
  while Ind < Manager.ElementsCount do
  begin
    Str := Manager.Elements[Ind].Name ;
   // Str := Manager.Elements[Ind].ShortName;
    Tree.Items.AddChild(Tree.Items[0],Str);
    Inc(Ind);
  end;
  Ind := 0;
  Count := Tree.Items[0].Count + 1;
  TreeUzel.Items.Clear;
  TreeUzel.Items.Add(TreeUzel.Items.GetFirstNode,'Узлы');
  while Ind < Manager.UzelsCount do
  begin
    Str := Manager.Uzels[Ind].Name;
    Tree.Items.AddChild(TreeUzel.Items[0],Str);
    IndF := 0;
    while IndF < Manager.Uzels[Ind].CountElements do
    begin
      Str := Manager.Uzels[Ind].Elements[IndF].Name;
      Str := Str + '.' + IntToStr(Manager.Uzels[Ind].Elements[IndF].NumberConnect);
      TreeUzel.Items.AddChild(TreeUzel.Items[0].Item[Ind],Str);
      Inc(IndF);
    end;
    Inc(Ind);
  end;
end;

end.
