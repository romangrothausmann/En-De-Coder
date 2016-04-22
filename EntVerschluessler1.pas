unit EntVerschluessler1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Edit1: TEdit;
    Edit2: TEdit;
    Button2: TButton;
    SaveDialog1: TSaveDialog;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    Bevel1: TBevel;
    ProgressBar1: TProgressBar;
    Button4: TButton;
    Animate1: TAnimate;
    Bevel2: TBevel;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  
implementation

{$R *.DFM}

Var t : String;

procedure TForm1.Button1Click(Sender: TObject);
VAR m, n, P,  e, i, z : Int64;
    code1, code2, x : Integer;
    v, s : String;

begin
Form1.Cursor:= crHourglass;
Animate1.Play (1, Animate1.FrameCount, 0);
Val(Edit1.Text, e, Code1);
if code1 <> 0
   then
   Begin
   MessageDlg('Fehler an Position: '
   + IntToStr(Code1), mtWarning, [mbOk], 0);
   Animate1.Stop;
   exit;
   End;
Val(Edit2.Text, n, Code2);
if code2 <> 0
   then
   Begin
   MessageDlg('Fehler an Position: '
   + IntToStr(Code2), mtWarning, [mbOk], 0);
   Animate1.Stop;
   exit;
   End;
z:= 1;
v:= '';
ProgressBar1.Max:= Length(Memo1.Text);
Repeat
m:= 0;
IF Length (Memo1.Text) >= z
   Then
   Begin
   m:= m + ((Ord (Memo1.Text[z]) + 256) * 1000000);
   z:= z + 1;
   End;
IF Length (Memo1.Text) >= z
   Then
   Begin
   m:= m + ((Ord (Memo1.Text[z]) + 256) * 1000);
   z:= z + 1;
   End;
IF Length (Memo1.Text) >= z
   Then
   Begin
   m:= m + ((Ord (Memo1.Text[z]) + 256) * 1);
   z:= z + 1;
   End;
P:= m mod n;
i:= 1;
While i < e Do
      Begin
      Application.ProcessMessages;
      i:= i + 1;
      P:= (P * m) mod n;
      End;
ProgressBar1.Position:= z;
Str(P:10, s);
v:= v + s;
Until Length (Memo1.Text) < z;
For x:= 1 to Length (v) Do
Begin
IF v[x]= ' '
   then v[x]:= '0';
End;
Memo2.Text:= v;
ProgressBar1.Position:= 0;
Animate1.Stop;
Form1.Cursor:= crDefault;
end;


procedure TForm1.Button4Click(Sender: TObject);
VAR m, n, P,  d, i, z : Int64;
    code1, code2, code3 : Integer;
    v, w : String;

begin
Form1.Cursor:= crHourglass;
Animate1.Play (1, Animate1.FrameCount, 0);
Val(Edit1.Text, d, Code1);
if code1 <> 0
   then
   Begin
   MessageDlg('Fehler an Position: '
   + IntToStr(Code1), mtWarning, [mbOk], 0);
   Animate1.Stop;
   exit;
   End;
Val(Edit2.Text, n, Code2);
if code2 <> 0
   then
   Begin
   MessageDlg('Fehler an Position: '
   + IntToStr(Code2), mtWarning, [mbOk], 0);
   Animate1.Stop;
   exit;
   End;
ProgressBar1.Max:= Length(Memo2.Text);
z:= 1;
m:= 0;
w:='';
ProgressBar1.Position:= z;
Repeat
IF Length (Memo2.Text) >= z
   Then
   Begin
   v:= Copy (Memo2.Text, z, 10);
   Val(v, m, Code3);
   z:= z + 10;
   End;
P:= m mod n;
i:= 1;
While i < d Do
      Begin
      Application.ProcessMessages;
      i:= i + 1;
      P:= (P * m) mod n;
      End;
w:= w + (Chr ((p Div 1000000) - 256))
      + (Chr ((p Div 1000) - ((p Div 1000000) * 1000) - 256))
      + (Chr (p - (p Div 1000) * 1000 - 256));
ProgressBar1.Position:= z;
Until Length (Memo2.Text) < z;
Memo1.text:= w;
ProgressBar1.Position:= 0;
Animate1.Stop;
Form1.Cursor:= crDefault;
end;


procedure Speichern (Var t : String);
Var ts: textfile;
begin
With Form1 do
If SaveDialog1.execute
   then
   begin
   assignfile (ts, SaveDialog1.FileName);
   If not Fileexists (SaveDialog1.FileName)
   then
     Begin
     rewrite (ts);
     write (ts, t);
     closefile (ts);
     End
   Else
     Begin
     If MessageDlg('Die Datei existiert bereits! Datei überschreiben?',
     mtConfirmation, [mbYes, mbNo], 0) = mrYes
     then
       Begin
       rewrite (ts);
       write (ts, t);
       closefile (ts);
       End
     End
   End;
end;


procedure Oeffnen;
Var tv: textfile;
begin
With Form1 do
If OpenDialog1.execute
   then
   Begin
   Assignfile (tv, OpenDialog1.FileName);
   Reset (tv);
   read (tv, t);
   Closefile (tv);
   End;
end;



procedure TForm1.Button3Click(Sender: TObject);
begin
Oeffnen;
Memo1.text:=t;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
Oeffnen;
Memo2.text:= t;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
t:= Memo1.text;
Speichern (t);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
t:= Memo2.text;
Speichern (t);
end;

end.
