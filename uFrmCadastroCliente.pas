unit uFrmCadastroCliente;

interface

uses
  // Winapi
  Winapi.Windows,
  Winapi.Messages,

  // System
  System.Classes,
  System.SysUtils,
  System.Variants,

  // Vcl
  Vcl.Mask,
  Vcl.Forms,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.Dialogs,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,

  // Data
  Data.DB,
  Data.Bind.Components,
  Data.Bind.ObjectScope,

  // Rest
  REST.Client,
  IPPeerClient,

  // Self
  UFrmBase,
  UCliente,
  UControleCliente,

  // Firedac
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.Stan.Option,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet;

type
  TStatus = ( TsNenhum, TsInclusao, TsAlteracao );

type
  TFrmCadastroCliente = class( TFormBase )
    EdtNome: TEdit;
    Label1: TLabel;
    RdgTipoPessoa: TRadioGroup;
    ChkAtivo: TCheckBox;
    EdtCPF: TMaskEdit;
    Label2: TLabel;
    EdtCNPJ: TMaskEdit;
    Label3: TLabel;
    EdtRG: TMaskEdit;
    Label4: TLabel;
    EdtIE: TMaskEdit;
    Label5: TLabel;
    EdtData: TDateTimePicker;
    Label6: TLabel;
    PnlAcoes: TPanel;
    BtnSalvar: TButton;
    BtnCancelar: TButton;
    PgcItems: TPageControl;
    TbsEnderecos: TTabSheet;
    TbsTelefones: TTabSheet;
    DsTelefones: TDataSource;
    DsEnderecos: TDataSource;
    TblTelefones: TFDMemTable;
    TblEnderecos: TFDMemTable;
    DbgEnderecos: TDBGrid;
    DbgTelefones: TDBGrid;
    EdtCEP: TMaskEdit;
    Label7: TLabel;
    BtnViaCep: TButton;
    EdtLogradouro: TEdit;
    Label8: TLabel;
    EdtNumero: TEdit;
    Label9: TLabel;
    EdtBairro: TEdit;
    Label10: TLabel;
    EdtCidade: TEdit;
    Label11: TLabel;
    EdtEstado: TEdit;
    Label12: TLabel;
    EdtPais: TEdit;
    Label13: TLabel;
    PnlBotoesEndereco: TPanel;
    BtnExcluirEndereco: TButton;
    BtnAlterarEndereco: TButton;
    BtnIncluirEndereco: TButton;
    BtnSalvarEndereco: TButton;
    Panel3: TPanel;
    BtnExcluirTelefone: TButton;
    BtnAlterarTelefone: TButton;
    BtnIncluirTelefone: TButton;
    BtnSalvarTelefone: TButton;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    TblEnderecosID: TIntegerField;
    TblEnderecosID_CLIENTE: TIntegerField;
    TblEnderecosLOGRADOURO: TStringField;
    TblEnderecosNUMERO: TStringField;
    TblEnderecosCEP: TStringField;
    TblEnderecosBAIRRO: TStringField;
    TblEnderecosCIDADE: TStringField;
    TblEnderecosESTADO: TStringField;
    TblEnderecosPAIS: TStringField;
    TblTelefonesID: TIntegerField;
    TblTelefonesID_CLIENTE: TIntegerField;
    TblTelefonesDDD: TStringField;
    TblTelefonesTELEFONE: TStringField;
    Label14: TLabel;
    Label16: TLabel;
    EdtDDD: TMaskEdit;
    BtnCancelarEndereco: TButton;
    BtnCancelarTelefone: TButton;
    EdtTelefone: TMaskEdit;
    procedure BtnViaCepClick( Sender: TObject );
    procedure BtnCancelarClick( Sender: TObject );
    procedure BtnSalvarClick( Sender: TObject );
    procedure BtnIncluirEnderecoClick( Sender: TObject );
    procedure BtnAlterarEnderecoClick( Sender: TObject );
    procedure BtnExcluirEnderecoClick( Sender: TObject );
    procedure FormShow( Sender: TObject );
    procedure BtnIncluirTelefoneClick( Sender: TObject );
    procedure BtnAlterarTelefoneClick( Sender: TObject );
    procedure BtnExcluirTelefoneClick( Sender: TObject );
    procedure FormCreate( Sender: TObject );
    procedure BtnCancelarEnderecoClick( Sender: TObject );
    procedure BtnSalvarEnderecoClick( Sender: TObject );
    procedure BtnCancelarTelefoneClick( Sender: TObject );
    procedure BtnSalvarTelefoneClick( Sender: TObject );
    procedure RdgTipoPessoaClick( Sender: TObject );
  private
    { Private declarations }
    FStatus:         TStatus;
    FStatusEndereco: TStatus;
    FStatusTelefone: TStatus;

    FCliente:         TCliente;
    FControleCliente: TControleCliente;

    procedure PopularControles;
    procedure PopularObjeto;

    function ValidarCEP: Boolean;
    function ValidarCliente: Boolean;
    function ValidarEndereco: Boolean;
    function ValidarTelefone: Boolean;

    procedure RecuperarEndereco;
    procedure RecuperarTelefone;

    procedure LimparEndereco;
    procedure LimparTelefone;

    procedure StatusEndereco( const Value: TStatus );
    procedure StatusTelefone( const Value: TStatus );
  public
    { Public declarations }
    property Status:  TStatus read FStatus write FStatus;
    property Cliente: TCliente read FCliente write FCliente;

    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}


uses
  // System
  System.JSON,
  System.UITypes,

  // Self
  UTelefone,
  UEndereco;

procedure TFrmCadastroCliente.BtnCancelarClick( Sender: TObject );
begin
  Close;
end;

procedure TFrmCadastroCliente.BtnCancelarEnderecoClick( Sender: TObject );
begin
  LimparEndereco;
  StatusEndereco( TsNenhum );
end;

procedure TFrmCadastroCliente.BtnCancelarTelefoneClick( Sender: TObject );
begin
  LimparTelefone;
  StatusTelefone( TsNenhum );
end;

procedure TFrmCadastroCliente.BtnSalvarClick( Sender: TObject );
begin
  if ValidarCliente then
  begin
    PopularObjeto;

    case FStatus of
      TsInclusao:
        begin
          if not FControleCliente.Inserir( FCliente ) then
            raise Exception.Create( 'Falha ao inserir um cliente.' );
        end;

      TsAlteracao:
        begin
          if not FControleCliente.Editar( FCliente ) then
            raise Exception.Create( 'Falha ao alterar um cliente.' );
        end;
    end;

    ModalResult := MrOk;
  end;
end;

procedure TFrmCadastroCliente.BtnSalvarEnderecoClick( Sender: TObject );
begin
  if ValidarEndereco then
  begin
    TblEnderecos.DisableControls;
    try
      case FStatusEndereco of
        TsInclusao:
          TblEnderecos.Append;
        TsAlteracao:
          TblEnderecos.Edit;
      end;
      TblEnderecos.FieldByName( 'LOGRADOURO' ).AsString := EdtLogradouro.Text;
      TblEnderecos.FieldByName( 'NUMERO' ).AsString     := EdtNumero.Text;
      TblEnderecos.FieldByName( 'CEP' ).AsString        := EdtCEP.Text;
      TblEnderecos.FieldByName( 'BAIRRO' ).AsString     := EdtBairro.Text;
      TblEnderecos.FieldByName( 'CIDADE' ).AsString     := EdtCidade.Text;
      TblEnderecos.FieldByName( 'ESTADO' ).AsString     := EdtEstado.Text;
      TblEnderecos.FieldByName( 'PAIS' ).AsString       := EdtPais.Text;
      TblEnderecos.Post;

      LimparEndereco;
      StatusEndereco( TsNenhum );
    finally
      TblEnderecos.EnableControls;
    end;
  end;
end;

procedure TFrmCadastroCliente.BtnSalvarTelefoneClick( Sender: TObject );
begin
  if ValidarTelefone then
  begin
    TblTelefones.DisableControls;
    try
      case FStatusTelefone of
        TsInclusao:
          TblTelefones.Append;
        TsAlteracao:
          TblTelefones.Edit;
      end;

      TblTelefones.FieldByName( 'DDD' ).AsString      := EdtDDD.Text;
      TblTelefones.FieldByName( 'TELEFONE' ).AsString := EdtTelefone.Text;
      TblTelefones.Post;

      LimparTelefone;
      StatusTelefone( TsNenhum );
    finally
      TblTelefones.EnableControls;
    end;
  end;
end;

procedure TFrmCadastroCliente.BtnViaCepClick( Sender: TObject );
var
  LJSON: TJSonValue;
begin
  if ValidarCEP then
  begin
    RESTClient1.BaseURL := 'http://viacep.com.br/ws/' + EdtCEP.Text + '/json/';
    RESTRequest1.Execute;

    LJSON := TJSonObject.ParseJSONValue( RESTResponse1.Content );
    try
      EdtLogradouro.Text := LJSON.GetValue< string >( 'logradouro', '' );
      EdtBairro.Text     := LJSON.GetValue< string >( 'bairro', '' );
      EdtCidade.Text     := LJSON.GetValue< string >( 'localidade', '' );
      EdtEstado.Text     := LJSON.GetValue< string >( 'uf', '' );
      EdtPais.Text       := 'Brasil';
    finally
      LJSON.Free;
    end;
  end;
end;

procedure TFrmCadastroCliente.BtnExcluirEnderecoClick( Sender: TObject );
begin
  if TblEnderecos.IsEmpty or ( TblEnderecos.RecNo < 1 ) then
    raise Exception.Create( 'Selecione um endereço corretamente para excluir.' );

  if MessageDlg( 'Você tem certeza que deseja excluir o endereço selecionado?', MtConfirmation, [ MbYes, MbNo ], 0 ) = MrYes then
  begin
    TblEnderecos.Delete;
    StatusEndereco( TsNenhum );
  end;
end;

procedure TFrmCadastroCliente.BtnAlterarEnderecoClick( Sender: TObject );
begin
  RecuperarEndereco;
  StatusEndereco( TsAlteracao );
end;

procedure TFrmCadastroCliente.BtnIncluirEnderecoClick( Sender: TObject );
begin
  LimparEndereco;
  StatusEndereco( TsInclusao );
end;

procedure TFrmCadastroCliente.BtnExcluirTelefoneClick( Sender: TObject );
begin
  if TblTelefones.IsEmpty or ( TblTelefones.RecNo < 1 ) then
    raise Exception.Create( 'Selecione um telefone corretamente para excluir.' );

  if MessageDlg( 'Você tem certeza que deseja excluir o telefone selecionado?', MtConfirmation, [ MbYes, MbNo ], 0 ) = MrYes then
  begin
    TblTelefones.Delete;
    StatusTelefone( TsNenhum );
  end;
end;

procedure TFrmCadastroCliente.BtnAlterarTelefoneClick( Sender: TObject );
begin
  RecuperarTelefone;
  StatusTelefone( TsAlteracao );
end;

procedure TFrmCadastroCliente.BtnIncluirTelefoneClick( Sender: TObject );
begin
  LimparTelefone;
  StatusTelefone( TsInclusao );
end;

constructor TFrmCadastroCliente.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FControleCliente := TControleCliente.Create;
end;

destructor TFrmCadastroCliente.Destroy;
begin
  FControleCliente.Free;
  inherited Destroy;
end;

procedure TFrmCadastroCliente.FormCreate( Sender: TObject );
begin
  TblEnderecos.CreateDataSet;
  TblTelefones.CreateDataSet;

  StatusEndereco( TsNenhum );
  StatusTelefone( TsNenhum );
end;

procedure TFrmCadastroCliente.FormShow( Sender: TObject );
begin
  case FStatus of
    TsInclusao:
      ;
    TsAlteracao:
      begin
        PopularControles;
      end;
  end;
end;

procedure TFrmCadastroCliente.LimparEndereco;
begin
  EdtLogradouro.Text := '';
  EdtNumero.Text     := '';
  EdtCEP.Text        := '';
  EdtBairro.Text     := '';
  EdtCidade.Text     := '';
  EdtEstado.Text     := '';
  EdtPais.Text       := '';
end;

procedure TFrmCadastroCliente.LimparTelefone;
begin
  EdtDDD.Text      := '';
  EdtTelefone.Text := '';
end;

procedure TFrmCadastroCliente.PopularControles;
var
  I: Integer;
begin
  ChkAtivo.Checked        := FCliente.Ativo;
  RdgTipoPessoa.ItemIndex := Ord( FCliente.TipoPessoa );
  EdtNome.Text            := FCliente.Nome;
  EdtCPF.Text             := FCliente.CPF;
  EdtCNPJ.Text            := FCliente.CNPJ;
  EdtRG.Text              := FCliente.RG;
  EdtIE.Text              := FCliente.IE;
  EdtData.Date            := FCliente.Data;

  TblEnderecos.DisableControls;
  try
    for I := 0 to FCliente.Enderecos.Count - 1 do
    begin
      TblEnderecos.Append;
      TblEnderecos.FieldByName( 'ID' ).AsInteger         := FCliente.Enderecos.Items[ I ].Id;
      TblEnderecos.FieldByName( 'ID_CLIENTE' ).AsInteger := FCliente.Enderecos.Items[ I ].IdCliente;
      TblEnderecos.FieldByName( 'LOGRADOURO' ).AsString  := FCliente.Enderecos.Items[ I ].Logradouro;
      TblEnderecos.FieldByName( 'NUMERO' ).AsString      := FCliente.Enderecos.Items[ I ].Numero;
      TblEnderecos.FieldByName( 'CEP' ).AsString         := FCliente.Enderecos.Items[ I ].Cep;
      TblEnderecos.FieldByName( 'BAIRRO' ).AsString      := FCliente.Enderecos.Items[ I ].Bairro;
      TblEnderecos.FieldByName( 'CIDADE' ).AsString      := FCliente.Enderecos.Items[ I ].Cidade;
      TblEnderecos.FieldByName( 'ESTADO' ).AsString      := FCliente.Enderecos.Items[ I ].Estado;
      TblEnderecos.FieldByName( 'PAIS' ).AsString        := FCliente.Enderecos.Items[ I ].Pais;
      TblEnderecos.Post;
    end;
  finally
    TblEnderecos.EnableControls;
  end;

  TblTelefones.DisableControls;
  try
    for I := 0 to FCliente.Telefones.Count - 1 do
    begin
      TblTelefones.Append;
      TblTelefones.FieldByName( 'ID' ).AsInteger         := FCliente.Telefones.Items[ I ].Id;
      TblTelefones.FieldByName( 'ID_CLIENTE' ).AsInteger := FCliente.Telefones.Items[ I ].IdCliente;
      TblTelefones.FieldByName( 'DDD' ).AsString         := FCliente.Telefones.Items[ I ].DDD;
      TblTelefones.FieldByName( 'TELEFONE' ).AsString    := FCliente.Telefones.Items[ I ].Telefone;
      TblTelefones.Post;
    end;
  finally
    TblTelefones.EnableControls;
  end;

  RdgTipoPessoaClick( nil );
end;

procedure TFrmCadastroCliente.RecuperarEndereco;
begin
  EdtLogradouro.Text := TblEnderecos.FieldByName( 'LOGRADOURO' ).AsString;
  EdtNumero.Text     := TblEnderecos.FieldByName( 'NUMERO' ).AsString;
  EdtCEP.Text        := TblEnderecos.FieldByName( 'CEP' ).AsString;
  EdtBairro.Text     := TblEnderecos.FieldByName( 'BAIRRO' ).AsString;
  EdtCidade.Text     := TblEnderecos.FieldByName( 'CIDADE' ).AsString;
  EdtEstado.Text     := TblEnderecos.FieldByName( 'ESTADO' ).AsString;
  EdtPais.Text       := TblEnderecos.FieldByName( 'PAIS' ).AsString;
end;

procedure TFrmCadastroCliente.RecuperarTelefone;
begin
  EdtDDD.Text      := TblTelefones.FieldByName( 'DDD' ).AsString;
  EdtTelefone.Text := TblTelefones.FieldByName( 'TELEFONE' ).AsString;
end;

procedure TFrmCadastroCliente.PopularObjeto;
var
  Endereco: TEndereco;
  Telefone: TTelefone;
begin
  FCliente.Ativo      := ChkAtivo.Checked;
  FCliente.TipoPessoa := TTipoPessoa( RdgTipoPessoa.ItemIndex );
  FCliente.Nome       := EdtNome.Text;
  FCliente.CPF        := EdtCPF.Text;
  FCliente.CNPJ       := EdtCNPJ.Text;
  FCliente.RG         := EdtRG.Text;
  FCliente.IE         := EdtIE.Text;
  FCliente.Data       := EdtData.Date;

  TblEnderecos.DisableControls;
  try
    FCliente.Enderecos.Clear;

    TblEnderecos.First;
    while not TblEnderecos.Eof do
    begin
      Endereco            := TEndereco.Create;
      Endereco.Id         := TblEnderecos.FieldByName( 'ID' ).AsInteger;
      Endereco.IdCliente  := TblEnderecos.FieldByName( 'ID_CLIENTE' ).AsInteger;
      Endereco.Logradouro := TblEnderecos.FieldByName( 'LOGRADOURO' ).AsString;
      Endereco.Numero     := TblEnderecos.FieldByName( 'NUMERO' ).AsString;
      Endereco.Cep        := TblEnderecos.FieldByName( 'CEP' ).AsString;
      Endereco.Bairro     := TblEnderecos.FieldByName( 'BAIRRO' ).AsString;
      Endereco.Cidade     := TblEnderecos.FieldByName( 'CIDADE' ).AsString;
      Endereco.Estado     := TblEnderecos.FieldByName( 'ESTADO' ).AsString;
      Endereco.Pais       := TblEnderecos.FieldByName( 'PAIS' ).AsString;
      FCliente.Enderecos.Add( Endereco );

      TblEnderecos.Next;
    end;
  finally
    TblEnderecos.EnableControls;
  end;

  TblTelefones.DisableControls;
  try
    FCliente.Telefones.Clear;

    TblTelefones.First;
    while not TblTelefones.Eof do
    begin
      Telefone           := TTelefone.Create;
      Telefone.Id        := TblTelefones.FieldByName( 'ID' ).AsInteger;
      Telefone.IdCliente := TblTelefones.FieldByName( 'ID_CLIENTE' ).AsInteger;
      Telefone.DDD       := TblTelefones.FieldByName( 'DDD' ).AsString;
      Telefone.Telefone  := TblTelefones.FieldByName( 'TELEFONE' ).AsString;
      FCliente.Telefones.Add( Telefone );

      TblTelefones.Next;
    end;
  finally
    TblTelefones.EnableControls;
  end;
end;

procedure TFrmCadastroCliente.RdgTipoPessoaClick( Sender: TObject );
begin
  case RdgTipoPessoa.ItemIndex of
    0:
      begin
        EdtCNPJ.Text    := '';
        EdtCNPJ.Enabled := False;

        EdtIE.Text    := '';
        EdtIE.Enabled := False;

        EdtCPF.Enabled := True;
        EdtRG.Enabled  := True;
      end;

    1:
      begin
        EdtCPF.Text    := '';
        EdtCPF.Enabled := False;

        EdtRG.Text    := '';
        EdtRG.Enabled := False;

        EdtCNPJ.Enabled := True;
        EdtIE.Enabled   := True;
      end;
  end;
end;

procedure TFrmCadastroCliente.StatusEndereco( const Value: TStatus );
begin
  FStatusEndereco := Value;

  BtnIncluirEndereco.Enabled  := ( Value = TsNenhum );
  BtnAlterarEndereco.Enabled  := ( Value = TsNenhum );
  BtnCancelarEndereco.Enabled := ( Value <> TsNenhum );
  BtnExcluirEndereco.Enabled  := ( Value = TsNenhum );
  BtnSalvarEndereco.Enabled   := ( Value <> TsNenhum );

  EdtLogradouro.ReadOnly := ( Value = TsNenhum );
  EdtNumero.ReadOnly     := ( Value = TsNenhum );
  EdtCEP.ReadOnly        := ( Value = TsNenhum );
  EdtBairro.ReadOnly     := ( Value = TsNenhum );
  EdtCidade.ReadOnly     := ( Value = TsNenhum );
  EdtEstado.ReadOnly     := ( Value = TsNenhum );
  EdtPais.ReadOnly       := ( Value = TsNenhum );
end;

procedure TFrmCadastroCliente.StatusTelefone( const Value: TStatus );
begin
  FStatusTelefone := Value;

  BtnIncluirTelefone.Enabled  := ( Value = TsNenhum );
  BtnAlterarTelefone.Enabled  := ( Value = TsNenhum );
  BtnCancelarTelefone.Enabled := ( Value <> TsNenhum );
  BtnExcluirTelefone.Enabled  := ( Value = TsNenhum );
  BtnSalvarTelefone.Enabled   := ( Value <> TsNenhum );

  EdtDDD.ReadOnly      := ( Value = TsNenhum );
  EdtTelefone.ReadOnly := ( Value = TsNenhum );
end;

function TFrmCadastroCliente.ValidarCEP: Boolean;
var
  I: Integer;
begin
  if Trim( EdtCEP.Text ) = '' then
    raise Exception.Create( 'O campo CEP está vazio favor preencher.' );

  if Length( EdtCEP.Text ) <> 8 then
    raise Exception.Create( 'O campo CEP possui uma quantidade de dígitos diferente de 8.' );

  for I := Low( EdtCEP.Text ) to High( EdtCEP.Text ) do
  begin
    if not CharInSet( EdtCEP.Text[ I ], [ '0' .. '9' ] ) then
      raise Exception.Create( 'O campo CEP possúi caracteres inválidos.' );
  end;

  Result := True;
end;

function TFrmCadastroCliente.ValidarCliente: Boolean;
begin
  if Trim( EdtNome.Text ) = '' then
    raise Exception.Create( 'Preencha corretamente o campo nome.' );

  if RdgTipoPessoa.ItemIndex < 0 then
    raise Exception.Create( 'Selecione corretamente o campo tipo de pessoa.' );

  case RdgTipoPessoa.ItemIndex of
    0:
      begin
        if ( Trim( EdtCPF.Text ) = '' ) or ( Length( EdtCPF.Text ) <> 11 ) then
          raise Exception.Create( 'Preencha corretamente o campo CPF.' );
      end;

    1:
      begin
        if ( Trim( EdtCNPJ.Text ) = '' ) or ( Length( EdtCNPJ.Text ) <> 14 ) then
          raise Exception.Create( 'Preencha corretamente o campo CNPJ.' );
      end;
  end;

  Result := True;
end;

function TFrmCadastroCliente.ValidarEndereco: Boolean;
begin
  Result := ValidarCEP;
end;

function TFrmCadastroCliente.ValidarTelefone: Boolean;
begin
  Result := True;
end;

end.
