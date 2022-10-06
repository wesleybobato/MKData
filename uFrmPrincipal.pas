unit uFrmPrincipal;

interface

uses
  // Winapi
  Winapi.Windows,
  Winapi.Messages,

  // System
  System.Classes,
  System.Actions,
  System.Variants,
  System.SysUtils,

  // Vcl
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ActnList,
  Vcl.Graphics,
  Vcl.StdCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Imaging.Jpeg,
  Vcl.CategoryButtons,

  // Self
  UFrmBase;

type
  TFrmPrincipal = class( TFormBase )
    ImgLogo: TImage;
    PnlMenu: TPanel;
    BtnMenu: TButton;
    CtgButtons: TCategoryButtons;
    AclMain: TActionList;
    AciClient: TAction;
    procedure BtnMenuClick( Sender: TObject );
    procedure AciClientExecute( Sender: TObject );
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  // System
  System.Math,
  System.StrUtils,

  // Self
  UFrmPesquisaCliente;

{$R *.dfm}


procedure TFrmPrincipal.BtnMenuClick( Sender: TObject );
const
  CS_WIDTH_DEFAULT = 185;
var
  Button:    TButton absolute Sender;
  Collapsed: Boolean;
begin
  Collapsed := ( PnlMenu.Width <> CS_WIDTH_DEFAULT );

  // Clean Code Simulate Operator Ternary
  PnlMenu.Width      := Ifthen( Collapsed, CS_WIDTH_DEFAULT, 50 );
  CtgButtons.Visible := Ifthen( Collapsed, Ord( True ), Ord( False ) ) = Ord( True );
  Button.Caption     := Ifthen( Collapsed, 'Menu', '>>' );
end;

procedure TFrmPrincipal.AciClientExecute( Sender: TObject );
var
  Form: TFrmPesquisaCliente;
begin
  Form := TFrmPesquisaCliente.Create( nil );
  try
    Form.ShowModal;
  finally
    Form.Free;
  end;
end;

initialization

ReportMemoryLeaksOnShutdown := True;

end.
