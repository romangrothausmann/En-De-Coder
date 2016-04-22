program EntVerschluessler1pr;

{$MODE Delphi}

uses
  Forms, Interfaces,
  EntVerschluessler1 in 'EntVerschluessler1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
