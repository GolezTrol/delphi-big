unit fTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBigControl, uBigEdit, uBigCustomControl, ExtCtrls, StdCtrls,
  uBigPaintbox;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Timer1: TTimer;
    GTPaintBox1: TGTPaintBox;
    Edit1: TEdit;
    procedure Timer1Timer(Sender: TObject);
    procedure GTPaintBox1Paint(Sender: TObject);
    procedure GTPaintBox1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.GTPaintBox1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['a'..'z'] then
    TGTPaintBox(Sender).Tag := Integer(Key);
end;

procedure TForm2.GTPaintBox1Paint(Sender: TObject);
var
  PaintBox: TGTPaintBox;
begin
  PaintBox := TGTPaintBox(Sender);

  if PaintBox.Focused then
    DrawFocusRect(PaintBox.Canvas.DrawFocusRect(PaintBox.Canvas.ClipRect));

  PaintBox.Canvas.TextOut(Random(200), Random(200), Char(PaintBox.Tag));
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
  Invalidate;
end;

end.
