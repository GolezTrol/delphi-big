unit uBigControl;

interface

uses Windows, Messages, Classes, Controls, StdCtrls, Dialogs;

type
  TBigControl = class(TWinControl)
  private
    // Container control
    FControl: TControl;
  protected
    function HasControl: Boolean;
    procedure SetControl(const Value: TControl);
    property Control: TControl read FControl write SetControl;
    function CreateControl: TControl; virtual; abstract;
  protected
    // Behavioral overrules
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure WMEraseBkGnd(var Msg: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SetParent(AParent: TWinControl); override;
    procedure CreateWnd; override;
  public
    constructor Create(AOwner: TComponent); override;
  public
    // Linking properties
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  end;

implementation

{ TBigControl }

constructor TBigControl.Create(AOwner: TComponent);
begin
  inherited;
  SetControl(CreateControl);
end;

procedure TBigControl.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  // Transparent container.
  Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT;
end;

procedure TBigControl.CreateWnd;
begin
  // Only create the container in design time
  if csDesigning in ComponentState  then
    inherited;
end;

function TBigControl.HasControl: Boolean;
begin
  Result := Assigned(FControl);
end;

procedure TBigControl.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  // Set the bounds of the control, then set the container bounds according to the new bounds.
  FControl.SetBounds(ALeft, ATop, AWidth, AHeight);
  inherited SetBounds(FControl.Left, FControl.Top, FControl.Width, FControl.Height);
end;

procedure TBigControl.SetControl(const Value: TControl);
begin
  FControl := Value;
  FControl.SetSubComponent(True);
  // Size the container the the control's default size.
  SetBounds(Left, Top, FControl.Width, FControl.Height);
end;

procedure TBigControl.SetParent(AParent: TWinControl);
begin
  // Set the parent of the control earlier, so the container is on top.
  FControl.Parent := AParent;
  inherited;
end;

procedure TBigControl.WMEraseBkGnd(var Msg: TWMEraseBkGnd);
begin
  // Transparent container.
  SetBkMode(Msg.DC, TRANSPARENT);
  Msg.Result := 1;
end;

procedure TBigControl.WMPaint(var Msg: TWMPaint);
begin
  // Nothing to paint.
end;

end.

