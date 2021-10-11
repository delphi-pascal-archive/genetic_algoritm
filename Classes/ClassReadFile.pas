unit ClassReadFile;

interface

uses
  Grids,DBGrids,SysUtils,StdCtrls,classes,Dialogs,comctrls;

  type

  TReadFile = class(TObject)//Класс прочтения файла
  private
    FFileName : string;
    Text : TMemo;
    FElements : TStringList;
    procedure SetNameFile(Value : string);
  public
    procedure CloseFile;
    procedure OpenFile;
    procedure ShowFile(Memo : TMemo);
    procedure GetElement(Tree : TTreeView);//Прочесть элементы
    procedure GetNets(Tree : TTreeView); //Прочесть узлы
    function FindNetPart : integer;//Функция находит индекс после которго идут узлы
    property FileName : String read FFileName write SetNameFile;
    property Elements : TStringList read FElements;
  end;


implementation

procedure TreadFile.SetNameFile(Value: string);
begin
  FFileName := Value;
end;

function TReadFile.FindNetPart : integer;
var Index : integer;
begin
  Index := 0;
  while (Index < Text.Lines.Count) do
  begin
    if Text.Lines[Index] = '$NETS' then
    begin
      break;
    end;
    Inc(Index);
  end;
  Result := Index + 1;
end;

procedure TReadFile.GetElement(Tree : TTreeView);
var Index,IndexStr : integer;
    TempStr,Element : string;
    El : boolean;
begin
  Index := 0;
  FElements := TstringList.Create;
  while (Index < Text.Lines.Count) do
  begin
    El := false;
    Element := '';
    TempStr := Text.Lines[Index];
    IndexStr := 0;
    while IndexStr <= Length(TempStr) do
    begin
      if TempStr[IndexStr] = '!' then
      begin
        IndexStr := IndexStr + 2;
        El := true;
      end;
      if El then Element := Element + TempStr[IndexStr];
      Inc(IndexStr);
    end;
    IndexStr := IndexStr - 1;
    while IndexStr <= Length(TempStr) do
    begin
      if TempStr[IndexStr] = ';' then
      begin
        IndexStr := IndexStr + 2;
        El := true;
      end;
      if El then Element := Element + TempStr[IndexStr];
      Inc(IndexStr);
    end;
    if el then
    begin
  //    ShowMessage(Element);
      Felements.Add(Element);
    end;
    if Text.Lines[Index] = '$NETS' then
    begin
      break;
    end;
    Inc(Index);
  end;
  Index := 0;
  while Index < Elements.Count do
  begin
    Tree.Items.AddChild(Tree.Items[0],Elements[Index]);
    Inc(Index);
  end;
  
end;

procedure TReadFile.GetNets(Tree : TTreeView);
var Index,IndexStr,TempIndex,Item : integer;
    TempStr,Nets,NameUsel : string;
    Net : boolean;
begin
  Index := FindNetPart;
  Item := -1;
  while (Index < Text.Lines.Count) do
  begin
    if (Text.Lines[Index] = '$END') then break;
    TempStr := Text.Lines[Index];
    IndexStr := 0;
    while IndexStr <= Length(TempStr) do
    begin
      if TempStr[IndexStr] = ';' then
      begin
      TempIndex := 1;
        while TempIndex < IndexStr do
        begin
          NameUsel := NameUsel + TempStr[TempIndex];
          Inc(TempIndex);
        end;
        Tree.Items.AddChild(Tree.Items[1],NameUsel);
        NameUsel := '';
        IndexStr := IndexStr + 3;
        TempIndex := IndexStr;
        Inc(Item);
      end;
      if ((TempStr[IndexStr] = ' ')) then
      begin
        while TempIndex < IndexStr do
        begin
          Nets := Nets + TempStr[TempIndex];
          Inc(TempIndex);
        end;
        Tree.Items.AddChild(Tree.Items[1].Item[Item],Nets);
        Nets := '';
        Inc(IndexStr);
        TempIndex := IndexStr;
      end;
      if ((TempStr[IndexStr] = ',')) then
      begin
        while TempIndex < IndexStr do
        begin
          Nets := Nets + TempStr[TempIndex];
          Inc(TempIndex);
        end;
        Tree.Items.AddChild(Tree.Items[1].Item[Item],Nets);
        Nets := '';
        Inc(Index);
        TempStr := Text.Lines[Index];
        IndexStr := 5;
        TempIndex := 6;
        Net := true;
      end;
      if (TempStr [IndexStr-1] <> ',')and(IndexStr = Length(TempStr)) then
      begin
      while TempIndex <= IndexStr do
        begin
          NameUsel := NameUsel + TempStr[TempIndex];
          Inc(TempIndex);
        end;
        Tree.Items.AddChild(Tree.Items[1].Item[Item],NameUsel);
        NameUsel := '';
        Net := false;
      end;
      Inc(IndexStr);
    end;   
    Inc(Index);
  end;
end;

procedure TreadFile.OpenFile;
begin
//
end;

procedure TReadFile.CloseFile;
begin
//
end;

procedure TReadFile.ShowFile(Memo : TMemo);
begin
  Memo.Lines.LoadFromFile(FFileName);
  Text := Memo;
end;

end.
