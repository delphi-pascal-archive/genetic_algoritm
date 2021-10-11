unit FormOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TfmOptions = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cbShowDialogNotElement: TCheckBox;
    TabSheet3: TTabSheet;
    edInversion: TLabeledEdit;
    edMutation: TLabeledEdit;
    Label1: TLabel;
    edEpoh: TEdit;
    Label2: TLabel;
    cbAlgDraw: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmOptions: TfmOptions;

implementation

{$R *.dfm}

uses ClassOptions;

procedure TfmOptions.BitBtn1Click(Sender: TObject);
begin
  ShowMessageNotElementdBD := cbShowDialogNotElement.Checked;
  OptMinPop := StrToInt(edEpoh.Text);
  OptMutation := StrToFloat(edMutation.Text);
  OptInvertion := StrToFloat(edInversion.Text);
  IsAlgDraw := cbAlgDraw.Checked;
  SaveOptions;
end;

procedure TfmOptions.FormCreate(Sender: TObject);
begin
  cbShowDialogNotElement.Checked := ShowMessageNotElementdBD;
  cbAlgDraw.Checked := IsAlgDraw;
  edEpoh.Text := IntToStr(OptMinPop);
  edMutation.Text := FloatToStr(OptMutation);
  edInversion.Text := FloatToStr(OptInvertion);
end;

end.
