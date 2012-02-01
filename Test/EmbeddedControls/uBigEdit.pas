unit uBigEdit;

interface

uses
  Classes, Controls, uBigCustomControl, StdCtrls;

type
  TBigEdit = class(TBigCustomControl)
  protected
    function CreateControl: TControl; override;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('BigControls', [TBigEdit]);
end;

{ TBigEdit }

function TBigEdit.CreateControl: TControl;
begin
  Result := TEdit.Create(Self);
end;

end.
