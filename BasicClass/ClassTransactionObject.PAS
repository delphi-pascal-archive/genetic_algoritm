unit ClassTransactionObject;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs,IBDataBase;

type
  {{
  ����� ����� �������� ������ � ������������
  ����� ������ �������� ��������� �����������������
   - �������� � ��������� ����������
   - ��� ������ TIBTransaction �� ������ ���� �������� ������������ 
  ��� ���� ���������� ����� ��� �������� ���������� ������ ���� �������� �����
  ���������
  �����

  }
  TTransactionObject = class(TObject)
  private
    FTransaction: TIBTransaction;
    function GetTransaction: TIBTransaction;
    procedure SetTransaction(Value: TIBTransaction);
    function GetInTransaction: Boolean;
  public
    property Transaction: TIBTransaction read GetTransaction write
            SetTransaction;
    constructor Create;
    destructor Destroy; override;
    procedure Commit;
    procedure CommitRetaining;
    procedure Rollback;
    procedure RollbackRetaining;
    procedure StartTransaction;
    property InTransaction: Boolean read GetInTransaction;
  end;


implementation

{{
����� ����� �������� ������ � ������������
}
{{
����� ����� �������� ������ � ������������
����� ������ �������� ��������� �����������������
 - �������� � ��������� ����������
 - ��� ������ TIBTransaction �� ������ ���� �������� ������������ 
��� ���� ���������� ����� ��� �������� ���������� ������ ���� �������� �����
���������
�����

}
{
****************************** TTransactionObject ******************************
}
procedure TTransactionObject.Commit;
begin
  FTransaction.Commit;
end;

procedure TTransactionObject.CommitRetaining;
begin
  FTransaction.CommitRetaining;
end;

constructor TTransactionObject.Create;
begin
  FTransaction:=TIBTransaction.Create(nil);
  with FTransaction do
  begin
    Params.Add('read_committed');
    Params.Add('rec_version');
    Params.Add('nowait');
  end;       
end;

destructor TTransactionObject.Destroy;
begin
  FTransaction.Free;
  FTransaction:=nil;
  inherited;
end;

function TTransactionObject.GetInTransaction: Boolean;
begin
  Result := FTransaction.InTransaction;
end;

function TTransactionObject.GetTransaction: TIBTransaction;
begin
  Result := FTransaction;
end;

procedure TTransactionObject.Rollback;
begin
  FTransaction.Rollback;
end;

procedure TTransactionObject.RollbackRetaining;
begin
  FTransaction.RollbackRetaining;
end;

procedure TTransactionObject.SetTransaction(Value: TIBTransaction);
begin
  if FTransaction<>nil then
    FTransaction.Free;
  FTransaction:=Value;
end;

procedure TTransactionObject.StartTransaction;
begin
  FTransaction.StartTransaction;
end;


end.
