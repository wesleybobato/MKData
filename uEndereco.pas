unit uEndereco;

interface

type
  TEndereco = class
  private
    { Private declarations }
    FLogradouro: string;
    FBairro:     string;
    FCep:        string;
    FId:         Integer;
    FNumero:     string;
    FCidade:     string;
    FPais:       string;
    FEstado:     string;
    FIdCliente:  Integer;
  public
    { Public declarations }
    property Id:         Integer read FId write FId;
    property IdCliente:  Integer read FIdCliente write FIdCliente;
    property Logradouro: string read FLogradouro write FLogradouro;
    property Numero:     string read FNumero write FNumero;
    property Cep:        string read FCep write FCep;
    property Bairro:     string read FBairro write FBairro;
    property Cidade:     string read FCidade write FCidade;
    property Estado:     string read FEstado write FEstado;
    property Pais:       string read FPais write FPais;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TEndereco }

constructor TEndereco.Create;
begin
  inherited Create;
end;

destructor TEndereco.Destroy;
begin
  inherited Destroy;
end;

end.
