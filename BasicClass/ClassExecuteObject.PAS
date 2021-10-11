unit ClassExecuteObject;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ClassDBObject,IBQuery, ClassConnection, ClassTransactionObject,
  Variants, DB;

type
  {{
   ласс позвол€ющий исполн€ть SQL запрос.
  Ётот класс должен иметь все необходимые методы дл€ выполнени€ SQL запросов.
  “акже он должен иметь методы возвращающие состо€ние набора данных TIBQuery.
  }
  e_executeobject = exception;
  {{
   ласс позвол€ющий исполн€ть SQL запрос.
  Ётот класс должен иметь все необходимые методы дл€ выполнени€ SQL запросов.
  “акже он должен иметь методы возвращающие состо€ние набора данных TIBQuery.
  }
  TExecuteObject = class(TDBObject)
  private
    fDataSource: tdatasource;
    function GetBof: Boolean;
    function GetDataSource: TDataSource;
    function GetEof: Boolean;
    function GetFieldCount: Integer;
    function GetRecNo: integer;
    procedure SetRecNo(const Value: integer);
    function GetRecordCount: integer;
    procedure SetFS(index: integer; const Value: string);
    function GetFS(index: integer): string;
    function GetFi(index: integer): integer;
    procedure SetFI(index: integer; const Value: integer);
  protected
    fQuery: TIBQuery;
    procedure AfterPost(DataSet: TDataSet); virtual;
    procedure AfterScroll(DataSet: TDataSet); virtual;
    procedure BeforeInsert(DataSet: TDataSet); virtual;
    procedure AfterInsert(DataSet: TDataSet); virtual;
    procedure AfterOpen(DataSet: TDataSet); virtual;
  public
    constructor Create(Connection: TConnection; Transaction:
            TTransactionObject=nil); override;
    destructor Destroy; override;
    procedure ExecuteQuery(sql: string; params: array of variant);
    function FieldByIDExt(id: integer): Extended;
    function FieldByIDInt(id: integer): Integer;
    function FieldByIDStr(id: integer): string;
    function FieldByNameExt(name: string): Extended;
    function FieldByNameInt(name: string): Integer;
    function FieldByNameStr(name: string): string;
    procedure First;
    procedure Last;
    procedure Next;
    procedure Previous;
    procedure SelectQuery(sql: string; params: array of variant);
    property Bof: Boolean read GetBof;
     property Eof: Boolean read GetEof;
    property FieldCount: Integer read GetFieldCount;
    property RecNo: integer read GetRecNo write SetRecNo;
//    property QueryResult: TIBQuery read fQuery;
    property DataSource: tdatasource read fDataSource;
    property RecordCount: integer read GetRecordCount;
    property fs[index: integer]:string read GetFS write SetFS;
    property fi[index: integer]:integer read GetFi write SetFI;
  end;
  

implementation

{{
 ласс позвол€ющий исполн€ть SQL запрос.
Ётот класс должен иметь все необходимые методы дл€ выполнени€ SQL запросов.
“акже он должен иметь методы возвращающие состо€ние набора данных TIBQuery.
}
{{
 ласс позвол€ющий исполн€ть SQL запрос.
Ётот класс должен иметь все необходимые методы дл€ выполнени€ SQL запросов.
“акже он должен иметь методы возвращающие состо€ние набора данных TIBQuery.
}
{{
 ласс позвол€ющий исполн€ть SQL запрос.
Ётот класс должен иметь все необходимые методы дл€ выполнени€ SQL запросов.
“акже он должен иметь методы возвращающие состо€ние набора данных TIBQuery.
}
{
******************************** TExecuteObject ********************************
}
constructor TExecuteObject.Create(Connection: TConnection; Transaction:
        TTransactionObject=nil);
begin
  inherited;
  fQuery := TIBQuery.Create(nil);
  fQuery.Database := fConnection.DataBase;
  fQuery.Transaction := fTransaction.Transaction;
  FDataSource := TDataSource.Create(nil);
  FDataSource.DataSet := fQuery;
  fQuery.AfterPost:=AfterPost;
  fQuery.AfterScroll:=AfterScroll;
  fQuery.BeforeInsert:=BeforeInsert;
  fQuery.AfterInsert:=AfterInsert;
  fQuery.AfterOpen:=AfterOpen;
  
  fDataSource:=TDataSource.Create(nil);
  fDataSource.DataSet:=fQuery;
end;

destructor TExecuteObject.Destroy;
begin
  FreeAndNil(FDataSource);
  FreeAndNil(fQuery);
  inherited Destroy;
end;

procedure TExecuteObject.ExecuteQuery(sql: string; params: array of variant);
var
  v: Variant;
  i: Integer;
begin
  fQuery.Close;
  fQuery.SQL.Clear;
  fQuery.SQL.Add(sql);
  if Length(params) > 0 then
  begin
    v:=VarArrayOf(params);
    for i:=0 to length(params)-1 do
      case vartype(v[i]) of
        varInteger:fQuery.Params[i].AsInteger:=v[i];
        varOleStr:fQuery.Params[i].AsString:=v[i];
        VarDate:fQuery.Params[i].AsDate:=v[i];
        varDouble:fQuery.Params[i].AsFloat:=v[i];
        varBoolean:fQuery.Params[i].AsBoolean:=v[i];
        varNull:  begin
                    fQuery.Params[i].Clear;
                    fQuery.Params[i].Bound := true;
                  end;        
      end;
  end;
  try
    fQuery.ExecSQL;
  except
    on e: exception do
      raise e_executeobject.Create('ѕри выполнении SQL запроса произошла ошибка:'+e.Message);
  end;
end;

function TExecuteObject.FieldByIDExt(id: integer): Extended;
begin
  if id<0 then
  begin
    raise e_executeobject.Create('»ндекс не может быть отрицательным!');
    Exit;
  end;
  if id > fQuery.FieldCount-1 then
  begin
    raise e_executeobject.Create('»ндекс не может превышать количество полей!');
    Exit;
  end;
  Result := fQuery.Fields[id].AsFloat;
end;

function TExecuteObject.FieldByIDInt(id: integer): Integer;
begin
  if id<0 then
  begin
    raise e_executeobject.Create('»ндекс не может быть отрицательным!');
    Exit;
  end;
  if id > fQuery.FieldCount-1 then
  begin
    raise e_executeobject.Create('»ндекс не может превышать количество полей!');
    Exit;
  end;
  Result := fQuery.Fields[id].AsInteger;
end;

function TExecuteObject.FieldByIDStr(id: integer): string;
begin
  if id<0 then
  begin
    raise e_executeobject.Create('»ндекс не может быть отрицательным!');
    Exit;
  end;
  if id > fQuery.FieldCount-1 then
  begin
    raise e_executeobject.Create('»ндекс не может превышать количество полей!');
    Exit;
  end;
  Result := fQuery.Fields[id].AsString;
end;

function TExecuteObject.FieldByNameExt(name: string): Extended;
begin
  if name='' then
  begin
    raise e_executeobject.Create('Ќазвание пол€ не может быть пустым!');
    Exit;
  end;
  Result := fQuery.FieldByName(name).AsFloat;
end;

function TExecuteObject.FieldByNameInt(name: string): Integer;
begin
  if name='' then
  begin
    raise e_executeobject.Create('Ќазвание пол€ не может быть пустым!');
    Exit;
  end;
  Result := fQuery.FieldByName(name).AsInteger;
end;

function TExecuteObject.FieldByNameStr(name: string): string;
begin
  if name='' then
  begin
    raise e_executeobject.Create('Ќазвание пол€ не может быть пустым!');
    Exit;
  end;
  Result := fQuery.FieldByName(name).AsString;
end;

procedure TExecuteObject.First;
begin
  fQuery.First;
end;

function TExecuteObject.GetBof: Boolean;
begin
  Result := fQuery.Bof;
end;

function TExecuteObject.GetDataSource: TDataSource;
begin
  Result := FDataSource;
end;

function TExecuteObject.GetEof: Boolean;
begin
  Result := fQuery.Eof;
end;

function TExecuteObject.GetFieldCount: Integer;
begin
  Result := fQuery.FieldCount;
end;

procedure TExecuteObject.Last;
begin
  fQuery.Last;
end;

procedure TExecuteObject.Next;
begin
  fQuery.Next;
end;

procedure TExecuteObject.Previous;
begin
  fQuery.Prior;
end;

procedure TExecuteObject.SelectQuery(sql: string; params: array of variant);
var
  v: Variant;
  i: Integer;
begin
  fQuery.Close;
  fQuery.SQL.Clear;
  fQuery.SQL.Add(sql);
  if Length(params) > 0 then
  begin
    v:=VarArrayOf(params);
    for i:=0 to length(params)-1 do
      case vartype(v[i]) of
        varInteger:fQuery.Params[i].AsInteger:=v[i];
        varOleStr:fQuery.Params[i].AsString:=v[i];
        VarDate:fQuery.Params[i].AsDate:=v[i];
        varDouble:fQuery.Params[i].AsFloat:=v[i];
        varBoolean:fQuery.Params[i].AsBoolean:=v[i];
        varNull:  begin
                    fQuery.Params[i].Clear;
                    fQuery.Params[i].Bound := true;
                  end;
      end;
  end;
  try
    fQuery.Open;
  except
    on e: exception do
      raise e_executeobject.Create('ѕри выполнении SQL запроса произошла ошибка:'+e.Message);
  end;
end;

procedure TExecuteObject.AfterPost(DataSet: TDataSet);
begin

end;

function TExecuteObject.GetRecNo: integer;
begin
  Result:=fQuery.RecNo;
end;

procedure TExecuteObject.SetRecNo(const Value: integer);
begin
  fQuery.RecNo:=Value;
end;

procedure TExecuteObject.AfterScroll(DataSet: TDataSet);
begin

end;

procedure TExecuteObject.BeforeInsert(DataSet: TDataSet);
begin
//
end;

procedure TExecuteObject.AfterInsert(DataSet: TDataSet);
begin

end;

function TExecuteObject.GetRecordCount: integer;
begin
  Result:=fQuery.RecordCount;
end;

procedure TExecuteObject.SetFS(index: integer; const Value: string);
begin
  fQuery.Fields[index].AsString:=Value;
end;

function TExecuteObject.GetFS(index: integer): string;
begin
  Result:=fQuery.Fields[index].AsString;
end;

procedure TExecuteObject.AfterOpen(DataSet: TDataSet);
begin

end;

function TExecuteObject.GetFi(index: integer): integer;
begin
  Result:=fQuery.Fields[index].AsInteger;
end;

procedure TExecuteObject.SetFI(index: integer; const Value: integer);
begin
  fQuery.Fields[index].AsInteger:=Value;
end;

end.
