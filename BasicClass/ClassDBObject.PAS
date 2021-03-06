unit ClassDBObject;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ClassTransactionObject, ClassConnection;

type
  {{
  ����������� ����� ������ ��� ���� ��������
  ���� ����� ������ �������� ������� ����������� ������� �������� �����
  ������������ ���
  �������, ������������� ��.
  ��� �������� ����� ������ ���������� ��������� ����� ���������� � �����������
  ����� ������������ ���� �����. ���� ���������� �� ������� ���������� �������
  ����������.
  }
  TDBObject = class(TObject)
  protected
    FConnection: TConnection;
    fOwn_transaction: Boolean;
    FTransaction: TTransactionObject;
  public
    {{
    ��������� � ��������������� ���� ��������� �� ������ 
    ���������� � �� (TConnection) � ���������� (TTransaction). 
    � ������ ���� � ����������� ��������� �� ���������� �� 
    ����������, �� ��������� ����� ���������� � ������ ���������� 
    �� ����������.
    }
    constructor Create(Connection: TConnection; Transaction:
            TTransactionObject=nil); virtual;
    destructor Destroy; override;
    {{
    �����, ��������������� ��� �� ����� ������� ����������
    }
    procedure Commit;
    procedure CommitRetaining;
    procedure Rollback;
    procedure RollbackRetaining;
    procedure StartTransaction;
    property Connection: TConnection read FConnection;
    property TransactionObject: TTransactionObject read FTransaction;
  end;

  e_dbobject = exception;
  

implementation



{{
����������� ����� ������ ��� ���� ��������
}
{{
����������� ����� ������ ��� ���� ��������
���� ����� ������ �������� ������� ����������� ������� �������� �����
������������ ���
�������, ������������� ��.
��� �������� ����� ������ ���������� ��������� ����� ���������� � �����������
����� ������������ ���� �����. ���� ���������� �� ������� ���������� �������
����������.
}
{
********************************** TDBObject ***********************************
}
constructor TDBObject.Create(Connection: TConnection; Transaction:
        TTransactionObject=nil);
begin
  FConnection:=Connection;
  if Transaction=nil then
  begin
    FTransaction:=TTransactionObject.Create;
    fOwn_transaction:=true;
  end
  else
  begin
    FTransaction:=Transaction;
    fOwn_transaction:=false;
  end;
  if (fOwn_transaction) and (FConnection.TransactionObject.Transaction <> FTransaction.Transaction) then
    FTransaction.Transaction.DefaultDatabase := FConnection.DataBase;
end;

destructor TDBObject.Destroy;
begin
  if fOwn_transaction then
    FreeAndNil(FTransaction);
  inherited Destroy;
end;

procedure TDBObject.Commit;
begin
  if fOwn_transaction then
    FTransaction.Commit
  else
    raise e_dbobject.Create('��������� �� ������� �����������');
end;

procedure TDBObject.CommitRetaining;
begin
  if fOwn_transaction then
    FTransaction.CommitRetaining
  else
    raise e_dbobject.Create('��������� �� ������� �����������');
end;

procedure TDBObject.Rollback;
begin
  if fOwn_transaction then
    FTransaction.Rollback
  else
    raise e_dbobject.Create('��������� �� ������� �����������');
end;

procedure TDBObject.RollbackRetaining;
begin
  if fOwn_transaction then
    FTransaction.RollbackRetaining
  else
    raise e_dbobject.Create('��������� �� ������� �����������');
end;

procedure TDBObject.StartTransaction;
begin
  if fOwn_transaction then
    FTransaction.StartTransaction
  else
    raise e_dbobject.Create('��������� �� ������� �����������');
end;


end.
