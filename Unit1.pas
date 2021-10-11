unit Unit1; 
 
 interface 
 
 uses 
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, 
 StdCtrls, Genes, ExtCtrls, Grids; 
 
 type 
 TForm1 = class(TForm) 
  Edit1: TEdit; 
  Edit2: TEdit; 
  Edit3: TEdit; 
  Button1: TButton; 
  Button2: TButton; 
  Button3: TButton; 
  Edit4: TEdit; 
  Button4: TButton; 
  Button5: TButton; 
  Timer1: TTimer; 
  Button7: TButton; 
  Label1: TLabel; 
  Grid: TStringGrid; 
  Label2: TLabel; 
  procedure FormCreate(Sender: TObject); 
  procedure FormDestroy(Sender: TObject); 
  procedure Button1Click(Sender: TObject); 
  procedure Button2Click(Sender: TObject); 
  procedure Button3Click(Sender: TObject); 
  procedure Button4Click(Sender: TObject); 
  procedure Button5Click(Sender: TObject); 
  procedure Button7Click(Sender: TObject); 
  procedure Timer1Timer(Sender: TObject); 
 private 
  procedure Refresh; 
  procedure GeneEstimate(Sender: TObject; const X: TExtendedArray; var Y: 
  Extended); 
 public 
  FGene: TGeneAlgorithm; 
 end; 
 
 var 
 Form1: TForm1; 
 
 implementation 
 
 {$R *.DFM} 
 
 procedure TForm1.FormCreate(Sender: TObject); 
 begin 
 DecimalSeparator := '.'; 
 FGene := TGeneAlgorithm.Create; 
 Refresh; 
 end; 
 
 procedure TForm1.FormDestroy(Sender: TObject); 
 begin 
 FGene.Free; 
 end; 
 
 procedure TForm1.Refresh; 
 begin 
 Edit1.Text := FloaTtoStr(FGene.Crossover); 
 Edit2.Text := FloatToStr(FGene.Mutation); 
 Edit3.Text := FloatToStr(FGene.Inversion); 
 end; 
 
 procedure TForm1.Button1Click(Sender: TObject); 
 begin 
 FGene.Crossover := StrTofloat(Edit1.Text); 
 Refresh; 
 end; 
 
 procedure TForm1.Button2Click(Sender: TObject); 
 begin 
 FGene.Mutation := StrTofloat(Edit2.Text); 
 Refresh; 
 end; 
 
 procedure TForm1.Button3Click(Sender: TObject); 
 begin 
 FGene.Inversion := StrTofloat(Edit3.Text); 
 Refresh; 
 end; 
 
 procedure TForm1.Button4Click(Sender: TObject); 
 begin 
 FGene.BitPerNumber := StrToInt(Edit4.Text); 
 Edit4.Text := IntToStr(FGene.BitPerNumber); 
 end; 
 
 procedure TForm1.Button5Click(Sender: TObject); 
 var 
 I: Integer; 
 begin 
 Randomize; 
 FGene.DimCount := 5; 
 FGene.MaxPopulation := 10000; 
 FGene.MinPopulation := 5000; 
 FGene.OnEstimate := GeneEstimate; 
 for I := 0 to 4 do 
 begin 
  FGene.LowValues[I] := 0; 
  FGene.HighValues[I] := 10; 
 end; 
 FGene.Run; 
 Timer1.Enabled := True; 
 end; 
 
 procedure TForm1.GeneEstimate(Sender: TObject; const X: TExtendedArray; 
 var Y: Extended); 
 var 
 I: Integer; 
 begin 
 Y := 0; 
 for I := Low(X) to High(X) do 
  Y := Y + Sqr(X[I] - I); 
 Y := -Y; 
 end; 
 
 procedure TForm1.Button7Click(Sender: TObject); 
 var 
 I: Integer; 
 begin 
 Timer1.Enabled := False; 
 Label1.Caption := ''; 
 FGene.Suspend; 
 Grid.RowCount := FGene.DimCount + 1; 
 for I := 0 to FGene.DimCount - 1 do 
  Grid.Cells[0, I + 1] := FloattoStr(FGene.BestX[I]); 
 FGene.Abort; 
 end; 
 
 procedure TForm1.Timer1Timer(Sender: TObject); 
 begin 
 Label1.Caption := FloatToStr(FGene.BestEstimate); 
 end; 
 
 end.

