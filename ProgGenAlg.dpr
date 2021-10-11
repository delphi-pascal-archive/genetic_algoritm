program ProgGenAlg;

{%TogetherDiagram 'ModelSupport_ProgGenAlg\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ProgGenAlg\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\fmAddConnect\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassDBObject\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassExecuteObject\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\fmMain\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassReadFile\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassTransactionObject\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassElement\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassConnection\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\FormAddElement\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\FormReadFile\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\default.txvpck'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassConnection\default.txvpck'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ProgGenAlg\default.txvpck'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\FormAddElement\default.txvpck'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassExecuteObject\default.txvpck'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\FormReadFile\default.txvpck'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassReadFile\default.txvpck'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassDBObject\default.txvpck'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\fmAddConnect\default.txvpck'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassElement\default.txvpck'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\fmMain\default.txvpck'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassTransactionObject\default.txvpck'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassOptions\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassGrid\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\FormManagerBD\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassManager\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassInformation\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassPlata\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassDraw\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassUzel\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\FormOptions\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\DataModule\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassGenAlg\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassMatrR\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassGrid\default.txvpck'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\FormManagerBD\default.txvpck'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassDraw\default.txvpck'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassUzel\default.txvpck'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassMatrR\default.txvpck'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassInformation\default.txvpck'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\FormOptions\default.txvpck'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassOptions\default.txvpck'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassManager\default.txvpck'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassGenAlg\default.txvpck'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\ClassPlata\default.txvpck'}
{%TogetherDiagram 'ModelSupport_ProgGenAlg\DataModule\default.txvpck'}

uses
  Forms,
  ClassReadFile in 'Classes\ClassReadFile.pas',
  fmMain in 'Form\fmMain.pas' {MainFm},
  FormReadFile in 'Form\FormReadFile.pas' {fmReadFile},
  ClassElement in 'Classes\ClassElement.pas',
  FormAddElement in 'Form\FormAddElement.pas' {fmAddElement},
  fmAddConnect in 'Form\fmAddConnect.pas' {FormAddConnect},
  DataModule in 'DataModule\DataModule.pas' {Data: TDataModule},
  ClassManager in 'Classes\ClassManager.pas',
  ClassInformation in 'Classes\ClassInformation.pas',
  ClassUzel in 'Classes\ClassUzel.pas',
  ClassOptions in 'Classes\ClassOptions.pas',
  FormOptions in 'Form\FormOptions.pas' {fmOptions},
  ClassDraw in 'Classes\ClassDraw.pas',
  FormManagerBD in 'Form\FormManagerBD.pas' {fmManagerBd},
  ClassGrid in 'Classes\ClassGrid.pas',
  ClassPlata in 'Classes\ClassPlata.pas',
  ClassGenAlg in 'Classes\Gen\ClassGenAlg.pas',
  ClassMatrR in 'Classes\Gen\ClassMatrR.pas',
  ClassTrass in 'Classes\Trass\ClassTrass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'АИС Размещение';
  Application.CreateForm(TData, Data);
  Application.CreateForm(TMainFm, MainFm);
  Application.CreateForm(TfmReadFile, fmReadFile);
  Application.CreateForm(TfmManagerBd, fmManagerBd);
  Application.Run;
end.
