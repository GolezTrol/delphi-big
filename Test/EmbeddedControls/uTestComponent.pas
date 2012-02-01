unit uTestComponent;

interface

uses Windows, Messages, Classes, Controls, StdCtrls, Dialogs;

type
  TTestControl = class(TWinControl)
  private
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMEraseBkGnd(var msg: TWMEraseBkGnd); message WM_ERASEBKGND;
  protected
    procedure CreateParams(var params: TCreateParams);
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetParent(AParent: TWinControl); override;
  private
    FEdit: TWinControl;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('BigEmbed', [TTestControl]);
end;

{ TTestControl }

constructor TTestControl.Create(AOwner: TComponent);
begin
  inherited;
  FEdit := TEdit.Create(Self);
  FEdit.SetSubComponent(True);
end;

procedure TTestControl.CreateParams(var params: TCreateParams);
begin
  inherited CreateParams(params);
  params.ExStyle := params.ExStyle or WS_EX_TRANSPARENT;
end;

procedure TTestControl.SetParent(AParent: TWinControl);
begin
  FEdit.Parent := AParent;
  inherited;
end;

procedure TTestControl.WMEraseBkGnd(var msg: TWMEraseBkGnd);
begin
  SetBkMode (msg.DC, TRANSPARENT);
  msg.result := 1;
end;

procedure TTestControl.WMPaint(var Message: TWMPaint);
begin
  if csDesigning in ComponentState then
    inherited;
end;

end.
