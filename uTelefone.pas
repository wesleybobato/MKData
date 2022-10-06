unit uTelefone;

interface

type
  TTelefone = class
  private
    { Private declarations }
    FDDD:       string;
    FId:        Integer;
    FTelefone:  string;
    FIdCliente: Integer;
  public
    { Public declarations }
    property Id:        Integer read FId write FId;
    property IdCliente: Integer read FIdCliente write FIdCliente;
    property DDD:       string read FDDD write FDDD;
    property Telefone:  string read FTelefone write FTelefone;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TTelefone }

constructor TTelefone.Create;
begin
  inherited Create;
end;

destructor TTelefone.Destroy;
begin
  inherited Destroy;
end;

end.
