unit BigWordSelectLabel;

interface

uses
  Windows, Controls, Classes, Graphics, Types, Messages;

type
  TBigWordSelectLabel = class(TCustomControl)
  // Keyboard shizzle
  private
    FWordIndex: Integer;
    procedure CMWantSpecialKey(var Message: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  // Mouse shizzle
  protected
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    function WordAt(X, Y: Integer): Integer;
  // General
  private
    FWords: TStringList;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  protected
    procedure Paint; override;
    procedure ToggleWord(WordIndex: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Caption;
  end;

implementation

{ TBigWordSelectLabel }

procedure TBigWordSelectLabel.CMTextChanged(var Message: TMessage);
begin
  FWords.DelimitedText := Caption;
  FWordIndex := 0;
end;

procedure TBigWordSelectLabel.CMWantSpecialKey(var Message: TCMWantSpecialKey);
begin
  // Even expliciet duidelijk maken dat we graag de pijltjes naar links en
  // rechts zelf willen houden. Anders gebruikt het form ze voor navigatie.
  if (Message.CharCode = VK_LEFT) or (Message.CharCode = VK_RIGHT) then
    Message.Result := 1;
end;

constructor TBigWordSelectLabel.Create(AOwner: TComponent);
begin
  inherited;
  FWords := TStringList.Create;
  FWords.Delimiter := ' ';
  FWords.StrictDelimiter := True;

  Tabstop := True;

  Canvas.Brush.Color := clBtnFace;
  Canvas.Font.Color := clBtnText;
end;

destructor TBigWordSelectLabel.Destroy;
begin
  FWords.Destroy;
  inherited;
end;

procedure TBigWordSelectLabel.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  // Pijltjesnavigatie
  case Key of
    VK_LEFT:
      if FWordIndex > 0 then
        Dec(FWordIndex);
    VK_RIGHT:
      if FWordIndex < FWords.Count - 1 then
        Inc(FWordIndex);
    VK_SPACE:
      ToggleWord(FWordIndex);
  end;
  Invalidate;
end;

procedure TBigWordSelectLabel.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  WordIndex: Integer;
begin
  inherited;
  // Index van woord op positie X, Y bepalen.
  WordIndex := WordAt(X, Y);
  // Woord (de)selecteren.
  if WordIndex > -1 then
    ToggleWord(WordIndex);
end;

procedure TBigWordSelectLabel.Paint;
var
  i: Integer;
  WidthHeight: TSize;
  WordWidth, x, y: Integer;
begin
  inherited;

  WidthHeight := Canvas.TextExtent(' ');
  x := 2; y := 0;

  // Elk woord afzonderlijk tekenen.
  for i := 0 to FWords.Count - 1 do
  begin
    // Kleur instellen op basis van geselecteerd of niet.
    if Integer(FWords.Objects[i]) = 1 then
    begin
      Canvas.Brush.Color := clHighlight;
      Canvas.Font.Color := clHighlightText;
    end;

    // Kleur inverteren indien geselecteerd.
    if i = FWordIndex then
    begin
      Canvas.Brush.Color := (not ColorToRGB(Canvas.Brush.Color)) and $FFFFFF;
      Canvas.Font.Color := (not ColorToRGB(Canvas.Font.Color)) and $FFFFFF;
    end;

    Canvas.TextOut(x, y, FWords[i]);
    WordWidth := Canvas.TextWidth(FWords[i]);

    if i = FWordIndex then
    begin
      Canvas.DrawFocusRect(Rect(x - 2, 0, x + WordWidth + 4, WidthHeight.cy));
    end;

    // x opschuiven (inclusief spatie)
    x := x + WordWidth + WidthHeight.cx;
    Canvas.Brush.Color := clBtnFace;
    Canvas.Font.Color := clBtnText;
  end;
  // Zin eindigen met '.' (zonder spatie ervoor).
  x := x - WidthHeight.cx;
  Canvas.TextOut(x, y, '.');
end;

procedure TBigWordSelectLabel.ToggleWord(WordIndex: Integer);
var
  Value: Boolean;
begin
  if WordIndex >= FWords.Count then
    Exit;

  // Beetje viezig: Misbruik het object achter elk word om daarin een boolean
  // op te slaan.
  Value := Integer(FWords.Objects[WordIndex]) = 1;
  FWords.Objects[WordIndex] := TObject(Ord(not Value));
  // Control opnieuw tekenen.
  Invalidate;
end;

function TBigWordSelectLabel.WordAt(X, Y: Integer): Integer;
var
  WidthHeight: TSize;
  i, LastX, WordWidth: Integer;
begin
  // Regelhoogte van de tekst en breedte van een spatie opvragen.
  WidthHeight := Canvas.TextExtent(' ');

  // Bepalen op welk woord er is geklikt.
  // Todo: Rekening houden met meerregelige tekst.
  LastX := 2;
  for i := 0 to FWords.Count - 1 do
  begin
     WordWidth := Canvas.TextWidth(FWords[i]);
     if (X >= LastX) and (X <= LastX + WidthHeight.cx + WordWidth) then
     begin
       Result := i;
       Exit;
     end;
     LastX := LastX + WidthHeight.cx + WordWidth;
  end;
  Result := -1;
end;

end.
