unit uDmBanco;

interface

uses
  // Syste,
  System.Classes,
  System.SysUtils,

  // Data
  Data.DB,

  // Firedac
  FireDAC.Phys,
  FireDAC.DatS,
  FireDAC.DApt,
  FireDAC.Phys.FB,
  FireDAC.UI.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Intf,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Param,
  FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Error,
  FireDAC.Stan.Async,
  FireDAC.Stan.Option,
  FireDAC.Comp.Client,
  FireDAC.Phys.IBBase,
  FireDAC.Comp.DataSet;

type
  TDMBanco = class( TDataModule )
    FDConnection: TFDConnection;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    FDTransaction1: TFDTransaction;
    procedure DataModuleCreate( Sender: TObject );
    procedure DataModuleDestroy( Sender: TObject );
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMBanco: TDMBanco;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


procedure TDMBanco.DataModuleCreate( Sender: TObject );
var
  LDll:      string;
  LFolder:   string;
  LDatabase: string;
begin
  LFolder   := ExtractFilePath( ParamStr( 0 ) );
  LDll      := LFolder + 'fbclient.dll';
  LDatabase := LFolder + 'DB.FDB';

  if not FileExists( LDll ) then
    raise Exception.Create( 'DLL do Firebird não encontrada.' );

  if not FileExists( LDatabase ) then
    raise Exception.Create( 'Banco de dados indisponível.' );

  FDPhysFBDriverLink.VendorLib := LDll;

  FDConnection.LoginPrompt                     := False;
  FDConnection.Params.Values[ 'DriverID' ]     := 'FB';
  FDConnection.Params.Values[ 'User_Name' ]    := 'SYSDBA';
  FDConnection.Params.Values[ 'Password' ]     := 'masterkey';
  FDConnection.Params.Values[ 'CharacterSet' ] := 'ISO8859_1';
  FDConnection.Params.Values[ 'Database' ]     := LDatabase;
  FDConnection.Connected                       := True;

  if not FDConnection.Connected then
    raise Exception.Create( 'Falha ao se conectar no banco de dados.' );
end;

procedure TDMBanco.DataModuleDestroy( Sender: TObject );
begin
  if FDConnection.Connected then
    FDConnection.Connected := False;
end;

end.
