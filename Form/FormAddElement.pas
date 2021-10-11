unit FormAddElement;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ExtDlgs, StdCtrls,ClassElement, Buttons;

type
  TfmAddElement = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    edName: TLabeledEdit;
    edShortName: TLabeledEdit;
    edKolConnect: TLabeledEdit;
    Open: TOpenPictureDialog;
    Normal: TImage;
    Rotate: TImage;
    Label1: TLabel;
    Label2: TLabel;
    btAddNormalPicture: TButton;
    btAddConnectN: TButton;
    btAddRotatePicture: TButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure btAddConnectRClick(Sender: TObject);
    procedure btAddConnectNClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btAddRotatePictureClick(Sender: TObject);
    procedure btAddNormalPictureClick(Sender: TObject);
  private
    { Private declarations }
    NormalPAth,RotatePath : string;
  public
    { Public declarations }
    PictureN : boolean;
    PictureR : boolean;

  end;

var
  fmAddElement: TfmAddElement;
  Element : TElement;

implementation

{$R *.dfm}

uses fmMain,fmAddConnect;

procedure TfmAddElement.BitBtn1Click(Sender: TObject);
begin
  Element.Name := edName.Text;
  Element.ShortName := edShortName.Text;
  Element.SaveElement(NormalPath,RotatePath);
end;

procedure TfmAddElement.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TfmAddElement.btAddConnectNClick(Sender: TObject);
begin
  if (PictureN)and(edKolConnect.Text <> '') then
  begin
    FormAddConnect:=TFormAddConnect.Create(Application);
    FormAddConnect.Grid.RowCount := StrToInt(edKolConnect.Text) + 1;
    FormAddConnect.Image.Picture := Normal.Picture;
    FormAddConnect.ShowModal;
    FormAddConnect.Free;
    FormAddConnect:=nil;
  end;
end;

procedure TfmAddElement.btAddConnectRClick(Sender: TObject);
begin
  if (PictureR)and(edKolConnect.Text <> '') then
  begin
    FormAddConnect:=TFormAddConnect.Create(Application);
    FormAddConnect.Grid.RowCount := StrToInt(edKolConnect.Text) + 1;
    FormAddConnect.Image.Picture := Rotate.Picture;
    FormAddConnect.ShowModal;
    FormAddConnect.Free;
    FormAddConnect:=nil;
  end;
end;

procedure TfmAddElement.btAddNormalPictureClick(Sender: TObject);
begin
  if Open.Execute then
  begin
    Normal.Picture.LoadFromFile(Open.FileName);
    NormalPath := Open.FileName;
    PictureN := true;
  end;
end;

procedure TfmAddElement.btAddRotatePictureClick(Sender: TObject);
begin
  if Open.Execute then
  begin
    Rotate.Picture.LoadFromFile(Open.FileName);
    RotatePath := Open.FileName;
    PictureR := true;
  end;
end;

procedure TfmAddElement.FormCreate(Sender: TObject);
begin
  Element := TElement.Create;
  PictureN := false;
  PictureR := false;
end;

procedure TfmAddElement.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Element);
end;

end.
