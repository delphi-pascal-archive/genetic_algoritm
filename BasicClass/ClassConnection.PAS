unit ClassConnection;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ClassTransactionObject, IBDataBase;

type
  {{
   ласс позвол€ющий подключ€тс€ к базе данных.
  Ётот класс должен иметь все необходимые методы дл€ подключени€ к базе данных
  }
  e_conection = Exception;
  {{
   ласс позвол€ющий подключ€тс€ к базе данных.
  Ётот класс должен иметь все необходимые методы дл€ подключени€ к базе данных
  }
  TConnection = class(TObject)
  private
    FDataBase: TIBDatabase;
    FDataBaseName: string;
    FPassword: string;
    FServerName: string;
    FTransactionObject: TTransactionObject;
    FUserName: string;
    function GetConnected: Boolean;
    function GetPassword: string;
    function GetTransactionObject: TTransactionObject;
    procedure SetPassword(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Connect;
    procedure Disconnect;
    property Connected: Boolean read GetConnected;
    property DataBase: TIBDatabase read FDataBase;
    property DataBaseName: string read FDataBaseName write FDataBaseName;
    property Password: string read GetPassword write SetPassword;
    property ServerName: string read FServerName write FServerName;
    property TransactionObject: TTransactionObject read GetTransactionObject;
    property UserName: string read FUserName write FUserName;
  end;


implementation


{{
 ласс позвол€ющий подключ€тс€ к базе данных
}
{{
 ласс позвол€ющий подключ€тс€ к базе данных.
Ётот класс должен иметь все необходимые методы дл€ подключени€ к базе данных
}
{{
 ласс позвол€ющий подключ€тс€ к базе данных.
Ётот класс должен иметь все необходимые методы дл€ подключени€ к базе данных
}
{{
 ласс позвол€ющий подключ€тс€ к базе данных.
Ётот класс должен иметь все необходимые методы дл€ подключени€ к базе данных
}
{
********************************* TConnection **********************************
}
constructor TConnection.Create;
begin
  FTransactionObject := TTransactionObject.Create;
  FDataBase := TIBDatabase.Create(nil);
  FDataBase.DefaultTransaction := FTransactionObject.Transaction;
end;

destructor TConnection.Destroy;
begin
  FreeAndNil(fTransactionObject);
  FreeAndNil(FDataBase);
  inherited;
end;

procedure TConnection.Connect;
begin
  if (FPassword = '') or (FUserName = '') or (FDataBaseName = '') then
  begin
    e_conection.Create('ѕараметры подключени€ не заполнены.');
    Exit;
  end;
  FDataBase.LoginPrompt := false;
  FDataBase.Params.Add('user_name='+FUserName);
  FDataBase.Params.Add('password='+FPassword);
  FDataBase.Params.Add('lc_ctype=WIN1251');
  if FServerName = '' then FServerName := 'localhost';
  FDataBase.DatabaseName := FServerName+':'+FDataBaseName;
  FDataBase.DefaultTransaction := FTransactionObject.Transaction;
  try
    FDataBase.Open;
  except
    on e: exception do
    begin
      e_conection.Create('ѕри соединении с базой данных произошла ошибка: '+e.Message);
      Exit;
    end;
  end;
end;

procedure TConnection.Disconnect;
begin
  FDataBase.Close;
end;

function TConnection.GetConnected: Boolean;
begin
  Result := FDataBase.Connected;
end;

function TConnection.GetPassword: string;
begin
  Result := FPassword;
end;

function TConnection.GetTransactionObject: TTransactionObject;
begin
  Result := FTransactionObject;
end;

procedure TConnection.SetPassword(const Value: string);
begin
  FPassword := Value;
end;




end.
