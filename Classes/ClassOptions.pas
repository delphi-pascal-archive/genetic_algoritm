unit ClassOptions;

interface

uses Grids,DBGrids,
  SysUtils,DateUtils,StdCtrls,types,Graphics,DataModule,comctrls,inifiles;

procedure LoadOptions(ini : TIniFile);
procedure SaveOptions;

var
  ShowMessageNotElementdBD : boolean;
  ShowMiniElements : boolean;
  ShagSetk : integer;
  OptMinPop : integer;
  OptMutation : double;
  OptInvertion : double;
  IsAlgDraw : boolean;
  VisibleGrid : boolean;
  IsSnap : boolean;
  ini : TIniFile;

implementation

procedure LoadOptions(ini : TIniFile);
begin
  ShowMessageNotElementdBD:=ini.ReadBool('options','ShowMessageNotElementdBD',true);
  ShowMiniElements := ini.ReadBool('options','ShowMiniElements',true);
  VisibleGrid := ini.ReadBool('options','VisibleGrid',True);
  IsAlgDraw := ini.ReadBool('options','IsAlgDraw',True);
  IsSnap := Ini.ReadBool('options','IsSnap',True);
  OptminPop := Ini.ReadInteger('options','OptMimPop',100);
  OptMutation := Ini.ReadFloat('options','Optmutation',0.1);
  OptInvertion := Ini.ReadFloat('options','OptInvertion',0.05);
end;

procedure SaveOptions;
begin
  Ini.WriteBool('options','ShowMessageNotElementdBD',ShowMessageNotElementdBD);
  Ini.WriteBool('options','ShowMiniElements',ShowMiniElements);
  Ini.WriteBool('options','VisibleGrid',VisibleGrid);
  Ini.WriteBool('options','IsAlgDraw',IsAlgDraw);
  Ini.WriteBool('options','IsSnap',IsSnap);
  Ini.WriteInteger('options','OptMimPop',OptminPop);
  Ini.WriteFloat('options','Optmutation',OptMutation );
  Ini.WriteFloat('options','OptInvertion',OptInvertion);
end;

end.
