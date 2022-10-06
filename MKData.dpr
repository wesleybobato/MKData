program MKData;

uses
  Vcl.Forms,
  Vcl.Styles,
  Vcl.Themes,
  UFrmBase in 'uFrmBase.pas',
  UCliente in 'uCliente.pas',
  UEndereco in 'uEndereco.pas',
  UTelefone in 'uTelefone.pas',
  UControleCliente in 'uControleCliente.pas',
  UControleEndereco in 'uControleEndereco.pas',
  UControleTelefone in 'uControleTelefone.pas',
  UDmBanco in 'uDmBanco.pas' {DMBanco: TDataModule} ,
  UFrmPrincipal in 'uFrmPrincipal.pas' {FrmPrincipal} ,
  UFrmPesquisaCliente in 'uFrmPesquisaCliente.pas' {FrmPesquisaCliente} ,
  UFrmCadastroCliente in 'uFrmCadastroCliente.pas' {FrmCadastroCliente};

{$R *.res}


begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle( 'Lavender Classico' );
  Application.CreateForm( TDMBanco, DMBanco );
  Application.CreateForm( TFrmPrincipal, FrmPrincipal );
  Application.Run;

end.
