unit fmTemplate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TTemplateForm = class(TForm)
    Label1: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure CreateChildForm(form: TForm; TForms: TFormClass);
    procedure CreateObject;virtual;
    procedure FreeObject;virtual;
  end;

var
  TemplateForm: TTemplateForm;

implementation

{$R *.dfm}

procedure TTemplateForm.CreateObject;
begin

end;

procedure TTemplateForm.FreeObject;
begin

end;

procedure TTemplateForm.FormCreate(Sender: TObject);
begin
  CreateObject;
end;

procedure TTemplateForm.FormDestroy(Sender: TObject);
begin
    FreeObject;
end;

procedure TTemplateForm.CreateChildForm(form: TForm; TForms: TFormClass);
begin
  form:=TForms.Create(Application);
  form.ShowModal;
  form.Free;
  form:=nil;
end;


end.
