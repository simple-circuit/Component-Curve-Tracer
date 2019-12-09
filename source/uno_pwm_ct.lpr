program uno_pwm_ct;

{$MODE Delphi}

uses
  Forms, Interfaces,
  Unitct in 'Unitct.pas' {Form1};

{.$R *.RES}

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Uno_pwm_ct';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
