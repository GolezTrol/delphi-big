unit uBigPaintbox;

interface

uses Windows, Classes, Messages, Controls;

type
  TGTPaintBox = class(TCustomControl)
  private
    FOnPaint: TNotifyEvent;
  protected
    // Three methods below are for transparent background. This may not work that great,
    // and if you don't care about it, you can remove them.
    procedure WMEraseBkGnd(var Msg: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SetParent(AParent: TWinControl); override;
  protected
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    property Canvas;
  published
    // Introduce OnPaint event
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
    // Publish keyboard and mouse events.
    property OnKeyPress;
    property OnKeyDown;
    property OnKeyUp;
    property OnClick;
    property OnDblClick;
    property OnMouseUp;
    property OnMouseDown;
    property OnMouseMove;
    // And some other behavioral property that relate to keyboard input.
    property TabOrder;
    property TabStop;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('GolezTrol', [TGTPaintBox]);
end;

{ TGTPaintBox }

procedure TGTPaintBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT;
end;

procedure TGTPaintBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;

  // Focus the control when it is clicked.
  if not (csDesigning in ComponentState) and CanFocus then
    SetFocus;
end;

procedure TGTPaintBox.Paint;
begin
  inherited;
  // Call paint even if it is assigned.
  if Assigned(FOnPaint) then
    FOnPaint(Self);
end;

procedure TGTPaintBox.SetParent(AParent: TWinControl);
var
  NewStyle: Integer;
begin
  inherited;
  if AParent = nil then
    Exit;

  // Make sure the parent is updated too behind the control.
  NewStyle := GetWindowLong(AParent.Handle, GWL_STYLE) and not WS_CLIPCHILDREN;
  SetWindowLong(AParent.Handle, GWL_STYLE, NewStyle);
end;

procedure TGTPaintBox.WMEraseBkGnd(var Msg: TWMEraseBkGnd);
begin
  SetBkMode(Msg.DC, TRANSPARENT);
  Msg.Result := 1;
end;

end.
