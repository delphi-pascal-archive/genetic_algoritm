unit fmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, Menus,inifiles, StdCtrls,Datamodule,ClassManager, ExtCtrls,
  ComCtrls,ClassInformation,ClassDraw, ToolWin,ClassGrid,ClassGenAlg,ClassTrass;

type
  TMainFm = class(TForm)
    ActionList1: TActionList;
    actExit: TAction;
    actFormReadFile: TAction;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    actAddElement: TAction;
    actAddElement1: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Tree: TTreeView;
    PaintBox: TImage;
    actOptionsOpen: TAction;
    N5: TMenuItem;
    N6: TMenuItem;
    GroupBox1: TGroupBox;
    actFormManagerBD: TAction;
    N7: TMenuItem;
    N8: TMenuItem;
    PopupMenu1: TPopupMenu;
    N9: TMenuItem;
    TreeUzel: TTreeView;
    PopupMenu2: TPopupMenu;
    N10: TMenuItem;
    Panel3: TPanel;
    Button1: TButton;
    N11: TMenuItem;
    N12: TMenuItem;
    Status: TStatusBar;
    btRazm: TButton;
    Time: TTimer;
    btRazmCont: TButton;
    Panel4: TPanel;
    Panel5: TPanel;
    Prog: TProgressBar;
    Button2: TButton;
    N13: TMenuItem;
    btKomp: TButton;
    Time2: TTimer;
    btKompCont: TButton;
    Button3: TButton;
    N14: TMenuItem;
    ScrollBox1: TScrollBox;
    N15: TMenuItem;
    Save: TSaveDialog;
    procedure N15Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btKompContClick(Sender: TObject);
    procedure Time2Timer(Sender: TObject);
    procedure btKompClick(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btRazmContClick(Sender: TObject);
    procedure TimeTimer(Sender: TObject);
    procedure btRazmClick(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure TreeClick(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure PaintBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxClick(Sender: TObject);
    procedure PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure N8Click(Sender: TObject);
    procedure actFormManagerBDExecute(Sender: TObject);
    procedure PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure actOptionsOpenExecute(Sender: TObject);
    procedure actAddElementExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actFormReadFileExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function DrawPlat (X : integer) : integer;
  private
    { Private declarations }
  public
    { Public declarations }
    PX,PY : integer;
    Index,KolPlat,isKolPlat : integer;
    Info : TInformation;
    PointPlat : Tpoint;
    AlgStart,IsStopAlg : boolean;
    CheckObj,Move,PaintPlat,isPaintPlat : boolean;
    Trass : TTrass;
    procedure CreateChildForm(form: TForm; TForms: TFormClass);
  protected
    //Draw : TDraw;
    GenAlg : TGenAlg;
    // Метод в котором необходимо создавать все объекты
    procedure CreateObject;
    // Метод в котором необходимо уничтожать все объекты
    procedure FreeObject;
  end;


var
  MainFm: TMainFm;
  Draw : TDraw;



implementation

{$R *.dfm}

uses FormReadFile,ClassMatrR,FormAddElement,ClassOptions,FormOptions,FormMAnagerBD;

function TMainfm.DrawPlat(X: Integer) : integer;
begin
  Inc(X);
  if KolPlat < X then
  begin
    PaintPlat := false;

    if Manager.ElementsCount > Manager.CountVakMest then
    begin
      ShowMessage('Количество вакантных мест меньше чем элементов! Создайте платы заново!');
      Manager.DeleteAllPlata;
    end;
  end
  else
  begin
    //ShowMessage('Нарисуйте ' + IntToStr(X) + ' плату');
    PaintPlat := true;
  end;
  Status.Panels[3].Text := IntToStr(Manager.CountVakMest);
  Result := X;
end;

procedure TMainfm.CreateChildForm(form: TForm; TForms: TFormClass);
begin
  form:=TForms.Create(Application);
  form.ShowModal;
  form.Free;
  form:=nil;
end;

procedure TMainFm.FormCreate(Sender: TObject);
begin
  CreateObject;
end;

procedure TMainFm.FormDestroy(Sender: TObject);
begin
  FreeObject;
end;

procedure TMainfm.FreeObject;
begin
  FreeAndNil(Manager);
  FreeAndNil(Info);
  FreeAndnil(Draw);
end;

procedure TMainFm.N10Click(Sender: TObject);
begin
  if (Manager.UzelsCount > 0)and(TreeUzel.Selected.Text <> 'Узлы') then
  begin
    try
      Draw.DrawAll;
      Draw.DrawMoreZone(TreeUzel.Selected.Text);
    except

    end;

  end;
end;

procedure TMainFm.N11Click(Sender: TObject);
begin
  VisibleGrid := N11.Checked;
end;

procedure TMainFm.N12Click(Sender: TObject);
begin
  IsSnap := N12.Checked;
end;

procedure TMainFm.N13Click(Sender: TObject);
begin
  if Index > -1 then
    Manager.Elements[Index].ChangeZakr;
end;

procedure TMainFm.N14Click(Sender: TObject);
begin
if (Manager.UzelsCount > 0)and(TreeUzel.Selected.Text <> 'Узлы') then
  begin
    try
      Draw.DrawAllnoLine;
      Trass.ShowTrass(Manager.FindUzel(TreeUzel.Selected.Text));
    except

    end;

  end;
end;

procedure TMainFm.N15Click(Sender: TObject);
begin
  if Save.Execute then
  begin
    if Info.Save(Save.FileName) then ShowMessage('Файл '+Save.FileName+' успешно сохранен!');
  end;
end;

procedure TMainFm.N8Click(Sender: TObject);
begin
  if ShowMiniElements then
  begin
    N8.Checked := false;
  end;
  Panel1.Visible := N8.Checked;
  Draw.DrawGrid;
end;

procedure TMainFm.N9Click(Sender: TObject);
begin
  if Index > -1 then
  begin
    Manager.Elements[Index].ChangeRotate;
    Draw.DrawAll;
    Draw.DrawZone(Index);
  end;
end;

procedure TMainFm.PaintBoxClick(Sender: TObject);
begin
 { Index := Manager.FindByPoint(PX,PY);
  if Index > -1 then
  begin
    Draw.DrawZone(Index);
  end;            }
end;

procedure TMainFm.PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  //ShowMessage(intToStr(PaintBox.Width));
  //Draw.DrawAll;
  Index := -1;
  Index := Manager.FindByPoint(PX,PY);
  CheckObj := false;
  if PaintPlat then
  begin
    PointPlat.X := X;
    PointPlat.Y := Y;
    PaintPlat := false;
    isPaintPlat := true;
    Index := -1;
  end;

  if Index > -1 then
  begin
    Draw.DrawZone(Index);
    CheckObj := true;
  end;
end;

procedure TMainFm.PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  PX := X;
  PY := Y;
  Move := false;
  if isPaintPlat then
  begin
    Draw.DrawPlat(PointPlat.X,PointPlat.Y,X,Y);
  end;
  if CheckObj then
  begin
    Draw.ChangePoz(Index,X,Y);
    Move := true;
  end;
end;

procedure TMainFm.PaintBoxMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var P,P2 : Tpoint;
    //TempKolPlat : integer;
begin
  P.X := PX;
  P.Y := PY;
  CheckObj := false;
  if isPaintPlat then
  begin
    P2.X := X;
    P2.Y := Y;
    Manager.AddPlata(PointPlat,P2);
    isPaintPlat := false;
    isKolPlat := DrawPlat(isKolPlat);
   { if (Manager.Plats[0].NizPoint.X - Manager.Plats[0].VerhPoint.X)>
      (Manager.Plats[0].NizPoint.Y - Manager.Plats[0].VerhPoint.Y) then
    ShowMessage('Желательно что бы дли'); }
    
  end;
  if (Index > -1)and(Move) then
  begin
    Manager.Elements[Index].VerhPoint := P;
    if IsSnap then Draw.SnapToGrid(Manager.Elements[Index]);
  end;
  if Manager.ElementsCount > 0 then Draw.DrawAll;
  if Index > -1 then  Draw.DrawZone(Index);
end;

procedure TMainFm.Time2Timer(Sender: TObject);
begin
  if GenAlg.CrossingKomp(genAlg.FHrom[0].GetGen,genAlg.FHrom[0].GetGen)then
  begin
    GenAlg.Iteration := 0;
    Prog.Position := 0;
  end
  else
  begin
    Inc(GenAlg.Iteration);
    Prog.StepIt;
  end;
//  GenAlg.SetCelFunc;
  Status.Panels[5].Text := IntToStr(GenAlg.CelFunc);
  if IsAlgDraw then Draw.DrawAll;
  if (GenAlg.Iteration > genAlg.MinPop)or(isStopAlg) then
  Begin
    Draw.DrawAll;
    Time2.Enabled := false;
    Panel4.Visible := false;
    if not isStopAlg then ShowMessage('В течении '+IntTOStr(genAlg.MinPop)+' эпох целевая функция не изменялась.');
  end;
end;

procedure TMainFm.TimeTimer(Sender: TObject);
begin
  if GenAlg.Crossing(genAlg.FHrom[0].GetGen,genAlg.FHrom[0].GetGen)then
  begin
    GenAlg.Iteration := 0;
    Prog.Position := 0;
  end
  else
  begin
    Inc(GenAlg.Iteration);
    Prog.StepIt;
  end;
//  GenAlg.SetCelFunc;
  Status.Panels[5].Text := IntToStr(GenAlg.CelFunc);
  if IsAlgDraw then Draw.DrawAll;
  if (GenAlg.Iteration > genAlg.MinPop)or(isStopAlg) then
  Begin
    Draw.DrawAll;
    Time.Enabled := false;
    Panel4.Visible := false;
    if not isStopAlg then ShowMessage('В течении '+IntTOStr(genAlg.MinPop)+' эпох целевая функция не изменялась.');
  end;
end;

procedure TMainFm.TreeClick(Sender: TObject);
begin
  if (Manager.ElementsCount > 0)and(Tree.Selected.Text <> 'Элементы') then
  begin
    try
      Draw.DrawAll;
      Draw.DrawZone(Manager.FindElement(Tree.Selected.Text));
    except

    end;

  end;
end;

procedure TMainFm.actAddElementExecute(Sender: TObject);
begin
  CreateChildForm(fmAddElement,TfmAddElement);
end;

procedure TMainFm.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainFm.actFormManagerBDExecute(Sender: TObject);
begin
  CreateChildForm(fmManagerBd,TfmManagerBd);
end;

procedure TMainFm.actFormReadFileExecute(Sender: TObject);
begin
  ShagSetk := 0;
  CreateChildForm(fmReadFile,TfmReadFile);
  if Manager.ElementsCount > 0 then
  begin
    if not ShowMiniElements then
    begin
      Panel1.Visible := true;
      n8.Checked := true;
    end;
    btRazmCont.Enabled := false;
    btKompCont.Enabled := false;
    Info.ShowElements(Tree,TreeUzel);
    Tree.Items[0].Expand(False);
    Tree.Items[0].Selected:=true;
    Tree.SetFocus;
    TreeUzel.Items[0].Expand(False);
    TreeUzel.Items[0].Selected:=true;
    TreeUzel.SetFocus;
    if ShowMiniElements then
    begin
      Panel1.Visible := false;
      n8.Checked := false;
    end;
    Manager.DeleteAllPlata;
    Draw.DrawFirst;
    Draw.DrawAll;
    AlgStart := false;
  end;
  Status.Panels.Items[1].Text := IntTOStr(Manager.ElementsCount);
end;

procedure TMainFm.actOptionsOpenExecute(Sender: TObject);
begin
  CreateChildForm(fmOptions,TfmOptions);
end;

procedure TMainFm.Button1Click(Sender: TObject);
var D : string;
   // X : integer;
begin
  if Manager.ElementsCount > 0 then
  begin
    if InputQuery('Введите количество плат','',D) then
    begin
      manager.DeleteAllPlata;
      Draw.DrawAll;
      KolPlat := StrToInt(D);
      isKolPlat := DrawPlat(0);
    end;
  end
  else
  begin
    ShowMessage('Необходимо экспортировать элементы!');
  end;
end;

procedure TMainFm.Button2Click(Sender: TObject);
begin
  IsStopAlg := true;
end;

procedure TMainFm.Button3Click(Sender: TObject);
begin
  if manager.UzelsCount > 0 then
  begin
    Trass.Prepare;
  end;
end;

procedure TMainFm.btKompContClick(Sender: TObject);
begin
  if AlgStart then
  begin
    GenAlg.PrepareSecond;
    GenAlg.Invertion := optInvertion;
    GenAlg.MinPop := OptMinPop;
    GenAlg.Mutation := OptMutation;
    AlgStart := true;
    Draw.DrawAll;
    Panel4.Visible := true;
    isStopAlg := false;
    Prog.Max := GenAlg.MinPop;
    Prog.Position := 0;
    if isAlgDraw then
  begin
    Time2.Enabled := true;
  end
  else
  begin
    while GenAlg.Iteration < GenAlg.MinPop do
    begin
      if GenAlg.CrossingKomp(genAlg.FHrom[0].GetGen,genAlg.FHrom[0].GetGen)then
      begin
        GenAlg.Iteration := 0;
        Prog.Position := 0;
      end
      else
      begin
        Inc(GenAlg.Iteration);
        Prog.StepIt;
      end;
//  GenAlg.SetCelFunc;
      Status.Panels[5].Text := IntToStr(GenAlg.CelFunc);
  //if IsAlgDraw then Draw.DrawAll;
    end;
    Draw.DrawAll;
    Time2.Enabled := false;
    Panel4.Visible := false;
    if not isStopAlg then ShowMessage('В течении '+IntTOStr(genAlg.MinPop)+' эпох целевая функция не изменялась.');
  end;
  end;
end;

procedure TMainFm.btKompClick(Sender: TObject);
begin
  if Manager.PlatsCount > 1 then
  begin
  GenAlg.PrepareSecond;
  IsStopAlg := false;
  GenAlg.Invertion := optInvertion;
  GenAlg.MinPop := OptMinPop;
  GenAlg.Mutation := OptMutation;
  AlgStart := true;
  Draw.DrawAll;
  Panel4.Visible := true;
  Prog.Max := GenAlg.MinPop;
  btKompCont.Enabled := true;
  Prog.Position := 0;
  if isAlgDraw then
  begin
    Time2.Enabled := true;
  end
  else
  begin
    while GenAlg.Iteration < GenAlg.MinPop do
    begin
      if GenAlg.CrossingKomp(genAlg.FHrom[0].GetGen,genAlg.FHrom[0].GetGen)then
      begin
        GenAlg.Iteration := 0;
        Prog.Position := 0;
      end
      else
      begin
        Inc(GenAlg.Iteration);
        Prog.StepIt;
      end;
//  GenAlg.SetCelFunc;
      Status.Panels[5].Text := IntToStr(GenAlg.CelFunc);
  //if IsAlgDraw then Draw.DrawAll;
    end;
    Draw.DrawAll;
    Time2.Enabled := false;
    Panel4.Visible := false;
    if not isStopAlg then ShowMessage('В течении '+IntTOStr(genAlg.MinPop)+' эпох целевая функция не изменялась.');
  end;
  end
  else
  begin
    ShowMessage('Для компановки необходимо не менее 2 плат!');
  end;
end;

procedure TMainFm.btRazmClick(Sender: TObject);
begin
  if Manager.PlatsCount > 0 then
  begin
  GenAlg.PrepareSecond;
  IsStopAlg := false;
  GenAlg.Invertion := optInvertion;
  GenAlg.MinPop := OptMinPop;
  GenAlg.Mutation := OptMutation;
  AlgStart := true;
  Draw.DrawAll;
  Panel4.Visible := true;
  Prog.Max := GenAlg.MinPop;
  btRazmCont.Enabled := true;
  Prog.Position := 0;
  if isAlgDraw then
  begin
    Time.Enabled := true;
  end
  else
  begin
    while GenAlg.Iteration < GenAlg.MinPop do
    begin
      if GenAlg.Crossing(genAlg.FHrom[0].GetGen,genAlg.FHrom[0].GetGen)then
      begin
        GenAlg.Iteration := 0;
        Prog.Position := 0;
      end
      else
      begin
        Inc(GenAlg.Iteration);
        Prog.StepIt;
      end;
//  GenAlg.SetCelFunc;
      Status.Panels[5].Text := IntToStr(GenAlg.CelFunc);
  //if IsAlgDraw then Draw.DrawAll;
    end;
    Draw.DrawAll;
    Time.Enabled := false;
    Panel4.Visible := false;
    if not isStopAlg then ShowMessage('В течении '+IntTOStr(genAlg.MinPop)+' эпох целевая функция не изменялась.');
  end;
  end
  else
  begin
    ShowMessage('Для размещения нужна 1 плата!');
  end;
end;

procedure TMainFm.btRazmContClick(Sender: TObject);
begin
  if AlgStart then
  begin
    GenAlg.PrepareSecond;
    GenAlg.Invertion := optInvertion;
    GenAlg.MinPop := OptMinPop;
    GenAlg.Mutation := OptMutation;
    AlgStart := true;
    Draw.DrawAll;
    Panel4.Visible := true;
    isStopAlg := false;
    Prog.Max := GenAlg.MinPop;
    Prog.Position := 0;
    if isAlgDraw then
  begin
    Time.Enabled := true;
  end
  else
  begin
    while GenAlg.Iteration < GenAlg.MinPop do
    begin
      if GenAlg.Crossing(genAlg.FHrom[0].GetGen,genAlg.FHrom[0].GetGen)then
      begin
        GenAlg.Iteration := 0;
        Prog.Position := 0;
      end
      else
      begin
        Inc(GenAlg.Iteration);
        Prog.StepIt;
      end;
//  GenAlg.SetCelFunc;
      Status.Panels[5].Text := IntToStr(GenAlg.CelFunc);
  //if IsAlgDraw then Draw.DrawAll;
    end;
    Draw.DrawAll;
    Time.Enabled := false;
    Panel4.Visible := false;
    if not isStopAlg then ShowMessage('В течении '+IntTOStr(genAlg.MinPop)+' эпох целевая функция не изменялась.');
  end;
  end;
end;

procedure TMainFm.CreateObject;
var
server_name: string;
database_name: string;
begin
  Save.FileName := GetCurrentDir + '\SAVE';
  Trass := TTrass.Create;
  Manager := TManager.Create;
  Info := TInformation.Create;
  ShagSetk := 0;
  AlgStart := false;
  GenAlg := TgenAlg.Create;
  PaintPlat := false;
  isPaintPlat := false;
  Draw := TDraw.Create(PaintBox);
  try
    ini:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'Prof.ini');
    server_name:=ini.ReadString('options','server_name','');
    database_name:=ini.readString('options','database_name','');
    if (server_name='') or (database_name='') then
    begin
      server_name:='localhost';
      if not InputQuery('Введите имя сервера','',server_name) then
      begin
        Application.Terminate;
        Exit;
      end;
      if not InputQuery('Введите полный путь к файлу БД','',database_name) then
      begin
        Application.Terminate;
        Exit;
      end;
      ini.WriteString('options','server_name',server_name);
      ini.WriteString('options','database_name',database_name);
    end;
    try
      Data.Database.DatabaseName := database_name;
      Data.DataBase.Connected := true;
      Data.Transaction.Active := true;
    except
      ShowMessage('Не правильные параметры подключения');
      Application.Terminate;
      Exit;
    end;
  finally
    LoadOptions(ini);
    //FreeAndNil(ini);
  end;
end;


end.
