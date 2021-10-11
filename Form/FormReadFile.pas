unit FormReadFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ClassReadFile, ImgList, ComCtrls, ToolWin, ExtCtrls,
  StdCtrls, ActnList;

type
  TfmReadFile = class(TForm)
    ControlBar1: TControlBar;
    Bar2: TToolBar;
    btElement: TToolButton;
    ImageList1: TImageList;
    ActionList1: TActionList;
    actOpenFile: TAction;
    Open: TOpenDialog;
    Memo: TMemo;
    actGetElement: TAction;
    Bar1: TToolBar;
    ToolButton2: TToolButton;
    Tree: TTreeView;
    actGetNets: TAction;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    actGetAll: TAction;
    Bar3: TToolBar;
    ToolButton4: TToolButton;
    actCreateElements: TAction;
    Bar: TProgressBar;
    procedure actCreateElementsExecute(Sender: TObject);
    procedure actGetAllExecute(Sender: TObject);
    procedure actGetNetsExecute(Sender: TObject);
    procedure actGetElementExecute(Sender: TObject);
    procedure actOpenFileExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    Read : TReadFile;
    // Метод в котором необходимо создавать все объекты
    procedure CreateObject;
    // Метод в котором необходимо уничтожать все объекты
    procedure FreeObject;
  end;

var
  fmReadFile: TfmReadFile;

implementation

{$R *.dfm}

uses ClassElement,fmMain,ClassManager,FormAddElement,ClassOptions;

procedure TfmReadFile.FormCreate(Sender: TObject);
begin
  CreateObject;
end;

procedure TfmReadFile.FormDestroy(Sender: TObject);
begin
  FreeObject;
end;

procedure TfmReadFile.actCreateElementsExecute(Sender: TObject);
var El : Telement;
    Uzel,Ravno : boolean;
    TempStr,ElName,Str,StrUzel,NumberUzel,TempUzel,NameUzel,TypeElement : string;
    X,CountStr,Y,Z,CountStrUzel : integer;
begin
  if MessageDlg('Схематично отображать элементы?',mtInformation, [mbOk,mbCancel],0) = mrCancel then
  begin
    ShowMiniElements := false;
  end
  else
  begin
    ShowMiniElements := true;
  end;
  if Manager.ElementsCount > 0 then
  begin
    if MessageDlg('Сейчас все элементы из прошлого проекта будут удалены. Вы Уверены?', mtInformation, [mbOk,mbCancel],0) = mrCancel then
    begin
      Exit;
    end
    else
    begin
      Manager.DeleteAll;
    end;
  end;
  El := TElement.Create;
  X := 0;
  Bar.Position := 0;
  Bar.Min := 0;
  BAr.Max := Tree.Items[0].Count;
  while X < Tree.Items[0].Count do
  begin
    CountStr := 1;
    Str := Tree.Items[0].Item[X].Text;
    elName := '';
    TypeElement := '';
    while CountStr < Length(Str) do
    begin
      if (Str[CountStr] = ';') then
      begin
        break;
      end
      else
      begin
       TypeElement := TypeElement + Str[CountStr];
      end;
      Inc(CountStr);
    end;
    Inc(CountStr);
    Inc(CountStr);
    while CountStr < Length(Str) do
    begin
      if ((Str[CountStr] >= '0')and(Str[CountStr] <= '9')) then
      begin
        TempStr := ElName;
        while CountStr < Length(Str) do
        begin
          if Str[CountStr] = '#' then break;
          
          TempStr := TempStr + Str[CountStr];
          Inc(CountStr);
        end;
        break;
      end
      else
      begin
        ElName := Elname + Str[CountStr];
      end;
      Inc(CountStr);
    end;
    Str := TempStr;
    if El.LoadElement(ElName,TypeElement) then
    begin
      Manager.AddElement(El);
      Y := 0;
      while Y < Tree.Items[Tree.Items[0].Count + 1].Count do
      begin
        //ShowMessage(Tree.Items[Tree.Items[0].Count + 1].Text);
        Z := 0;
        while Z < Tree.Items[Tree.Items[0].Count + 1].Item[Y].Count do
        begin
          //Showmessage(Tree.Items[Tree.Items[0].Count + 1].Item[Y].Text);
          StrUzel := Tree.Items[Tree.Items[0].Count + 1].Item[Y].Item[Z].Text;
          //ShowMessage(StrUZel);
          CountStrUzel := 1;
          UzeL := false;
          NumberUzel := '';
          Ravno := false;
          while CountStrUzel < Length(StrUzel) do
          begin
            if (StrUzel[CountStrUzel] = '.') then
            begin
              if Length(Str) > CountStrUzel - 1 then break;
              Inc(CountStrUzel);
              Uzel := true;
            end;
            if (StrUzel[CountStrUzel] <> Str[CountStrUzel])and(not uzel) then
            begin
              break;
            end;
            if Uzel then
            begin
              NumberUzel := NumberUzel + StrUzel[CountStrUZel];
            end;
            Inc(CountStrUzel);
          end;
          NameUzel := Tree.Items[Tree.Items[0].Count + 1].Item[Y].Text;
          if Uzel then Manager.AddUzel(NameUzel,StrToInt(NumberUzel));
          Inc(Z);
        end;
        Inc(Y);
      end;
    end
    else
    begin
      Str := 'Компонент '+ElName+' в базе данных не найден! Добавте этот элемент!';
      if ShowMessageNotElementdBD then
      begin
      if MessageDlg(Str + ' Добавить?', mtInformation, [mbOk,mbCancel],0) = mrOk then
      begin
        fmAddElement := TfmAddElement.Create(Application);
        fmAddElement.edShortName.Text := ElNAme;
        fmAddElement.edName.Text := TypeElement;
        fmAddElement.ShowModal;
        fmAddElement.Free;
        fmAddElement := nil;
        X := X - 1;
      end;
      end;    
    end;
    Inc(X);
    Bar.StepIt;
    //Bar.Position := X;
  end;
  FreeAndNil(El);
  Close;
end;

procedure TfmReadFile.actGetAllExecute(Sender: TObject);
begin
  Tree.Items[1].DeleteChildren;
  Read.GetNets(Tree);
  Tree.Items[0].DeleteChildren;
  Read.GetElement(Tree);
  Bar3.Buttons[0].Enabled := true;
end;

procedure TfmReadFile.actGetElementExecute(Sender: TObject);
begin
  Tree.Items[0].DeleteChildren;
  Read.GetElement(Tree);
end;

procedure TfmReadFile.actGetNetsExecute(Sender: TObject);
begin
  Tree.Items[1].DeleteChildren;
  Read.GetNets(Tree);
end;

procedure TfmReadFile.actOpenFileExecute(Sender: TObject);
begin
  if Open.Execute then
  begin
    Read.FileName := Open.FileName;
    Read.ShowFile(Memo);
    REad.OpenFile;
    Bar2.Buttons[0].Enabled := true;
    Bar2.Buttons[1].Enabled := true;
    Bar2.Buttons[2].Enabled := true;
  end;
end;

procedure TfmReadFile.CreateObject;
begin
  Read := TReadFile.Create;
end;

procedure TfmReadFile.FreeObject;
begin
 // Read.CloseFile;
  FreeAndNil(Read);
end;


end.
