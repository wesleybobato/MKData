unit uFrmPesquisaCliente;

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
  Vcl.Forms,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.Dialogs,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,

  // Data
  Data.DB,

  // Self
  UFrmBase,
  UControleCliente,

  // Firedac
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.Comp.Client,
  FireDAC.Stan.Option,
  FireDAC.Comp.DataSet;

type
  TFrmPesquisaCliente = class( TFormBase )
    DbgClientes: TDBGrid;
    TblClientes: TFDMemTable;
    PnClientes: TPanel;
    TblClientesNOME: TStringField;
    TblClientesTIPO_PESSOA: TStringField;
    TblClientesCPF: TStringField;
    TblClientesCNPJ: TStringField;
    TblClientesRG: TStringField;
    TblClientesIE: TStringField;
    TblClientesDATA: TDateField;
    TblClientesATIVO: TStringField;
    DsClientes: TDataSource;
    Panel2: TPanel;
    BtnIncluir: TButton;
    BtnAlterar: TButton;
    BtnEccluir: TButton;
    CbxCampo: TComboBox;
    Label1: TLabel;
    EdtPesquisa: TEdit;
    Label2: TLabel;
    BtnFiltrar: TButton;
    TblClientesID: TIntegerField;
    ChkAtivos: TCheckBox;
    procedure BtnFiltrarClick( Sender: TObject );
    procedure FormCreate( Sender: TObject );
    procedure BtnIncluirClick( Sender: TObject );
    procedure BtnAlterarClick( Sender: TObject );
    procedure BtnEccluirClick( Sender: TObject );
  private
    { Private declarations }
    FControleCliente: TControleCliente;

    function ValidarPesquisa: Boolean;
  public
    { Public declarations }

    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}


uses
  // System
  System.UITypes,
  System.Generics.Defaults,
  System.Generics.Collections,

  // Self
  UCliente,
  UFrmCadastroCliente;

{ TFrmClientSearch }

procedure TFrmPesquisaCliente.BtnAlterarClick( Sender: TObject );
var
  Form:     TFrmCadastroCliente;
  Filtro:   TDictionary< string, string >;
  Cliente:  TCliente;
  Clientes: TObjectList< TCliente >;
begin
  if TblClientes.IsEmpty or ( TblClientes.RecNo < 1 ) then
    raise Exception.Create( 'Selecione um cliente para poder alterar' );

  Filtro := TDictionary< string, string >.Create;
  try
    Filtro.Add( 'ID', TblClientes.FieldByName( 'ID' ).AsString );

    Clientes := FControleCliente.Consultar( Filtro );
    try
      if Assigned( Clientes ) and ( Clientes.Count > 0 ) then
      begin
        Cliente := Clientes.Items[ Clientes.Count - 1 ];

        Form := TFrmCadastroCliente.Create( nil );
        try
          Form.Status  := TsAlteracao;
          Form.Cliente := Cliente;

          if Form.ShowModal = MrOk then
          begin
            TblClientes.DisableControls;
            try
              TblClientes.Edit;

              if Form.Cliente.Ativo then
                TblClientes.FieldByName( 'ATIVO' ).AsString := 'Sim'
              else
                TblClientes.FieldByName( 'ATIVO' ).AsString := 'Não';

              TblClientes.FieldByName( 'ID' ).AsInteger         := Form.Cliente.Id;
              TblClientes.FieldByName( 'NOME' ).AsString        := Form.Cliente.Nome;
              TblClientes.FieldByName( 'TIPO_PESSOA' ).AsString := Form.Cliente.TipoPessoa.ToString;
              TblClientes.FieldByName( 'CPF' ).AsString         := Form.Cliente.CPF;
              TblClientes.FieldByName( 'CNPJ' ).AsString        := Form.Cliente.CNPJ;
              TblClientes.FieldByName( 'RG' ).AsString          := Form.Cliente.RG;
              TblClientes.FieldByName( 'IE' ).AsString          := Form.Cliente.IE;
              TblClientes.FieldByName( 'DATA' ).AsDateTime      := Form.Cliente.Data;

              TblClientes.Post;
            finally
              TblClientes.EnableControls;
            end;
          end;

        finally
          Form.Free;
        end;
      end;

    finally
      Clientes.Free;
    end;

  finally
    Filtro.Free;
  end;
end;

procedure TFrmPesquisaCliente.BtnEccluirClick( Sender: TObject );
var
  Filtro: TDictionary< string, string >;
begin
  if TblClientes.IsEmpty or ( TblClientes.RecNo < 1 ) then
    raise Exception.Create( 'Selecione um cliente para poder excluir' );

  if MessageDlg( 'Você tem certeza que deseja excluir o cliente selecionado?', MtConfirmation, [ MbYes, MbNo ], 0 ) = MrYes then
  begin
    Filtro := TDictionary< string, string >.Create;
    try
      Filtro.Add( 'ID', TblClientes.FieldByName( 'ID' ).AsString );

      if FControleCliente.Deletar( Filtro ) then
        TblClientes.Delete;
    finally
      Filtro.Free;
    end;
  end;
end;

procedure TFrmPesquisaCliente.BtnIncluirClick( Sender: TObject );
var
  Form: TFrmCadastroCliente;
begin
  Form := TFrmCadastroCliente.Create( nil );
  try
    Form.Status  := TsInclusao;
    Form.Cliente := TCliente.Create;
    try
      if Form.ShowModal = MrOk then
      begin
        TblClientes.DisableControls;
        try
          TblClientes.Append;

          if Form.Cliente.Ativo then
            TblClientes.FieldByName( 'ATIVO' ).AsString := 'Sim'
          else
            TblClientes.FieldByName( 'ATIVO' ).AsString := 'Não';

          TblClientes.FieldByName( 'ID' ).AsInteger         := Form.Cliente.Id;
          TblClientes.FieldByName( 'NOME' ).AsString        := Form.Cliente.Nome;
          TblClientes.FieldByName( 'TIPO_PESSOA' ).AsString := Form.Cliente.TipoPessoa.ToString;
          TblClientes.FieldByName( 'CPF' ).AsString         := Form.Cliente.CPF;
          TblClientes.FieldByName( 'CNPJ' ).AsString        := Form.Cliente.CNPJ;
          TblClientes.FieldByName( 'RG' ).AsString          := Form.Cliente.RG;
          TblClientes.FieldByName( 'IE' ).AsString          := Form.Cliente.IE;
          TblClientes.FieldByName( 'DATA' ).AsDateTime      := Form.Cliente.Data;

          TblClientes.Post;
        finally
          TblClientes.EnableControls;
        end;
      end;
    finally
      Form.Cliente.Free;
    end;
  finally
    Form.Free;
  end;
end;

procedure TFrmPesquisaCliente.BtnFiltrarClick( Sender: TObject );
var
  I:      Integer;
  Lista:  TObjectList< TCliente >;
  Filtro: TDictionary< string, string >;
begin
  if ValidarPesquisa then
  begin
    Filtro := TDictionary< string, string >.Create;
    try
      if CbxCampo.ItemIndex > 0 then
        Filtro.Add( CbxCampo.Text, EdtPesquisa.Text );

      if ChkAtivos.Checked then
        Filtro.Add( 'ATIVO', 'True' );

      Lista := FControleCliente.Consultar( Filtro );
      try
        TblClientes.DisableControls;
        try
          TblClientes.EmptyDataSet;

          if Assigned( Lista ) then
          begin
            for I := 0 to Lista.Count - 1 do
            begin
              TblClientes.Append;

              if Lista.Items[ I ].Ativo then
                TblClientes.FieldByName( 'ATIVO' ).AsString := 'Sim'
              else
                TblClientes.FieldByName( 'ATIVO' ).AsString := 'Não';

              TblClientes.FieldByName( 'ID' ).AsInteger         := Lista.Items[ I ].Id;
              TblClientes.FieldByName( 'NOME' ).AsString        := Lista.Items[ I ].Nome;
              TblClientes.FieldByName( 'TIPO_PESSOA' ).AsString := Lista.Items[ I ].TipoPessoa.ToString;
              TblClientes.FieldByName( 'CPF' ).AsString         := Lista.Items[ I ].CPF;
              TblClientes.FieldByName( 'CNPJ' ).AsString        := Lista.Items[ I ].CNPJ;
              TblClientes.FieldByName( 'RG' ).AsString          := Lista.Items[ I ].RG;
              TblClientes.FieldByName( 'IE' ).AsString          := Lista.Items[ I ].IE;
              TblClientes.FieldByName( 'DATA' ).AsDateTime      := Lista.Items[ I ].Data;

              TblClientes.Post;
            end;
          end;

        finally
          TblClientes.EnableControls;
        end;

      finally
        Lista.Free;
      end;

    finally
      Filtro.Free;
    end;
  end;
end;

constructor TFrmPesquisaCliente.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FControleCliente := TControleCliente.Create;
end;

procedure TFrmPesquisaCliente.FormCreate( Sender: TObject );
var
  I: Integer;
begin
  TblClientes.CreateDataSet;

  CbxCampo.Items.Add( '' );

  for I := 1 to TblClientes.FieldCount - 1 do
  begin
    if TblClientes.Fields[ I ].Visible then
      CbxCampo.Items.Add( TblClientes.Fields[ I ].DisplayLabel );
  end;

  CbxCampo.ItemIndex := 1;
end;

function TFrmPesquisaCliente.ValidarPesquisa: Boolean;
begin
  if CbxCampo.ItemIndex > 0 then
  begin
    if Trim( EdtPesquisa.Text ) = '' then
      raise Exception.Create( 'Digite a pesquisa corretamente.' );
  end;

  Result := True;
end;

destructor TFrmPesquisaCliente.Destroy;
begin
  FControleCliente.Free;
  inherited Destroy;
end;

end.
