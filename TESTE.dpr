program TESTE;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {Form1},
  uControllerDados in 'uControllerDados.pas',
  UDataMPrincipal in 'UDataMPrincipal.pas' {uDMPrincipal: TDataModule},
  uModelDados in 'uModelDados.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TuDMPrincipal, uDMPrincipal);
  Application.Run;
end.
