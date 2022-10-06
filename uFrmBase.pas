unit uFrmBase;

interface

uses
  // System
  System.Classes,

  // Vcl
  Vcl.Forms;

type
  TFormBase = class( TForm )
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create( AOwner: TComponent ); override;
  end;

implementation

{ TFormBase }

constructor TFormBase.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );

  KeyPreview := True;
  Position   := PoScreenCenter;
  ShowHint   := True;
end;

end.
