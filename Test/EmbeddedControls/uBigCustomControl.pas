unit uBigCustomControl;

interface

uses uBigControl, Classes, Controls;

type
  // Exposes what Embarcadero forces us to be exposed.
  TBigCustomControl = class(TBigControl)
  private


  // TControl
  private
    function GetAlignWithMargins: Boolean;
    function GetCursor: TCursor;
    function GetCustomHint: TCustomHint;
    function GetHint: string;
    function GetParentCustomHint: Boolean;
    function IsHelpContextStored: Boolean;
    function IsHintStored: Boolean;
    procedure SetAlignWithMargins(const Value: Boolean);
    procedure SetCursor(const Value: TCursor);
    procedure SetCustomHint(const Value: TCustomHint);
    procedure SetHelpContext(const Value: THelpContext);
    procedure SetHelpKeyword(const Value: String);
    procedure SetHint(const Value: string);
    procedure SetMargins(const Value: TMargins);
    procedure SetParentCustomHint(const Value: Boolean);
    function GetHelpContext: THelpContext;
    function GetHelpKeyword: String;
    function GetHelpType: THelpType;
    function GetMargins: TMargins;
    procedure SetHelpType(const Value: THelpType);
  published
    property AlignWithMargins: Boolean read GetAlignWithMargins write SetAlignWithMargins default False;
    property Cursor: TCursor read GetCursor write SetCursor default crDefault;
    property Hint: string read GetHint write SetHint stored IsHintStored;
    property HelpType: THelpType read GetHelpType write SetHelpType default htContext;
    property HelpKeyword: String read GetHelpKeyword write SetHelpKeyword stored IsHelpContextStored;
    property HelpContext: THelpContext read GetHelpContext write SetHelpContext stored IsHelpContextStored default 0;
    property Margins: TMargins read GetMargins write SetMargins;
    property CustomHint: TCustomHint read GetCustomHint write SetCustomHint;
    property ParentCustomHint: Boolean read GetParentCustomHint write SetParentCustomHint default True;
  end;

implementation

type
  TUnprotectedControl = class(TControl);
  TUnprotectedControlActionLink = class(TControlActionLink);

{ TBigCustomControl }

function TBigCustomControl.GetAlignWithMargins: Boolean;
begin
  Result := Control.AlignWithMargins;
end;

function TBigCustomControl.GetCursor: TCursor;
begin
  Result := Control.Cursor;
end;

function TBigCustomControl.GetCustomHint: TCustomHint;
begin
  Result := Control.CustomHint;
end;

function TBigCustomControl.GetHelpContext: THelpContext;
begin
  Result := Control.HelpContext;
end;

function TBigCustomControl.GetHelpKeyword: String;
begin
  Result := Control.HelpKeyword;
end;

function TBigCustomControl.GetHelpType: THelpType;
begin
  Result := Control.HelpType;
end;

function TBigCustomControl.GetHint: string;
begin
  Result := Control.Hint;
end;

function TBigCustomControl.GetMargins: TMargins;
begin
  Result := Control.Margins;
end;

function TBigCustomControl.GetParentCustomHint: Boolean;
begin
  Result := Control.ParentCustomHint;
end;

function TBigCustomControl.IsHelpContextStored: Boolean;
begin
  Result := (TUnprotectedControl(Control).ActionLink = nil) or not TUnprotectedControlActionLink(TUnprotectedControl(Control).ActionLink).IsHelpContextLinked;
end;

function TBigCustomControl.IsHintStored: Boolean;
begin
  Result := (TUnprotectedControl(Control).ActionLink = nil) or not TUnprotectedControlActionLink(TUnprotectedControl(Control).ActionLink).IsHintLinked;
end;

procedure TBigCustomControl.SetAlignWithMargins(const Value: Boolean);
begin
  Control.AlignWithMargins := Value;
end;

procedure TBigCustomControl.SetCursor(const Value: TCursor);
begin
  Control.Cursor := Value;
end;

procedure TBigCustomControl.SetCustomHint(const Value: TCustomHint);
begin
  Control.CustomHint := Value;
end;

procedure TBigCustomControl.SetHelpContext(const Value: THelpContext);
begin
  Control.HelpContext := Value;
end;

procedure TBigCustomControl.SetHelpKeyword(const Value: String);
begin
  Control.HelpKeyword := Value;
end;

procedure TBigCustomControl.SetHelpType(const Value: THelpType);
begin
  Control.HelpType := Value;
end;

procedure TBigCustomControl.SetHint(const Value: string);
begin
  Control.Hint := Value;
end;

procedure TBigCustomControl.SetMargins(const Value: TMargins);
begin
  Control.Margins := Value;
end;

procedure TBigCustomControl.SetParentCustomHint(const Value: Boolean);
begin
  Control.ParentCustomHint := Value;
end;

end.
