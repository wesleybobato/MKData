unit uCliente;

interface

uses
  // System
  System.Generics.Defaults,
  System.Generics.Collections,

  // Self
  UTelefone,
  UEndereco;

type
  TTipoPessoa = ( TpFisica, TpJuridica );

type
  TTipoPessoaHelper = record Helper for TTipoPessoa
  public
    { Public declarations }
    function ToString: string;
  end;

type
  TCliente = class
  private
    { Private declarations }
    FTipoPessoa: TTipoPessoa;
    FRG:         string;
    FCNPJ:       string;
    FAtivo:      Boolean;
    FCPF:        string;
    FId:         Integer;
    FIE:         string;
    FEnderecos:  TObjectList< TEndereco >;
    FTelefones:  TObjectList< TTelefone >;
    FNome:       string;
    FData:       TDate;
  public
    { Public declarations }
    property Id:         Integer read FId write FId;
    property Nome:       string read FNome write FNome;
    property TipoPessoa: TTipoPessoa read FTipoPessoa write FTipoPessoa;
    property CPF:        string read FCPF write FCPF;
    property CNPJ:       string read FCNPJ write FCNPJ;
    property RG:         string read FRG write FRG;
    property IE:         string read FIE write FIE;
    property Data:       TDate read FData write FData;
    property Ativo:      Boolean read FAtivo write FAtivo;
    property Enderecos:  TObjectList< TEndereco > read FEnderecos write FEnderecos;
    property Telefones:  TObjectList< TTelefone > read FTelefones write FTelefones;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TCliente }

constructor TCliente.Create;
begin
  inherited Create;

  FEnderecos := TObjectList< TEndereco >.Create;
  FTelefones := TObjectList< TTelefone >.Create;
end;

destructor TCliente.Destroy;
begin
  FEnderecos.Free;
  FTelefones.Free;

  inherited Destroy;
end;

{ TTipoPessoaHelper }

function TTipoPessoaHelper.ToString: string;
begin
  case Self of
    TpFisica:
      Result := 'Fisica';
    TpJuridica:
      Result := 'Juririca';
  end;
end;

end.
