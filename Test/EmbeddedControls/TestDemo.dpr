program TestDemo;

uses
  Forms,
  fTest in 'fTest.pas' {Form2},
  uBigEdit in 'uBigEdit.pas',
  uBigControl in 'uBigControl.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
