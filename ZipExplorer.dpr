program ZipExplorer;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  Utils in 'Utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
